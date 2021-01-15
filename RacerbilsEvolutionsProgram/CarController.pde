class CarController implements Comparable <CarController>{
  //Forbinder - Sensorer & Hjerne & Bil
  float varians             = 2; //hvor stor er variansen på de tilfældige vægte og bias
  Car bil                    = new Car();
  NeuralNetwork hjerne       = new NeuralNetwork(varians); 
  SensorSystem  sensorSystem = new SensorSystem();
  
  CarController(){}
  
  CarController(NeuralNetwork nn){
    this.hjerne = nn;
  }

  void update() {
    //1.)opdtarer bil 
    bil.update();
    //2.)opdaterer sensorer    
    sensorSystem.updateSensorsignals(bil.pos, bil.vel);
    //3.)hjernen beregner hvor meget der skal drejes
    float turnAngle = 0;
    float x1 = (sensorSystem.leftSensorSignal);
    float x2 = (sensorSystem.frontSensorSignal);
    float x3 = (sensorSystem.rightSensorSignal);  
    //println(x1);
    turnAngle = hjerne.getOutput(x1, x2, x3);    
    //4.)bilen drejes
    bil.turnCar(turnAngle);
  }

  void display() {
    bil.displayCar();
    //sensorSystem.displaySensors();
  }
  void display(color c) {
    bil.displayCar(c);
    //println(sensorSystem.timesCrossed);
    //sensorSystem.displaySensors();
  }

  float fitness() {
    // high fitness is good.
    if(sensorSystem.clockWiseRotationFrameCounter<0 && (sensorSystem.timesCrossed+1)<0) {
      return sensorSystem.clockWiseRotationFrameCounter*(sensorSystem.timesCrossed+1);
    }
      return (-sensorSystem.clockWiseRotationFrameCounter)*(sensorSystem.timesCrossed+1);
  }
  
  float getFitness() {
    return fitness();
  }
  
  int compareTo(CarController other){
    return round((this.getFitness() - other.getFitness()));
  
  }
  
}
