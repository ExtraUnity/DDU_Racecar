class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser

  ArrayList<CarController> CarControllerList  = new ArrayList<CarController>();
  float mutationIntensity  = 0.1;

  CarSystem(int populationSize) {
    for (int i=0; i<populationSize; i++) { 
      CarController controller = new CarController();
      CarControllerList.add(controller);
    }
  }

  void updateAndDisplay() { 
    //1.) Opdaterer sensorer og bilpositioner
    for (CarController controller : CarControllerList) {


      if (controller.sensorSystem.whiteSensorFrameCount ==0) {
        controller.update();
      }
    }

    //2.) Tegner tilsidst - så sensorer kun ser banen og ikke andre biler!
    for (CarController controller : CarControllerList) {
      controller.display();
    }
    Collections.max(CarControllerList).display(color(#00ff00));
  }

  void newGen() {
    CarControllerList = nextGen(selectCars());
  }

  CarController[] selectCars() {
    Collections.sort(CarControllerList);
    //CarControllerList.get(CarControllerList.size() -1).bil.displayCar(color(#00ff00));
    //println(CarControllerList.get(CarControllerList.size() -1).bil.toString());
    //CarControllerList.get(0).bil.displayCar(color(#ff0000));
    //for(CarController q : CarControllerList){
    //  println(q.getFitness());
    //}

    CarController[] temp = new CarController[1]; // the top n best cars are selected.

    for (int i = CarControllerList.size() -1; i>CarControllerList.size()-1 -temp.length; i--) {
      //print(CarControllerList.get(i).getFitness() +", ");
      temp[CarControllerList.size() -1 - i] = CarControllerList.get(i);
    }
    return temp;
  }

  ArrayList<CarController> nextGen (CarController[] input) {
    ArrayList<CarController> temp  = new ArrayList<CarController>();
    for (int i = 0; i<input.length; i++) {
      CarController best = new CarController();
      best.hjerne = input[i].hjerne;
      temp.add(best);
    }
    for (int i = 0; i < input.length; i++) {
      for (int j = 0; j<(int)populationSize/input.length-input.length; j++) {
        temp.add(mutation(input[i]));
      }
    }
    return temp;
  }

  CarController mutation(CarController car) {

    CarController temp = new CarController();

    for (int i = 0; i<car.hjerne.weights.length; i++ ) {
      temp.hjerne.weights[i] = car.hjerne.weights[i] * random(1-mutationIntensity, 1+mutationIntensity)* (random(1)>0.01?1:-1);
    }

    for (int i = 0; i<car.hjerne.biases.length; i++ ) {
      temp.hjerne.biases[i] = car.hjerne.biases[i] * random(1-mutationIntensity, 1+mutationIntensity) * (random(1)>0.01?1:-1);
    }

    return temp;
  }
}
