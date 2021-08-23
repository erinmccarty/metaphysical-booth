//WEBCAM FACE TRACKING
// FROM https://discourse.processing.org/t/using-opencv-with-processing/14148/4

class Scene01{
  
  Scene01(){  

  }
  
  void update(){
    
    //DISPLAY WEBCAM
    blendMode(BLEND);
    opencv1.loadImage(video1);
    
    //OPENCV
    faces = opencv1.detect();
    image(opencv1.getInput(), 0, 0);
    noFill();
    noStroke();
  
    //PLACE MP4 OVER FACE
    for (int i = 0; i < faces.length; i++) {
      blendMode(LIGHTEST);
      image(mp4, faces[i].x/2, faces[i].y/2, faces[i].width*2, faces[i].height*2);
    }
 
    blendMode(BLEND);
    
    //SOUND INTERACTION
    // Map mouseX from 0.25 to 4.0 for playback rate. 1 equals original playback speed,
    // 2 is twice the speed and will sound an octave higher, 0.5 is half the speed and
    // will make the file sound one ocative lower.
    float playbackSpeed = map(mouseX, 0, width, 0.5, 1.5);
    soundfile.rate(playbackSpeed);
  
    // Map mouseY from 0.2 to 1.0 for amplitude
    float amplitude = map(mouseY, 0, width, 0.2, 0.4);
    soundfile.amp(amplitude);
    }
    
  }


  //WEBCAM READ
  void captureEvent1(Capture c) {
    c.read();
  }
  
  //MP4 VIDEO READ
  void movieEvent(Movie mp4) {  
    mp4.read();
  }
