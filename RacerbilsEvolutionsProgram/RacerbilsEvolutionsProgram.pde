import java.util.Arrays;
import java.util.Collections;
import java.util.Random;
//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int populationSize  = 1000;
int bestAmount = 10;
int generation = 1;

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn + 100% rød
PImage    trackImage;


GraphicalInterface gui;

void setup() {
  size(500, 600);
  frameRate(200);

  trackImage = loadImage("track.png");
  gui = new GraphicalInterface(new PVector(10, height*0.025));
}

void draw() {
  clear();
  fill(255);
  rect(-1000, -1000, 2000, 2000);
  image(trackImage, 0, 80);  
  
  carSystem.updateAndDisplay();
  fill(0);
  gui.render();

  if (frameCount == 300) {
    carSystem.newGen();
    frameCount = 0;
    generation++;
  }
}


class GraphicalInterface {
  PVector origin;

  GraphicalInterface(PVector ori) {
    this.origin = ori;
  }


  void render() {
    String out = "Frame Count: "+frameCount+ "\n" + 
                  "Framerate: " + frameRate +  "\n" + 
                  "Population Size: " + populationSize + "\n" + 
                  "Generation: "+ generation + "\n" + 
                  "Best Fitness: " + Collections.max(carSystem.CarControllerList).fitness();
    text(out, origin.x, origin.y);
  }
  
}

float sigmoid (float x){
  return (exp(x) / (exp(x) +1));
}
