

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
int leftKnee;
int rightKnee;


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
    
    if(leftShoulder !=1 && rightShoulder != 1 && leftElbow != 1 && rightElbow != 1) 
    {
       voiceSample = 1;
       instructions = "raise your hands above yo head";
    }
    
    else if(leftShoulder != 1 && rightShoulder != 1){
      voiceSample = 2;
      instructions = "both shoulders wrong";
    }
    
    else if(leftShoulder !=1)
    {
      voiceSample = 3;
      instructions = "left shoulder wrong";
    }
    
    else if(rightShoulder != 1){
      voiceSample = 4;
      instructions = "right shoulder wrong";
    }
    
    else if(leftElbow !=1 && rightElbow !=1){
      voiceSample = 5;
      instructions = "both elbows wrong";
    }
    
    else if(leftElbow !=1){
      voiceSample = 6;
      instructions = "left elbow wrong";
    }
    
    else if(rightElbow!=1){
      voiceSample = 7;
      instructions = "right elbow wrong";
    }
    
    else if(rightKnee !=1){
      voiceSample = 8;
      instructions = "right knee wrong";
    }
    
    else if(leftKnee != 1){
      voiceSample = 9;
      instructions = "left knee wrong";
    }
    
    else if(spine!=1){
      voiceSample = 10;
      instructions = "spine wrong";
    }    
    
    
    
    else{ 
      voiceSample = 11;
      playDoneSound(1);
      instructions = "all good!";
    }
    
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
  else if(AngleLeftShoulder < 90) leftShoulder = 0;
  else leftShoulder = 1;
  
  if(AngleLeftElbow < 160) leftElbow = 0;
  else leftElbow = 1;
  
  if(AngleRightShoulder > 130) rightShoulder = 0;
  else if(AngleRightShoulder < 90) rightShoulder = -1;
  else rightShoulder = 1;
  
  if(AngleRightElbow < 160) rightElbow = 0;
  else rightElbow = 1;
  
  
  if(AngleNeck < 160) neck = 0;
  else neck = 1;
  
  if(AngleSpineMid < 160) spine = 0;
  else spine = 1;
  
  if(AngleLeftKnee > 120) leftKnee = -1;
  else leftKnee = 1;
  
  if(AngleLeftKnee < 160) rightKnee = -1;
  else rightKnee = 1;
  
  la = String.valueOf(AngleLeftShoulder);
  ra = String.valueOf(AngleRightShoulder);
  ls = String.valueOf(leftShoulder);
  rs = String.valueOf(rightShoulder);
  
}

void keyPressed(){
  
  if(keyCode == RIGHT){
    voiceSample++;
  }
  
  if(keyCode == LEFT){
    voiceSample--;
  }
  
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

void playDoneSound(int index){
  switch(index){
    case 1:
    sample1.trigger();
  }
}
