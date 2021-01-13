import java.util.Arrays;
import java.util.Collections;
import java.util.Random;
//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int       populationSize  = 10;     

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

void setup() {
  size(500, 600);
  frameRate(10);
  //size(700, 600);

  trackImage = loadImage("track.png");
}

void draw(){
  clear();
  fill(255);
  rect(-1000, -1000, 2000, 2000);
  image(trackImage, 0, 80);  

  carSystem.updateAndDisplay();

  if (frameCount == 500) {
    //carSystem.selectCars();
    //noLoop();
    carSystem.newGen();
    frameCount = 0;
  }

  //TESTKODE: Frastortering af dårlige biler, for hver gang der går 200 frame - f.eks. dem der kører uden for banen
  /* if (frameCount%200==0) {
   println("FJERN DEM DER KØRER UDENFOR BANEN frameCount: " + frameCount);
   for (int i = carSystem.CarControllerList.size()-1 ; i >= 0;  i--) {
   SensorSystem s = carSystem.CarControllerList.get(i).sensorSystem;
   if(s.whiteSensorFrameCount > 0){
   carSystem.CarControllerList.remove(carSystem.CarControllerList.get(i));
   }
   }
   }*/
  //
}

float sigmoid (float x){
  //x = abs(x);
  //return x;
  return (exp(x) / (exp(x) +1));
  
  //return x / (sqrt(1+x));
  
}
