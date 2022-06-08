class ButtonObject{
  float w,h,x,y;
  PImage img;
  String action;
  float halfWidth, halfHeight;

  color rectColor, circleColor, baseColor;
  color rectHighlight, circleHighlight;
  boolean rectOver = false;

  ButtonObject(float _x, float _y, float _w, float _h, String _text){
    w = _w;
    h = _h;
    x = _x;
    y = _y;
    action = _text;

    halfWidth = w/2;
    halfHeight = h/2;
  }

  void display(){
    update();
    if (rectOver) {
      image(hoverbutton_bg, x, y, w, h);
      fill(22,147,242);
    } else {
      image(button_bg, x, y, w, h);
      fill(22,147,242);
    }
    textFont(Font1);
    textAlign(CENTER);
    text(action, x + halfWidth, y + halfHeight);
    noStroke();
  }
  
  void update() {
    if ( overRect(x, y, w, h) ) {
      rectOver = true;
    } else {
      rectOver = false;
    }
  }
  
  String action() {
    return action;
  }
  
  boolean overRect(float x, float y, float width, float height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}
