class Car {  
  //Bil - indeholder position & hastighed & "tegning"
  PVector pos = new PVector(60, 232);
  PVector vel = new PVector(0, 5);
  
  void turnCar(float turnAngle){
    vel.rotate(turnAngle);
  }

  void displayCar() {
    stroke(100);
    fill(100, 40);
    ellipse(pos.x, pos.y, 10, 10);
  }
  
  void displayCar(color col) {
    stroke(100);
    fill(col);
    ellipse(pos.x, pos.y, 10, 10);
  }
  
  void update() {
    pos.add(vel);
  }
  
  String toString(){
  return "pos: " + pos + ", vel: " +  vel;
  }
  
  
}
