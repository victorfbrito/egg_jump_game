import processing.sound.*;
SoundFile file;

Player u;
Shooter [] enemies;
Platform [] platforms;
Projectile [] projectiles;
FrameObject camera, gameWorld;
ImageObject soundONImage, soundOFFImage, bgImage, miniMap, eggIcon, menubgImage, gameLogo, buttonBg, hoverbuttonBg, buttonGroup1, buttonGroup2, creditsBgImage;
AnimatedObject [] candles, wind, ketchup, chantilly;
ButtonObject [] buttons;
ButtonObject return_button;
PImage RDownImage, LDownImage, soundon_icon, soundoff_icon;
PImage [] KetchupImages, ChantillyImages, WindImages, CandleImages, RShooterImages, SneezerImages, LShooterImages, RWindRunImages, RRunImages, R2StandImages, RJumpImages, LRunImages, L2StandImages, LJumpImages, LScratchImages, RScratchImages, LWaveImages, RWaveImages;
PImage [][] IdleAnimationLeft, IdleAnimationRight;
int IdleAnimationCount;
int frames, doorArea;
float proportion, mapPosY, mapPosX, mapHeight, dynamic_y, iconSize, init_time, end_time, total_time;

//menu variables
String active_screen = "Return";
PImage menu_bg, menu_button, game_logo, button_bg, hoverbutton_bg, button_group1, button_group2, credits_bg;
String clickAction = "";

boolean left, right, up, down, space, mute;
PImage bg, map, egg_icon;
PFont Font1;

String egg_pos;

void setup() {
  size(800, 600);
  
  // Load a soundfile from the data folder of the sketch and play it back in a loop
  //file = new SoundFile(this, "carefree.mp3");
  //file.play();

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
  menu_bg = loadImage("menu_bg_image.jpg");
  button_bg = loadImage("menu_button.png");
  hoverbutton_bg = loadImage("hovered_menu_button.png");
  button_group1 = loadImage("button_group_1.png");
  button_group2 = loadImage("button_group_2.png");
  map = loadImage("minimap.png");
  egg_icon = loadImage("egg_position.png");
  game_logo = loadImage("game_logo.png");
  credits_bg = loadImage("credits_bg.png");
  soundon_icon = loadImage("VOLON.png");
  soundoff_icon = loadImage("VOLOFF.png");
  soundONImage = new ImageObject(750, 50, 25, 22, soundon_icon);
  soundOFFImage = new ImageObject(750, 50, 25, 22, soundoff_icon);
  bgImage = new ImageObject(0, 0, 1200, 5000, bg);
  miniMap = new ImageObject(mapPosX, mapPosY, 45, mapHeight, map);
  gameLogo = new ImageObject((width/2) - 140, 120, 280, 100, game_logo);
  gameWorld = new FrameObject(0, 0, 1200, 5000);
  camera = new FrameObject(0, 0, width, height);
  doorArea = 200;
  proportion = 2000;
  menubgImage = new ImageObject(0, 0, 800, 600, menu_bg);
  buttonGroup1 = new ImageObject(width/2 - 320, height/2 - 150, 300, 240, button_group1);
  buttonGroup2 = new ImageObject(width/2 + 50, height/2 - 150, 215, 230, button_group2);
  creditsBgImage = new ImageObject((width/2) - 90, 60, 180, 350, credits_bg);

  camera.x = (gameWorld.x + gameWorld.w/2) - camera.w/2;
  camera.y = (gameWorld.y + gameWorld.h/2) - camera.h/2;


  //player values
  u = new Player();
  frames = 6;
  IdleAnimationCount = 2;
  SneezerImages = new PImage[frames];
  RShooterImages = new PImage[frames];
  LShooterImages = new PImage[frames];
  RWindRunImages = new PImage[frames];
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
  KetchupImages = new PImage[4];
  ChantillyImages = new PImage[4];
  for (int i = 0; i < 4; i++) {
    KetchupImages[i]=loadImage("sprites/K"+(i+1)+".png");
    ChantillyImages[i]=loadImage("sprites/M"+(i+1)+".png");
    
  }
  for (int i = 0; i < frames; i++) {
    RWindRunImages[i]=loadImage("sprites/rwindrun"+(i+1)+".png");
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
  CandleImages = new PImage[frames];
  WindImages = new PImage[13];
  for (int i = 0; i < frames; i++) {
    CandleImages[i]=loadImage("sprites/candle"+(i+1)+".png");
  }
  for (int i = 0; i < 13; i++) {
    WindImages[i]=loadImage("sprites/w"+(i+1)+".png");
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
  platforms[15] = new Platform (200, 1760, 200, 25, "break");
  platforms[16] = new Platform (200, 1560, 200, 25, "slide");
  platforms[17] = new Platform (200, 1360, 200, 25, "break");
  platforms[18] = new Platform (200, 1160, 200, 25, "break");
  platforms[19] = new Platform (200, 960, 200, 25, "break");
  platforms[20] = new Platform (0, 760, gameWorld.w, 25, "final");
  
  //animated object values
  candles = new AnimatedObject[5];
  int candleposition = 285;
  int add_pos = 72;
  candles[0] = new AnimatedObject (candleposition, 2208, 65, 47, 6, CandleImages);
  candles[1] = new AnimatedObject (candleposition + (add_pos*1), 2208, 65, 47, 6, CandleImages);
  candles[2] = new AnimatedObject (candleposition + (add_pos*2), 2208, 65, 47, 6, CandleImages);
  candles[3] = new AnimatedObject (candleposition + (add_pos*3), 2208, 65, 47, 6, CandleImages);
  candles[4] = new AnimatedObject (candleposition + (add_pos*4), 2208, 65, 47, 6, CandleImages);

  wind = new AnimatedObject[12];
  wind[0] = new AnimatedObject ( 65, 1560, 200, 80, 13, WindImages);
  wind[1] = new AnimatedObject ( 200, 1800, 200, 80, 13, WindImages);
  wind[2] = new AnimatedObject (240, 1900, 200, 80, 13, WindImages);
  wind[3] = new AnimatedObject (10, 2160, 200, 80, 13, WindImages);
  wind[4] = new AnimatedObject (330, 2360, 200, 80, 13, WindImages);
  wind[5] = new AnimatedObject (100, 2560, 200, 80, 13, WindImages);
  wind[6] = new AnimatedObject ( 365, 1560, 200, 80, 13, WindImages);
  wind[7] = new AnimatedObject ( 500, 1800, 200, 80, 13, WindImages);
  wind[8] = new AnimatedObject (540, 1900, 200, 80, 13, WindImages);
  wind[9] = new AnimatedObject (310, 2160, 200, 80, 13, WindImages);
  wind[10] = new AnimatedObject ( 630, 2360, 200, 80, 13, WindImages);
  wind[11] = new AnimatedObject (400, 2560, 200, 80, 13, WindImages);


  //button values
  buttons = new ButtonObject[4];
  int add_but_pos = 70;
  return_button = new ButtonObject((width/2) - 102.5, (height/2.5) + add_but_pos*3, 205, 50, "Return");
  buttons[0] = new ButtonObject((width/2) - 102.5, height/2.5, 205, 50, "Play");
  buttons[1] = new ButtonObject((width/2) - 102.5, (height/2.5) + add_but_pos*1, 205, 50, "Character");
  buttons[2] = new ButtonObject((width/2) - 102.5, (height/2.5) + add_but_pos*2, 205, 50, "Controls");
  buttons[3] = new ButtonObject((width/2) - 102.5, (height/2.5) + add_but_pos*3, 205, 50, "Credits");

}

void draw() {
  background(255);
  if (active_screen == "Return") {
    menubgImage.display();
    gameLogo.display();
    for (int i = 0; i < buttons.length; ++i) {
      buttons[i].display();
    }
    for (int i = 0; i < buttons.length; ++i) {
      if (overButton(buttons[i])) {
        clickAction = buttons[i].action();
        cursor(HAND);
        break;
      } else {
        clickAction = "";
        cursor(ARROW);
      };
    }
  } else if (active_screen == "Intro") {
  } else if (active_screen == "Character") {
    menubgImage.display();
    return_button.display();  
    if (overButton(return_button)) {
      clickAction = return_button.action();
      cursor(HAND);
    } else {
      clickAction = "";
      cursor(ARROW);
    };
  } else if (active_screen == "Controls") {
    menubgImage.display();
    return_button.display();
    buttonGroup1.display();
    buttonGroup2.display();
    if (overButton(return_button)) {
      clickAction = return_button.action();
      cursor(HAND);
    } else {
      clickAction = "";
      cursor(ARROW);
    };
  } else if (active_screen == "Credits") {
    menubgImage.display();
    return_button.display();  
    creditsBgImage.display();
    if (overButton(return_button)) {
      clickAction = return_button.action();
      cursor(HAND);
    } else {
      clickAction = "";
      cursor(ARROW);
    };
  } else if (active_screen == "Play")  {
    noCursor();
    u.update();
    for (int i = 0; i < platforms.length; ++i) {
      u.collisionSide = rectangleCollisions(u, platforms[i]);
      u.checkPlatforms();
    }
    for (int i = 0; i < projectiles.length; ++i) {
      u.collisionSide = projectileCollisions(u, projectiles[i]);
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
  
    bgImage.display();
    for (int i = 0; i < candles.length; ++i) {
      candles[i].display();
    }
    for (int i = 0; i < wind.length; ++i) {
      wind[i].display();
    }
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
    soundONImage.display();
  }
}

Boolean overButton(ButtonObject b) {
  if (mouseX >= b.x && mouseX <= b.x+b.w && 
        mouseY >= b.y && mouseY <= b.y+b.h) {
      return true;
    } else {
      return false;
    }
}

String projectileCollisions(Player r1, Projectile r2) {
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
  text(egg_pos, 120, dynamic_y + 4);
}

void mousePressed() {
  if (clickAction != "") {
    active_screen = clickAction;
  }
}

void keyPressed() {
  switch (keyCode) {
  case 80:// P key
    if (active_screen == "Play") {
      active_screen = "Return";
    }
    break;
  case 77:// M key
    mute = !mute;
    break;
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
