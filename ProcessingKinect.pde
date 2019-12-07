
/*
Thomas Sanchez Lengeling.
 http://codigogenerativo.com/

 KinectPV2, Kinect for Windows v2 library for processing

 Skeleton color map example.
 Skeleton (x,y) positions are mapped to match the color Frame
 */

import KinectPV2.KJoint;
import KinectPV2.*;
//import processing.sound.*;
import ddf.minim.*;

KinectPV2 kinect;

String UIText = "click mouse to start";
String instructions = "instructions";
String ls = "-"; String rs="-"; String la = "-"; String ra="-";

int counter[]  = {0,0,0,0,0,0,0,0,0,0};

Minim minim;
AudioSample sample1;
AudioSample sample2;
AudioSample sample3;
AudioSample sample4;
AudioSample sample5;
AudioSample sample6;
AudioSample sample7;
AudioSample sample8;
AudioSample sample9;

AudioSample step0;
AudioSample step1;
AudioSample step2;

static int leftKneeWrong = 1;
static int rightKneeWrong = 2;
static int bothShouldersWrong = 3;
static int rightShoulderWrong = 4;
static int leftShoulderWrong = 5;
static int bothElbowsWrong = 6;
static int rightElbowWrong = 7;
static int leftElbowWrong = 8;
static int allGood = 9;

float AngleNeck;
float AngleSpineTop;
float AngleSpineMid;
float AngleHips;
float AngleShoulders;
float AngleRightShoulder;
float AngleRightElbow;
float AngleLeftShoulder;
float AngleLeftElbow;
float AngleRightHip;
float AngleRightKnee;
float AngleLeftHip;
float AngleLeftKnee;
float AngleRightShoulderWithY;
float AngleRightElbowWithY;
float AngleLeftShoulderWithY;
float AngleLeftElbowWithY;


void setup() {
  size(1920, 1080, P3D);

  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

  kinect.init();
  
  setUpSoundFiles();
  
}

void draw() {
  background(0);
  
  image(kinect.getColorImage(), 0, 0, width, height);
  
  pushMatrix();
  translate(50,height-200);
  fill(0,0,0,160);
  rect(0,0, width, 40);
  fill(255,255,255);
  text(instructions, 0,20);
  popMatrix();
  text(UIText, 1920 - 200, 50);
  text(ls, 1920 - 200, 80);
  text(la, 1920 - 200, 110);
  text(rs, 1920 - 200, 140);
  text(ra, 1920 - 200, 170);

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      drawBody(joints);

      //draw different color for each hand state
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);

    }
  }

  fill(255, 0, 0);
  text(frameRate, 50, 50);
  
   setFlagsPose1();
   doPose();
}

//DRAW BODY
void drawBody(KJoint[] joints) {
  
  //Head to Spine
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  AngleNeck = showAngle(joints,KinectPV2.JointType_Head, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder,0,0);
  AngleSpineTop = showAngle(joints,KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid,0,0);
  AngleSpineMid = showAngle(joints,KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase,0,0);
  
  //Spine to Shoulders & Spine to Hip
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);
  //AngleShoulders = showAngle(joints,KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft,20,0);
  AngleHips = showAngle(joints,KinectPV2.JointType_HipLeft, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight,0,0);

  // Right Arm
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight); 
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);
  AngleRightShoulder = showAngle(joints,KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight,0,0);
  AngleRightElbow = showAngle(joints,KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight,0,0);

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);
  AngleLeftShoulder = showAngle(joints,KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft,0,0);
  AngleLeftElbow = showAngle(joints,KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft,0,0);

  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);
  AngleRightHip = showAngle(joints,KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight,20,0);
  AngleRightKnee = showAngle(joints,KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight, KinectPV2.JointType_FootRight,0,0);
  
  PVector YUpVector = new PVector(0.0,1.0,0.0);
  
  AngleRightShoulderWithY = calcAngleWithVectors(joints,KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight, YUpVector); 
  AngleLeftShoulderWithY = calcAngleWithVectors(joints,KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft,  YUpVector);
  AngleLeftElbowWithY = calcAngleWithVectors(joints,KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft,  YUpVector);
  AngleRightElbowWithY = calcAngleWithVectors(joints,KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight,  YUpVector);
  
    
  la = String.valueOf(AngleLeftKnee);
  //ra = String.valueOf(AngleRightElbowWithY);
  ls = String.valueOf(AngleLeftShoulderWithY);
  rs = String.valueOf(AngleRightShoulderWithY);
  
  

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);
  AngleLeftHip = showAngle(joints,KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft,-20,0);
  AngleLeftKnee = showAngle(joints,KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_FootLeft,0,0);

  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
  
}

//draw joint
void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}

//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

//draw hand state
void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
  ellipse(0, 0, 70, 70);
  popMatrix();
}

/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */
void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    break;
  }
}


float showAngle(KJoint[] joints, int jointType1, int jointType2, int jointType3, int xoffset, int yoffset){
  PVector v1 = new PVector(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  PVector v2 = new PVector(joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
  PVector v3 = new PVector(joints[jointType3].getX(), joints[jointType3].getY(), joints[jointType3].getZ());
  v3 = v3.sub(v2);
  v2 = v2.sub(v1);
  float angle = PVector.angleBetween(v2,v3)*180/PI;
  angle = 180 - angle;
  pushMatrix();
  textSize(24);
  fill(255,255,255);
  text(angle,joints[jointType2].getX() + xoffset, joints[jointType2].getY() + yoffset, joints[jointType2].getZ());
  popMatrix();
  return angle;
}

float calcAngleWithVectors(KJoint[] joints, int jointType1, int jointType2, PVector vector){
  PVector v1 = new PVector(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  PVector v2 = new PVector(joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
  v2 = v2.sub(v1);
  v2.normalize();
  float angle = PVector.angleBetween(v2,vector)*180/PI;
  angle = 180-angle;
  return angle;
}

void setUpSoundFiles(){
  
  minim = new Minim(this);
  sample1 = minim.loadSample("1.mp3");
  sample2 = minim.loadSample("2.mp3");
  sample3 = minim.loadSample("3.mp3");
  sample4 = minim.loadSample("4.mp3");
  sample5 = minim.loadSample("5.mp3");
  sample6 = minim.loadSample("6.mp3");
  sample7 = minim.loadSample("7.mp3");
  sample8 = minim.loadSample("8.mp3");
  sample9 = minim.loadSample("9.mp3");
  
  step1 = minim.loadSample("step1.mp3");
  step2 = minim.loadSample("step2.mp3");
}
