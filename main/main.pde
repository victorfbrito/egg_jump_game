Player u;
Shooter [] enemies;
Platform [] platforms;
Projectile [] projectiles;
FrameObject camera, gameWorld;
ImageObject backImage, miniMap, eggIcon;
PImage RDownImage, LDownImage;
PImage [] RShooterImages, SneezerImages, LShooterImages, RRunImages, R2StandImages, RJumpImages, LRunImages, L2StandImages, LJumpImages, LScratchImages, RScratchImages, LWaveImages, RWaveImages, pizzaStandImages;
PImage [][] IdleAnimationLeft, IdleAnimationRight;
int IdleAnimationCount;
int frames, doorArea;
float proportion, mapPosY, mapPosX, mapHeight, dynamic_y, iconSize, init_time, end_time, total_time;

boolean left, right, up, down, space;
PImage bg, map, egg_icon;
PFont Font1;

String egg_pos;

void setup() {
  size(800, 600);

  Font1 = createFont("Arial Bold", 18);

  left = false;
  right = false;
  up = false;
  down = false;
  space = false;
  
  mapHeight = 165;
  iconSize = 20;
  mapPosY = 20;
  mapPosX = 20;
  dynamic_y = 0;
  init_time = millis();
  end_time = 0;
  bg = loadImage("bg_image.jpg");
  map = loadImage("minimap.png");
  egg_icon = loadImage("egg_position.png");
  backImage = new ImageObject(0, 0, 1200, 5000, bg);
  miniMap = new ImageObject(mapPosX, mapPosY, 45, mapHeight, map);
  gameWorld = new FrameObject(0, 0, 1200, 5000);
  camera = new FrameObject(0, 0, width, height);
  doorArea = 200;
  proportion = 2000;

  camera.x = (gameWorld.x + gameWorld.w/2) - camera.w/2;
  camera.y = (gameWorld.y + gameWorld.h/2) - camera.h/2;


  //player values
  u = new Player();
  frames = 6;
  IdleAnimationCount = 2;
  SneezerImages = new PImage[frames];
  RShooterImages = new PImage[frames];
  LShooterImages = new PImage[frames];
  RRunImages = new PImage[frames];
  R2StandImages = new PImage[frames];
  RJumpImages = new PImage[frames];
  RWaveImages = new PImage[frames];
  RScratchImages = new PImage[frames];
  LRunImages = new PImage[frames];
  LJumpImages = new PImage[frames];
  L2StandImages = new PImage[frames];
  LWaveImages = new PImage[frames];
  LScratchImages = new PImage[frames];
  RDownImage = loadImage("sprites/rdown.png");
  LDownImage = loadImage("sprites/ldown.png");
  IdleAnimationLeft = new PImage[IdleAnimationCount][];
  IdleAnimationRight = new PImage[IdleAnimationCount][];
  for (int i = 0; i < frames; i++) {
    SneezerImages[i]=loadImage("sprites/sneezer"+(i+1)+".png");
    RShooterImages[i]=loadImage("sprites/rshooter"+(i+1)+".png");
    LShooterImages[i]=loadImage("sprites/lshooter"+(i+1)+".png");
    RRunImages[i]=loadImage("sprites/rrun"+(i+1)+".png");
    LRunImages[i]=loadImage("sprites/lrun"+(i+1)+".png");
    R2StandImages[i]=loadImage("sprites/r2stand"+(i+1)+".png");
    L2StandImages[i]=loadImage("sprites/l2stand"+(i+1)+".png");
    RWaveImages[i]=loadImage("sprites/rwave"+(i+1)+".png");
    LWaveImages[i]=loadImage("sprites/lwave"+(i+1)+".png");
    RScratchImages[i]=loadImage("sprites/rscratch"+(i+1)+".png");
    LScratchImages[i]=loadImage("sprites/lscratch"+(i+1)+".png");
  }
  for (int i = 0; i < 2; i++) {
    RJumpImages[i]=loadImage("sprites/rjump"+(i+1)+".png");
    LJumpImages[i]=loadImage("sprites/ljump"+(i+1)+".png");
  }
  IdleAnimationLeft[0] = LWaveImages;
  IdleAnimationLeft[1] = LScratchImages;
  IdleAnimationRight[0] = RWaveImages;
  IdleAnimationRight[1] = RScratchImages;
  
  //enemy values
  enemies = new Shooter[2];
  enemies[0] = new Shooter(gameWorld.w - 265, 4055, 200, 460, "ketchup");
  enemies[1] = new Shooter(gameWorld.w - 225, 3209, 200, 460, "chantilly");
  pizzaStandImages = new PImage[frames];
  for (int i = 0; i < frames; i++) {
    pizzaStandImages[i]=loadImage("sprites/pizzastand"+(i+1)+".png");
  }
  
  //projectile values
  projectiles = new Projectile[5];
  projectiles[0] = new Projectile(enemies[0].x, enemies[0].y - ((enemies[0].halfHeight/1.5) - 200), "ketchup");
  projectiles[1] = new Projectile(enemies[0].x, enemies[0].y - ((enemies[0].halfHeight/1.5)), "ketchup");
  projectiles[2] = new Projectile(enemies[0].x, enemies[0].y - ((enemies[0].halfHeight/1.5) + 200), "ketchup");
  projectiles[3] = new Projectile(enemies[1].x, enemies[1].y - enemies[1].h, "chantilly");
  projectiles[4] = new Projectile(enemies[1].x, enemies[1].y - enemies[1].h, "chantilly");

  //platform values
  platforms = new Platform[21];
  platforms[0] = new Platform (200, 4760, 200, 25, "slide");
  platforms[1] = new Platform (150, 4560, 200, 25, "break");
  platforms[2] = new Platform (200, 4360, 200, 25, "slide");
  platforms[3] = new Platform (150, 4160, 200, 25, "safe");
  platforms[4] = new Platform (300, 3960, 200, 25, "slide");
  platforms[5] = new Platform (150, 3760, 200, 25, "break");
  platforms[6] = new Platform (100, 3560, 200, 25, "slide");
  platforms[7] = new Platform (150, 3360, 200, 25, "safe");
  platforms[8] = new Platform (200, 3160, 200, 25, "slide");
  platforms[9] = new Platform (100, 2960, 200, 25, "break");
  platforms[10] = new Platform (200, 2760, 200, 25, "slide");
  platforms[11] = new Platform (100, 2560, 200, 25, "safe");
  platforms[12] = new Platform (150, 2360, 200, 25, "slide");
  platforms[13] = new Platform (300, 2160, 200, 25, "break");
  platforms[14] = new Platform (150, 1960, 200, 25, "slide");
  platforms[15] = new Platform (200, 1760, 200, 25, "safe");
  platforms[16] = new Platform (200, 1560, 200, 25, "slide");
  platforms[17] = new Platform (200, 1360, 200, 25, "break");
  platforms[18] = new Platform (200, 1160, 200, 25, "slide");
  platforms[19] = new Platform (200, 960, 200, 25, "safe");
  platforms[20] = new Platform (0, 760, gameWorld.w, 25, "final");
}

void draw() {
  background(255);
  u.update();
  for (int i = 0; i < platforms.length; ++i) {
    u.collisionSide = rectangleCollisions(u, platforms[i]);
    u.checkPlatforms();
  }
  //Move the camera
  camera.x = floor(u.x + (u.halfWidth) - (camera.w / 2));
  camera.y = floor(u.y + (u.halfHeight) - (camera.h / 2));

  //Keep the camera inside the gameWorld boundaries
  if (camera.x < gameWorld.x) {
    camera.x = gameWorld.x;
  }
  if (camera.y < gameWorld.y) {
    camera.y = gameWorld.y;
  }
  if (camera.x + camera.w > gameWorld.x + gameWorld.w) {
    camera.x = gameWorld.x + gameWorld.w - camera.w;
  }
  if (camera.y + camera.h > gameWorld.h) {
    camera.y = gameWorld.h - camera.h;
  }
  

  pushMatrix();
  translate(-camera.x, -camera.y);

  backImage.display();
  u.display();
  for (int i = 0; i < enemies.length; ++i) {
    enemies[i].display();
  }
  for (int i = 0; i < projectiles.length; ++i) {
    projectiles[i].display();
  }
  for (int i = 0; i < platforms.length; ++i) {
    platforms[i].display();
  }

  popMatrix();
  displayPositionData();
  miniMap.display();
  eggIcon.display();
}

String rectangleCollisions(Player r1, Platform r2) {
  ////r1 is the player
  ////r2 is the platform

  if (r1.vy < 0) { 
    return "";
  }

  float dx = (r1.x+r1.w/2) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/2) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    ////collision has happened on the x axis
    if (abs(dy) < combinedHalfHeights) {
      ////collision detected
      //determine the overlap on each axis
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);
      ////the collision is on the axis with the
      ////SMALLEST overlap
      if (overlapX >= overlapY) {
        if (dy > 0) {
          ////move the rectangle back to eliminate overlap
          ////before calling its display to prevent
          ////drawing object inside each other
          r1.y += overlapY;
          return "top";
        } else {
          r1.y -= overlapY;
          if (r2.collisionTime == 0) {
            r2.collisionTime = millis();
          }
          return "bottom";
        }
      } else {
        if (dx > 0) {
          r1.x += overlapX;
          return "left";
        } else {
          r1.x -= overlapX;
          return "right";
        }
      }
    } else {
      //collision failed on the y axis
      return "";
    }
  } else {
    //collision failed on the x axis
    return "";
  }
}

void displayPositionData() {
  float currentHeight = gameWorld.h - u.y;
  float eggPos = ((gameWorld.h - u.y)/gameWorld.h)*100;
  dynamic_y = (mapHeight + mapPosY) - (mapHeight*(eggPos/100));
  egg_pos = nf((currentHeight/proportion), 0, 2) + "m";
  eggIcon = new ImageObject(mapPosX + 50, dynamic_y - (iconSize/2), 40, 40, egg_icon);
  textFont(Font1);
  fill(255);
  text(egg_pos, 95, dynamic_y + 4);
}

void keyPressed() {
  switch (keyCode) {
  case 37://left
    left = true;
    break;
  case 39://right
    right = true;
    break;
  case 38://up
    up = true;
    break;
  case 40://down
    down = true;
    break;
  case 32: //space
    space = true;
    break;
  }
}
void keyReleased() {
  switch (keyCode) {
  case 37://left
    left = false;
    break;
  case 39://right
    right = false;
    break;
  case 38://up
    up = false;
    break;
  case 40://down
    down = false;
    break;
  case 32: //space
    space = false;
    break;
  }
}
