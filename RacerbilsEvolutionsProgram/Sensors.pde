class SensorSystem {
  //SensorSystem - alle bilens sensorer - ogå dem der ikke bruges af "hjernen"

  //wall detectors
  float sensorMag = 50;
  float sensorAngle = PI*2/8;

  PVector anchorPos           = new PVector();

  PVector sensorVectorFront   = new PVector(0, sensorMag);
  PVector sensorVectorLeft    = new PVector(0, sensorMag);
  PVector sensorVectorRight   = new PVector(0, sensorMag);

  float frontSensorSignal;
  float leftSensorSignal;
  float rightSensorSignal;

  //crash detection
  int whiteSensorFrameCount    = 0; //udenfor banen

  //clockwise rotation detection
  PVector centerToCarVector     = new PVector();
  float   lastRotationAngle   = -1;
  float   clockWiseRotationFrameCounter  = 0;

  //lapTime calculation
  boolean lastGreenDetection;
  boolean lastRedDetection;
  int     lastTimeInFrames      = 0;
  int     lapTimeInFrames       = 10000;

  int timesCrossed = 0;
  
  void displaySensors() {
    strokeWeight(2);
     fill(250);

    PVector frontCollisionVector = PVector.mult(sensorVectorFront.normalize(), this.disToWall(sensorVectorFront, anchorPos));
    PVector leftCollisionVector = PVector.mult(sensorVectorLeft.normalize(), this.disToWall(sensorVectorLeft, anchorPos));
    PVector rightCollisionVector = PVector.mult(sensorVectorRight.normalize(), this.disToWall(sensorVectorRight, anchorPos));
    
    line(anchorPos.x, anchorPos.y, anchorPos.x + frontCollisionVector.x, anchorPos.y + frontCollisionVector.y);
    line(anchorPos.x, anchorPos.y, anchorPos.x + leftCollisionVector.x, anchorPos.y + leftCollisionVector.y);
    line(anchorPos.x, anchorPos.y, anchorPos.x + rightCollisionVector.x, anchorPos.y + rightCollisionVector.y);
    
    fill(100);
    point(anchorPos.x + frontCollisionVector.x, anchorPos.y + frontCollisionVector.y);
    point(anchorPos.x + leftCollisionVector.x,  anchorPos.y + leftCollisionVector.y);
    point(anchorPos.x + rightCollisionVector.x, anchorPos.y + rightCollisionVector.y);
  }

  float disToWall(PVector direction, PVector startPos) {
    PVector normDirection = direction.normalize();
    
    for (int vectorMag =1; vectorMag <= max(height, width); vectorMag++) {
      direction = PVector.mult(normDirection, vectorMag);
      //strokeWeight(3);
           
      if (get(int(startPos.x+direction.x), int(startPos.y+direction.y))==-1) {
        //stroke(#00ffff);
        //line(startPos.x, startPos.y, startPos.x+direction.x,startPos.y+direction.y);
        //stroke(#0000ff);
        //point(startPos.x+direction.x,startPos.y+direction.y);
        return direction.mag();
      }
      
    }
    return 0;
  }

  void updateSensorsignals(PVector pos, PVector vel) {
    //Collision detectors
    //frontSensorSignal = get(int(pos.x+sensorVectorFront.x), int(pos.y+sensorVectorFront.y))==-1?true:false;
    //leftSensorSignal = get(int(pos.x+sensorVectorLeft.x), int(pos.y+sensorVectorLeft.y))==-1?true:false;
    //rightSensorSignal = get(int(pos.x+sensorVectorRight.x), int(pos.y+sensorVectorRight.y))==-1?true:false;  
    
    frontSensorSignal   = disToWall(sensorVectorFront, pos);
    leftSensorSignal    = disToWall(sensorVectorLeft, pos);
    rightSensorSignal   = disToWall(sensorVectorRight, pos);
    
    //Crash detector
    color color_car_position = get(int(pos.x), int(pos.y));
    if (color_car_position ==-1) {
      whiteSensorFrameCount = whiteSensorFrameCount+1;
    }
    //Laptime calculation
    boolean currentGreenDetection =false;
    if (red(color_car_position)==0 && blue(color_car_position)==0 && green(color_car_position)!=0) {//den grønne målstreg er detekteret
      currentGreenDetection = true;
    }
    boolean currentRedDetection = false;
    if(red(color_car_position)!=0 && blue(color_car_position)==0 && green(color_car_position)==0) {
      currentRedDetection = true;
    }
    
    //check which way the car passed the finish line
    if(lastRedDetection && currentGreenDetection) {
      timesCrossed--;
    } else if(currentRedDetection && lastGreenDetection) {
      timesCrossed++;
    }
    
    if (lastGreenDetection && !currentGreenDetection) {  //sidst grønt & nu ikke => vi har passeret målstregen 
      lapTimeInFrames = frameCount - lastTimeInFrames; //LAPTIME BEREGNES - frames nu - frames sidst
      lastTimeInFrames = frameCount;
    }   
    lastGreenDetection = currentGreenDetection; //Husker om der var grønt sidst
    lastRedDetection = currentRedDetection;
    //count clockWiseRotationFrameCounter
    centerToCarVector.set((height/2)-pos.x, (width/2)-pos.y);    
    float currentRotationAngle =  centerToCarVector.heading();
    float deltaHeading   =  lastRotationAngle - centerToCarVector.heading();
    clockWiseRotationFrameCounter  =  deltaHeading>0 ? clockWiseRotationFrameCounter + 1 : clockWiseRotationFrameCounter -1; 

    lastRotationAngle = currentRotationAngle;

    updateSensorVectors(vel);

    anchorPos.set(pos.x, pos.y);
  }

  void updateSensorVectors(PVector vel) {
    if (vel.mag()!=0) {
      sensorVectorFront.set(vel);
      sensorVectorFront.normalize();
      sensorVectorFront.mult(sensorMag);
    }
    sensorVectorLeft.set(sensorVectorFront);
    sensorVectorLeft.rotate(-sensorAngle);
    sensorVectorRight.set(sensorVectorFront);
    sensorVectorRight.rotate(sensorAngle);
  }
}
