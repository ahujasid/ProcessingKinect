boolean pose1done = false;
boolean pose2done = false;
int step = 1;

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
    UIText = "inhale and raise your arms above your head";
    
    break;
    
    case 2:
    
    break;
  
  }
    
  
  
}

void doPose2(){}

void exerciseDone() {}


void setFlagsPose1(){
  if(AngleLeftShoulder > 90) leftShoulder = -1;
  else if(AngleLeftShoulder < 30) leftShoulder = 1;
  else leftShoulder = 0;
  
  if(AngleLeftElbow < 160) leftShoulder = -1;
  else leftShoulder = 0;
  
  if(AngleRightShoulder > 90) leftShoulder = -1;
  else if(AngleLeftShoulder < 30) leftShoulder = 1;
  else leftShoulder = 0;
  
  if(AngleRightElbow < 160) leftShoulder = -1;
  else leftShoulder = 0;
  
  
  if(AngleNeck < 160) neck = -1;
  else neck = 0;
  
  if(AngleSpineMid < 160) spine = -1;
  else spine = 0;
  
 
}
