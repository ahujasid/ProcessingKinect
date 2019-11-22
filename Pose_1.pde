

boolean pose1done = false;
boolean pose2done = false;
int step = 1;
int voiceSample = 0;

//pose 1 flag
int leftElbow;
int leftShoulder;
int rightElbow;
int rightShoulder;
int neck;
int spine;


//pose 2 flags


void beginExercise(){
  
  if(!pose1done) { setFlagsPose1(); doPose1();  }
  else if(pose1done && !pose2done) { doPose2(); }
  else { exerciseDone();  }
}

void doPose1(){
  
  UIText = "pose 1";
  
  switch(step){
    
    case 1:
    UIText = "case 1";
    voiceSample = 1;
    if(leftShoulder == 0 && rightShoulder == 0) step = 2;
    break;
    
    case 2:
    UIText = "case 2";
    voiceSample = 2;
    break;
  
  }
    
  
  
}

void doPose2(){}

void exerciseDone() {}


void setFlagsPose1(){
  
  if(AngleLeftShoulder > 130) leftShoulder = -1;
  else if(AngleLeftShoulder < 90) leftShoulder = 1;
  else leftShoulder = 0;
  
  if(AngleLeftElbow < 160) leftElbow = -1;
  else leftElbow = 0;
  
  if(AngleRightShoulder > 130) rightShoulder = -1;
  else if(AngleRightShoulder < 90) rightShoulder = 1;
  else rightShoulder = 0;
  
  if(AngleRightElbow < 160) rightElbow = -1;
  else rightElbow = 0;
  
  
  if(AngleNeck < 160) neck = -1;
  else neck = 0;
  
  if(AngleSpineMid < 160) spine = -1;
  else spine = 0;
  
  la = String.valueOf(AngleLeftShoulder);
  ra = String.valueOf(AngleRightShoulder);
  ls = String.valueOf(leftShoulder);
  rs = String.valueOf(rightShoulder);
  
}

void keyPressed(){
  
  switch(voiceSample) {
    case 0:
    break;
    
    case 1:
    sample1.trigger();
    break;
    
    case 2:
    sample1.trigger();
    break;
    
    case 3:
    sample3.trigger();
    break;
    
  }
}
