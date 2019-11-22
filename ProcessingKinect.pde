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
String ls = "-"; String rs="-"; String la = "-"; String ra="-";

Minim minim;
AudioSample sample1;
AudioSample sample2;
AudioSample sample3;

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
  
   beginExercise();
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

void setUpSoundFiles(){
  
  minim = new Minim(this);
  sample1 = minim.loadSample("sample1.mp3");
  sample2 = minim.loadSample("sample2.mp3");
  sample3 = minim.loadSample("sample3.mp3");
}
