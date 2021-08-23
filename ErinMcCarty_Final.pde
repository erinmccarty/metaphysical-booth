// ERIN MCCARTY FINAL
// use '1' '2' and '3' keys to alternate between filters
// press 'w' to start recording and 'q' to end video recording
// use mouse to manipulate the audio (and manipulate filter #3)

//REFERENCED CODE
//  1. INTERACTIVE SOUND SETUP -- from SOUND LIBRARY "SimplePlayback"
//  2. WEBCAM MOVEMENT DETECTION EFFECTS
//      FROM https://github.com/atduskgreg/opencv-processing/blob/master/examples/BackgroundSubtraction/BackgroundSubtraction.pde
//  3. WEBCAM FACE TRACKING
//      FROM https://discourse.processing.org/t/using-opencv-with-processing/14148/4

//LIBRARIES
import gab.opencv.*;
import processing.video.*;
import com.hamoid.*;
import java.awt.Rectangle;
import processing.sound.*;

//-------------------------------

//SCENE CHANGES
//set a variable for the scene number
int sceneNumber=0;
int value=0;
boolean vRecord=false;//BOOLEAN  FLIPS THE VIDEO PLAYER RECORD ON AND OFF
//instantiate an instance of each scene
Scene00 sceneZero;
Scene01 sceneOne;
Scene02 sceneTwo;

//-------------------------------

//SCENE00
Capture video0; //WEBCAM
OpenCV opencv0; //OPENCV
  
//-------------------------------
  
//SCENE01
Capture video1; //WEBCAM
OpenCV opencv1; //OPENCV
Rectangle[] faces; //FACE DETECT
Movie mp4; //MP4

//-------------------------------

//SCENE02
Movie video; //MP4
Capture cam; //WEBCAM

//-------------------------------

//VIDEO EXPORT
VideoExport videoExport;

//-------------------------------

//SOUND EXPORT
SoundFile soundfile;


void setup(){
  
  size(720,480);
  frameRate(30);
  smooth();
  //construct each of the scenes
  sceneZero=new Scene00();
  sceneOne=new Scene01();
  sceneTwo=new Scene02();
  
  //-------------------------------
  
  //SCENE00
  //WEBCAM START
  video0 = new Capture(this, width, height, 30);
  video0.start();
  
  //OPENCV MOVEMENT DETECT START
  opencv0 = new OpenCV(this, 720, 480);
  opencv0.startBackgroundSubtraction(5, 3, 0.5);
  
  //-------------------------------
  
  //SCENE01
  //WEBCAM START
  video1 = new Capture(this, width, height, 30);
  video1.start();  
  
  //OPENCV FACIAL RECOGNITION START
  opencv1 = new OpenCV(this, video1.width, video1.height);  
  opencv1.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  
  //LOCATE MOVIE FILE
  mp4 = new Movie(this, "testvideo1.mp4");  
  mp4.loop();
  
  //-------------------------------
  
  //SCENE02
  //LOCATE MOVIE FILE
  video = new Movie(this, "test2.mp4");  
  video.loop();
  
  //WEBCAM START
  cam = new Capture(this, 720, 480, 30);
  cam.start();
  
  //-------------------------------
  
  //INTERACTIVE SOUND SETUP -- from SOUND LIBRARY "SimplePlayback"
  // Load a soundfile
  soundfile = new SoundFile(this, "synthloop.mp3");

  // These methods return useful infos about the file
  println("SFSampleRate= " + soundfile.sampleRate() + " Hz");
  println("SFSamples= " + soundfile.frames() + " samples");
  println("SFDuration= " + soundfile.duration() + " seconds");

  // Play the file in a loop
  soundfile.loop();
  
  //-------------------------------
  
  //VIDEO EXPORT
  videoExport = new VideoExport(this, "videoCapture.mp4");
  videoExport.setAudioFileName("synthloop.mp3");//EXPORT SOUND W MOVIE
  videoExport.startMovie();
  
}


void draw(){
  
  //use # keys to control scene
    if (keyPressed) {
      if (key == '1') {
        sceneNumber=0;
      }
      if (key == '2') {
        sceneNumber=1;
      }
      if (key == '3') {
        sceneNumber=2;
      }
    }
    
  //switch checks the value of the variable sceneNumber
  //when the value matches one of the case values the code inside that case
    switch(sceneNumber) { 
    case 0:
      sceneZero.update();
      break;
    case 1:
      sceneOne.update();
      break;
    case 2:
      sceneTwo.update();
      break;
  }
  
  if(vRecord) {
    videoExport.saveFrame();//IF THE BOOLEAN IS TRUE START CAPTURING FRAMES
  }
  
}


//RECORD MP4 VIDEO
void keyPressed() {
  if (key == 'w') {
    vRecord = !vRecord;//FLIPS THE BOOLEAN ON AND OFF
    println("Recording is " + (vRecord ? "ON" : "OFF"));
  }
  if (key == 'q') {
    videoExport.endMovie();
    println("END RECORDING");
    exit();
  }
}
