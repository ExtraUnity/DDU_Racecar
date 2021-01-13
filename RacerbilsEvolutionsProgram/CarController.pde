class CarController implements Comparable <CarController>{
  //Forbinder - Sensorer & Hjerne & Bil
  float varians             = 2; //hvor stor er variansen på de tilfældige vægte og bias
  Car bil                    = new Car();
  NeuralNetwork hjerne       = new NeuralNetwork(varians); 
  SensorSystem  sensorSystem = new SensorSystem();
  float _fitness = -1;
  
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
    float x1 = sensorSystem.leftSensorSignal;
    float x2 = sensorSystem.frontSensorSignal;
    float x3 = sensorSystem.rightSensorSignal;    
    turnAngle = hjerne.getOutput(x1, x2, x3);    
    //4.)bilen drejes
    bil.turnCar(turnAngle);
  }

  void display() {
    bil.displayCar();
    //sensorSystem.displaySensors();
  }

  float fitness() {
    // high fitness is good.
    return -9* sensorSystem.whiteSensorFrameCount +3* sensorSystem.clockWiseRotationFrameCounter;
   
  }
  
  float getFitness() {
    return fitness();
  }
  
  int compareTo(CarController other){
    return round((this.getFitness() - other.getFitness()));
  
  }
  
}
