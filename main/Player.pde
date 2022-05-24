class Player {

  //position variables
  float w, h, x, y, vx, vy, accelerationX, accelerationY, speedLimit;
  
  //world variables
  float friction, bounce, gravity;
  
  //animation variables
  int currentFrame, frameSequence, IdleTimer;
  boolean facingRight;
  int frameTime, lastMoved;
  int IdleAnimationPos;
  
  boolean isOnGround;
  float jumpForce;
  
  float halfWidth, halfHeight;
  String collisionSide;
  
  Player() {
    w = 60;
    h = 90;
    x = 400;
    y = 4900;
    vx = 0;
    vy = 0;
    accelerationX = 0;
    accelerationY = 0;
    speedLimit = 8;
    isOnGround = false;
    jumpForce = -12.5;
    
    //world values
    friction = 0.1;
    bounce = -0;
    gravity = 0.3;
    
    halfWidth = w/2;
    halfHeight = h/2;
    
    collisionSide = "";
    
    //animation values
    currentFrame = 0;
    facingRight = true;
    frameSequence = 6;
    IdleAnimationCount= 0;
    IdleTimer = 4000;
  }
  
  void update() {
    if (left || right || up || down) {
      lastMoved = millis();
    }
    if (left && !right) {
      accelerationX = -0.2;
      friction = 1;
      facingRight = false;
    }
    if (right && !left) {
      accelerationX = 0.2;
      friction = 1;
      facingRight = true;
    }
    //Stop if not clicking
    if (!left && !right) {
      accelerationX = 0;
      vx = 0;
    }
    //Stop if click both sides
    if (left && right) {
      accelerationX = 0;
      friction = 0.5;
    }
    //Jump
    if (up && isOnGround) {
      vy = jumpForce;
      isOnGround = false;
    }
    //Accelerate jump if press down
    if (down && !up) {
      accelerationY = 0.2;
    }
    //Stop if not up or down
    if (!down && !up) {
      accelerationY = 0;
    }
    
    //remove impulse reintroduces friction
    if (!left && !right) {
      friction = 0.5;
    }
    
      
    vx += accelerationX;
    vy += accelerationY;
    
    //friction 1 = no friction
    vx *= friction;
    
    //apply gravity
    vy += gravity;
    
    //Correction for max speed
    if (vx > speedLimit) {
      vx = speedLimit;
    }
    if (vx < -speedLimit) {
      vx = -speedLimit;
    }
    
    //move player
    x = Math.max(0, Math.min(x + vx, gameWorld.w - w)); 
    y = Math.max(0, Math.min(y + vy, gameWorld.h - h));
    
    checkBoundaries();
    checkPlatforms();
  }
  
  void checkBoundaries() {
    //left
    if (x <= 0) {
      vx = 0;
    }
    //right
    if (x >= gameWorld.w - w - doorArea) {
      x = gameWorld.w - w - doorArea;
      vx = 0;
    }
    //top
    if (y <= 0) {
      vy *= bounce;
    }
    //bottom
    if (y >= gameWorld.h - h) {
      if (vy < 1) {
        isOnGround = true;
        vy = 0;
      } else {
        vy *= bounce/2;
      }
    }
  }
  
  void checkPlatforms() {
    if (collisionSide == "bottom" && vy >= 0) {
      if (vy < 1) {
         isOnGround = true;
         vy = 0;
         if (y <= 780 && end_time == 0) {
           end_time = millis();
           total_time = (end_time - init_time)/1000;
           println("finished in: " + total_time + "seconds" );
         }
      } else {
        vy *= bounce/4;
      }
    } else if (collisionSide == "top" && vy <= 0) {
      vy = 0;
    } else if (collisionSide == "right" && vx >= 0) {
      vx = 0;
    } else if (collisionSide == "left" && vx <= 0) {
      vx = 0;
    }
    if (collisionSide != "bottom" && vy > 0) {
      isOnGround = false;
    }
  }
  
  void display() {
    fill(0, 255, 0, 0);
    noStroke();
    if (down && isOnGround) {
      rect(x, y + halfHeight, w, halfHeight); 
    } else {
      rect(x, y, w, h); 
    }
    if(true){
      if (facingRight) {
        if (millis() - lastMoved > IdleTimer) {
          image(IdleAnimationRight[IdleAnimationPos][currentFrame], x - halfWidth, y);
          if (millis() - lastMoved > IdleTimer + 3000) {
            lastMoved = millis();
            IdleAnimationPos = (IdleAnimationPos + 1)%IdleAnimationCount;
          }
        } else {
          if (isOnGround) {
            if (abs(vx) > 0) {
              image(RRunImages[currentFrame], x - halfWidth, y);
            } else {
              if (down) {
                image(RDownImage, x - halfWidth, y);
              } else {
                image(R2StandImages[currentFrame], x - halfWidth, y);
              }
            }
          } else {
            if (vy < 0) {
              image(RJumpImages[0], x - halfWidth, y);
            } else {
              image(RJumpImages[1], x - halfWidth, y);
            }
          }
        }
      } else {
        if (millis() - lastMoved > IdleTimer) {
          image(IdleAnimationLeft[IdleAnimationPos][currentFrame], x - halfWidth, y);
          if (millis() - lastMoved > IdleTimer + 3000) {
            lastMoved = millis();
            IdleAnimationPos = (IdleAnimationPos + 1)%IdleAnimationCount;
          }
        } else {
          if (isOnGround) {
            if (abs(vx) > 0) {
              image(LRunImages[currentFrame], x - halfWidth, y);
            } else {
              if (down) {
                image(LDownImage, x - halfWidth, y);
              } else {
                image(L2StandImages[currentFrame], x - halfWidth, y);
              }
            }
          } else {
            if (vy < 0) {
              image(LJumpImages[0], x - halfWidth, y);
            } else {
              image(LJumpImages[1], x - halfWidth, y);
            }
          }
        }
      }
      image(pizzaStandImages[currentFrame], 400, 4500);
      if ((millis() - frameTime) > 100) {
        frameTime = millis(); 
        currentFrame = (currentFrame + 1)%frameSequence;
      }
    }
  }
}
