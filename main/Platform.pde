class Platform {
  float w, h, x, y;
  String typeof, direction, onCollision;
  float halfWidth, halfHeight, speed, collisionTime, x_pos;
  int breakTimer, hideTimer;
  
  Platform(float _x, float _y, float _w, float _h, String _typeof) {
   w = _w;
   h = _h;
   x = _x;
   y = _y;
   x_pos = _x;
   typeof = _typeof;
   direction = "right";
   speed = random(1,4);
   breakTimer = 2000;
   hideTimer = 0;
   
   collisionTime = 0;
   onCollision = "";
   halfWidth = w/2;
   halfHeight = h/2;
  }
  
  void display() {
    if (typeof == "slide") {
      fill(0,255,0);
      if (x >= gameWorld.w - w - doorArea) {
        direction = "left";
      } else if ( x <= 0) {
        direction = "right";
      }
      if (direction == "right") {
        x += speed;
      } else {
        x -= speed;
      }
      rect(x,y,w,h);
    } else if (typeof == "break") {
      if (hideTimer == 0 && collisionTime == 0) {
        x = x_pos;
        fill(255,0,0);
      } else {
        fill(200,200,0);
        if (hideTimer == 0 && millis() - collisionTime >= breakTimer) {
          x = -2000;
          hideTimer = millis();
          collisionTime = 0;
        } else if (millis() - hideTimer >= breakTimer * 2) {
          x = x_pos;
          hideTimer = 0;
        }
      }
      rect(x,y,w,h);
    } else if (typeof == "final") {
      fill(0,0,0,0);
      rect(x,y,w,h);
    } else if (typeof == "safe") {
      fill(0,0,255);
      rect(x,y,w,h);
    }
  }
  
}
