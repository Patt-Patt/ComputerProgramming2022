class Button {
  float x, y, w, h;
  boolean on;
  String  val;
  color c1, c2;

  Button(float tempX, float tempY, float tempW, float tempH, String tempVal, color tempC1, color tempC2) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    val = tempVal;
    c1 = tempC1;
    c2 = tempC2;
    on = false;
  }

  void display() {
    if (on) {
      fill(c1);
    } else {
      fill(c2);
    }
    rect(x, y, w, h, 5);
    fill(0);
    textSize(50);
    if (val.equals("0")) {
      text(val, x+50, y+72.5);
    } else {
      text(val, x+50, y+72.5);
    }
  }

  void hover(int mx, int my) {
    on = (mousePressed && mx>x && my>y && mx<x+w && my<y+h);
  }
}
