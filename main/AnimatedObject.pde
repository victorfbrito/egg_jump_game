class AnimatedObject {

  //position variables
  float w, h, x, y;
  
  //animation variables
  int currentFrame, frameSequence, delay, frameTime;
  boolean facingRight;
  PImage [] frameList;
  
  AnimatedObject(float _x, float _y, float _w, float _h, int _frameSequence, PImage[] _frameList) {
    w = _w;
    h = _h;
    x = _x;
    y = _y;
    
    //animation values
    currentFrame = 0;
    facingRight = true;
    frameSequence = _frameSequence;
    frameList = _frameList;
    delay = 100;
  }
  
   void display() {
    fill(0, 255, 0, 0);
    noStroke();
      image(frameList[currentFrame], x, y);
      
      if ((millis() - frameTime) > delay) {
        frameTime = millis(); 
        currentFrame = (currentFrame + 1)%frameSequence;
      }
    }
}
