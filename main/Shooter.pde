class Shooter {
  float w, h, x, y;
  String typeof, direction;
  float halfWidth, halfHeight, speed;
  
  //animation variables
  int currentFrame, frameSequence, frameOffset, delay, IdleTimer;
  float deltaTime, previousDisplayTime;
  int frameTime;
  
  Shooter(float _x, float _y, float _w, float _h, String _typeof) {
   w = _w;
   h = _h;
   x = _x;
   y = _y;
   typeof = _typeof;
   direction = "right-to-left";
   delay = 200;
   
   halfWidth = w/2;
   halfHeight = h/2;
   
    //animation values
    currentFrame = 0;
    frameSequence = 6;
    IdleTimer = 4000;
  }
  
  void display() {
    fill(0, 255, 255, 0);
    rect(x,y,w,h);
    if (typeof == "ketchup") {
      image(RShooterImages[currentFrame], x - halfWidth, y - h);
    } else if (typeof == "chantilly") {
      image(SneezerImages[currentFrame], x - halfWidth, y - h);
    } else {
      image(LShooterImages[currentFrame], x - halfWidth, y - h);
    }
    if ((millis() - frameTime) > delay) {
      frameTime = millis(); 
      currentFrame = (currentFrame + 1)%frameSequence;
    }
  }
}
