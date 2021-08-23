//WEBCAM MOVEMENT DETECTION EFFECTS
// FROM https://github.com/atduskgreg/opencv-processing/blob/master/examples/BackgroundSubtraction/BackgroundSubtraction.pde

class Scene00{
  
  Scene00(){  

  }
  
  void update(){
    
    //DISPLAY WEBCAM
    blendMode(DARKEST);
    image(video0, 0, 0);  
    
    //OPENCV
    opencv0.loadImage(video0);
    opencv0.updateBackground();
    opencv0.dilate();
    opencv0.erode();
    
    //DRAW CONTOURS    
    blendMode(BLEND);
    fill(255, 130, 0, 70);
    //stroke(75, 40, 0, 10);
    //strokeWeight(1);
    noStroke();
    for (Contour contour : opencv0.findContours()) {
      contour.draw();
    }
    
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
void captureEvent(Capture c) {
  c.read();
}
