class NeuralNetwork {
  //All weights
  float[] weights = {1,1,0,0,1,1,-2,2};//new float[8];
  
    //Naming convention w{layer number}_{from neuron number}_{to neuron number}
    // layer 1, 2 hidden neurons: w0_11=w[0], w0_21=w[1], w0_31=w[2] 
    //                            w0_12=w[3], w0_22=w[4], w0_32=w[5]
    // layer 2, 1 output neuron : w1_11=w[6], w1_21=w[7] 
  
  //All biases
  float[] biases = {0,0,0};//new float[3];
    //Naming convention b{layer number}_{neuron number}
    // layer 1, 2 hidden neurons: b2_1=b[0], b2_2=b[1]
    // layer 2, 1 output neuron : b3_1=b[2]
  
  NeuralNetwork(float varians){
    for(int i=0; i < weights.length -1; i++){
     weights[i] = random(-varians,varians);
    }
    for(int i=0; i < biases.length -1; i++){
     biases[i] = random(-varians,varians);
    }    
  }

  float getOutput(float x1, float x2, float x3) {
    
    x1 = (1/x1);
    x2 = (1/x2);
    x3 = (1/x3);
    
     //layer1
    float o11 = sigmoid(weights[0]*x1+ weights[1]*x2 + weights[2]*x3 + biases[0]);
    float o12 = sigmoid(weights[3]*x1+ weights[4]*x2 + weights[5]*x3 + biases[1]);
    //layer2

    println(o11*weights[6] + o12*weights[7] + biases[2], TAU*sigmoid(o11*weights[6] + o12*weights[7] + biases[2]) - PI);
    return TAU*sigmoid(o11*weights[6] + o12*weights[7] + biases[2]) - PI;
  }
  
  String toString(){
    return "Wei: " + Arrays.toString(this.weights) + " bia: " + Arrays.toString(this.biases);
  }
}


    //if(x1 == 1 && x2 == 1){
    //  return 0.2;
    //} else if(x1 == 1) {
    //  return 0.2;
    //} else if(x3 == 1 && x2 == 1) {
    //  return -0.2;
    //} else if(x3 == 1) {
    //  return -0.1;
    //} else if(x1 == 1 && x2 == 1 && x3 == 1) {
    //  return 0.2;
    //} else {
    //  return 0;
    //}
