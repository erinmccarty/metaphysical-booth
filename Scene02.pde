class Scene02{
 
  Scene02(){  

  }
  
  void update(){
    
    //MOUSE AND MP4 VIDEO INTERACTION
    // Ratio of mouse X over width 
    float ratio = mouseX / float(width*2); 
    video.jump(ratio * video.duration()); 
    
    //DISPLAY MP4 VIDEO
    blendMode(BLEND);
    image(video, 0, 0);
    
    //DISPLAY LIVE WEBCAM 
    blendMode(LIGHTEST);
    image(cam, 0, 0);
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
  
  
  //WEB CAM READ
  void captureEvent(Capture cam) {
    cam.read();
  }
  
  //MP4 VIDEO READ
  void movieEvent(Movie video) {  
    video.read();
  }
  
}
