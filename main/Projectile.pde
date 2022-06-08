class Projectile {
  float w, h, x, y, init_x, init_y;
  String typeof, direction;
  float speed, vy, vx, collisionTime, accelerationX, accelerationY, gravity, jumpForce, resistance, dynamic_posY;
  boolean shot;
  
  //animation variables
  int currentFrame, frameSequence, frameOffset, delay, IdleTimer;
  float deltaTime, previousDisplayTime;
  int frameTime;
  PImage [] frameList;
  
  int[] positions = {0, -50};
  float[] resistances = {0.3, 0.5, 0.7, 0.9};
  float[] speeds = {4, 6, 8};
  float halfWidth, halfHeight;
  
  Projectile(float _x, float _y, String _typeof) {
   w = 50;
   h = 50;
   x = _x;
   y = _y;
   //y = 4900;
   init_x = _x;
   init_y = _y;
   typeof = _typeof;
   direction = "left";
   collisionTime = 0;
   speed = speeds[int(random(speeds.length))];
   accelerationX = 0;
   accelerationY = 0;
   gravity = 0.15;
   jumpForce = -12.5;
   shot = false;
   resistance = resistances[int(random(resistances.length))];
   vy = 0;
   vx = 0;
   dynamic_posY = positions[int(random(positions.length))];
   if (typeof == "ketchup"){
     frameList = KetchupImages;
   } else if (typeof == "chantilly"){
     frameList = ChantillyImages;
   }
   halfWidth = w/2;
   halfHeight = h/2;
    
   //animation values
   currentFrame = 0;
   frameSequence = 4;
   IdleTimer = 4000;
  }
  
  void display() {
    fill(0, 255, 255, 100);
    if (!shot) {
      shot = true;
      speed = speeds[int(random(speeds.length))];
    }
    vx = - speed;
    
    //move projectile
    if (x + vx > 0) {
      x = x + vx; 
      y = y + vy;
    } else {
      shot = false;
      x = init_x;
      y = init_y;
    }
    image(frameList[currentFrame], x, y + dynamic_posY);
    if ((millis() - frameTime) > delay) {
      frameTime = millis(); 
      currentFrame = (currentFrame + 1)%frameSequence;
    }
    //rect(x,y + dynamic_posY,w,h);
  }
}
