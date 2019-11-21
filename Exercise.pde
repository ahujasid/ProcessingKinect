boolean pose1done = false;
boolean pose2done = false;
int step = 1;

//pose 1 flags


//pose 2 flags


void beginExercise(){
  if(!pose1done) { doPose1();  }
  else if(pose1done && !pose2done) { doPose2(); UIText = "pose 2"; }
  else { exerciseDone(); UIText = "all done!"; }
}

void doPose1(){
  
  UIText = "pose 1";
  
  switch(step){
    
    case 1:
    UIText = "inhale and raise your arms above your head";      
    break;
  
  }
    
  
  
}

void doPose2(){}

void exerciseDone() {}
