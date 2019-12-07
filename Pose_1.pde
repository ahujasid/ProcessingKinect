

boolean step1done = false;
boolean step2done = false;
int step = 1;
boolean step1spoken = false;
boolean step2spoken = false;

int voiceSample = 0;

int armsCounter = 0;
int rightArmCounter = 0;
int leftArmCounter = 0;
int legsCounter = 0;
int leftLegCounter = 0;
int rightLegCounter = 0;

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



void doPose(){
  
  UIText = "pose 1";
  
  //switch(step){
    
  //  case 1:
    
    UIText = "case 1";
    
    if(step==1 && leftKnee != 1){
      voiceSample = 1;
      instructions = "left knee wrong";
    }
    
    else if(step == 1 && rightKnee != 1){
      voiceSample = 2;
      instructions = "right knee wrong";
    }
    
    else if(leftShoulder != 1 && rightShoulder != 1){
      voiceSample = 3;
      instructions = "bring your arms closer to your head, and straighten them upwards so they are pointing to the ceiling";
      step = 2;
    }
    
    else if(leftShoulder !=1)
    {
      voiceSample = 4;
      instructions = "bring your left arm closer to your head, and stretch it towards the ceiling";
      step = 2;
    }
    
    else if(rightShoulder != 1){
      voiceSample = 5;
      instructions = "bring your right arm closer to your head, and stretch it towards the ceiling";
      step = 2;
    }
    
    else if(leftElbow !=1 && rightElbow !=1){
      voiceSample = 6;
      instructions = "your elbows are bent. stretch both arms pointing straight towards the ceiling";
      step = 2;
    }
    
    else if(leftElbow !=1){
      voiceSample = 7;
      instructions = "your left elbow is bent. straighten it so your arm is pointing straight towards the ceiling";
      step = 2;
    }
    
    else if(rightElbow!=1){
      voiceSample = 8;
      instructions = "your right elbow is bent. straighten it so your arm is pointing straight towards the ceiling";
      step = 2;
    }
    
 
    
    //else if(spine!=1){
    //  voiceSample = 10;
    //  instructions = "spine wrong";
    //}    
    
    else{ 
      voiceSample = 9;
      //playDoneSound(1);
      instructions = "all good!";
      resetPose();
    }
    
    //case 2:
    //UIText = "case 2";
    //voiceSample = 2;
    //break;
  
}

void exerciseDone() {}


void setFlagsPose1(){
  
  //if(step == 1 && !step1done)
  
  if(AngleLeftShoulder > 130  || AngleLeftShoulderWithY > 30) leftShoulder = 0;
  else leftShoulder = 1;
  
  if(AngleLeftElbow < 160) leftElbow = 0;
  else leftElbow = 1;
  
  if(AngleRightShoulder > 130 || AngleRightShoulderWithY > 30) rightShoulder = 0;
  else rightShoulder = 1;
  
  if(AngleRightElbow < 160) rightElbow = 0;
  else rightElbow = 1;
  
  
  if(AngleNeck < 160) neck = 0;
  else neck = 1;
  
  if(AngleSpineMid < 160) spine = 0;
  else spine = 1;
  
  if(AngleLeftKnee > 120) leftKnee = -1;
  else leftKnee = 1;
  ra = String.valueOf(leftKnee);
  
  if(AngleRightKnee < 130) rightKnee = -1;
  else rightKnee = 1;

  
}

void mouseClicked(){
  
  if(step==1 && !step1spoken){
    step1.trigger();
    step1spoken = true;
  }
  
  else if(step ==2 && !step2spoken){
    step2.trigger();
    step2spoken = true;
  }
  
  else{
  
    switch(voiceSample) {
      case 0:
      break;
      
      case 1:
      sample1.trigger();
      counter[1]++;
      break;
      
      case 2:
      sample2.trigger();
      counter[2]++;
      break;
      
      case 3:
      sample3.trigger();
      counter[3]++;
      break;
      
      case 4:
      sample4.trigger();
      counter[4]++;
      break;
      
      case 5:
      sample5.trigger();
      counter[5]++;
      break;
      
      case 6:
      sample6.trigger();
      counter[6]++;
      break;
      
      case 7:
      sample7.trigger();
      counter[7]++;
      break;
      
      case 8:
      sample8.trigger();
      counter[8]++;
      break;
      
      case 9:
      sample9.trigger();
      counter[9]++;
      break;
      
    } 
  }
}

void keyPressed(){
    if(keyCode == RIGHT){
    voiceSample++;
  }
  
  if(key== '1'){
    step1.trigger();
  }
  
  if(key == '2'){
    step2.trigger();
  }
  
  if(keyCode == LEFT){
    voiceSample--;
  }
  
  if(key == 'r'){
    resetPose();
  }
  
}

void playDoneSound(int index){
  switch(index){
    case 1:
    sample1.trigger();
  }
}

void resetPose(){
   step1done = false;
   step2done = false;
   step = 1;
   step1spoken = false;
   step2spoken = false;
   voiceSample = 0;
}
