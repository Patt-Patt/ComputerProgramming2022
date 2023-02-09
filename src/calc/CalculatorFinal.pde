// "Spooky Calculator" Oct 2022 by Zach Patterson

Button[] numB = new Button[10];
Button[] opB = new Button[12];
String dVal = "0";
String op = "";
boolean left = true;
float r = 0.0;
float l = 0.0;
float result = 0.0;

void setup() {
  size(675, 1150);
  textAlign(CENTER);
  numB[0] = new Button(50, 825, 275, 100, "0", color(#AF07A4), color(#AF07A4));
  numB[1] = new Button(50, 675, 100, 100, "1", color(#AF07A4), color(#AF07A4));
  numB[2] = new Button(200, 675, 100, 100, "2", color(#AF07A4), color(#AF07A4));
  numB[3] = new Button(350, 675, 100, 100, "3", color(#AF07A4), color(#AF07A4));
  numB[4] = new Button(50, 525, 100, 100, "4", color(#AF07A4), color(#AF07A4));
  numB[5] = new Button(200, 525, 100, 100, "5", color(#AF07A4), color(#AF07A4));
  numB[6] = new Button(350, 525, 100, 100, "6", color(#AF07A4), color(#AF07A4));
  numB[7] = new Button(50, 375, 100, 100, "7", color(#AF07A4), color(#AF07A4));
  numB[8] = new Button(200, 375, 100, 100, "8", color(#AF07A4), color(#AF07A4));
  numB[9] = new Button(350, 375, 100, 100, "9", color(#AF07A4), color(#AF07A4));
  opB[0] = new Button(350, 825, 100, 100, ".", color(#5CF0FC), color(#5CF0FC));
  opB[1] = new Button(500, 675, 100, 275, "\n =", color(#FF2B05), color(#FF2B05));
  opB[2] = new Button(500, 525, 100, 100, "+", color(#5CF0FC), color(#5CF0FC));
  opB[3] = new Button(500, 375, 100, 100, "-", color(#5CF0FC), color(#5CF0FC));
  opB[4] = new Button(500, 225, 100, 100, "*", color(#5CF0FC), color(#5CF0FC));
  opB[5] = new Button(350, 225, 100, 100, "/", color(#5CF0FC), color(#5CF0FC));
  opB[6] = new Button(200, 225, 100, 100, "(-)", color(#5CF0FC), color(#5CF0FC));
  opB[7] = new Button(50, 225, 100, 100, "CLR", color(#FF2B05), color(#FF2B05));
  opB[8] = new Button(50, 975, 100, 100, "√", color(#5CF0FC), color(#5CF0FC));
  opB[9] = new Button(200, 975, 100, 100, "  sin", color(#5CF0FC), color(#5CF0FC));
  opB[10] = new Button(350, 975, 100, 100, "X", color(#5CF0FC), color(#5CF0FC));
  opB[11] = new Button(500, 975, 100, 100, "*π", color(#5CF0FC), color(#5CF0FC));
}
void draw() {
  background(245, 138, 40);
  updateDisplay();
  textAlign(CENTER);
  for (int i = 0; i<numB.length; i++) {
    numB[i].display();
    numB[i].hover(mouseX, mouseY);
  }
  for (int i = 0; i<opB.length; i++) {
    opB[i].display();
    opB[i].hover(mouseX, mouseY);
  }
}

void mouseReleased() {
  for (int i=0; i<numB.length; i++) {
    if (numB[i].on && dVal.length()<20 && dVal.equals("0")) {
      dVal = numB[i].val;
      if (left) {
        l = float(dVal);
      } else if (!left) {
        r = float(dVal);
      }
    } else if (numB[i].on) {
      dVal = dVal + numB[i].val;
      if (left) {
        l = float(dVal);
      } else if (!left) {
        r = float(dVal);
      }
    }
  }
  for (int i=0; i<opB.length; i++) {
    if (opB[i].on && opB[i].val.equals("  CLR")) {
      dVal = "0";
      op = "";
      left = true;
      r = 0.0;
      l = 0.0;
      result = 0.0;
    } else if (opB[i].on && opB[i].val.equals("+")) {
      dVal = "0";
      op = "+";
      left = false;
    } else if (opB[i].on && opB[i].val.equals("-")) {
      dVal = "0";
      op = "-";
      left = false;
    } else if (opB[i].on && opB[i].val.equals("*")) {
      dVal = "0";
      op = "*";
      left = false;
    } else if (opB[i].on && opB[i].val.equals("/")) {
      dVal = "0";
      op = "/";
      left = false;
    } else if (opB[i].on && opB[i].val.equals(".")) {
      if (!dVal.contains(".") || dVal.contains(".0")) {
        dVal = dVal + ".";
      }
    } else if (opB[i].on && opB[i].val.equals("(-)")) {
      if (left) {
        l*=-1;
        dVal = str(l);
      } else if (!left) {
        r*=-1;
        dVal = str(r);
      }
    } else if (opB[i].on && opB[i].val.equals("  sin")) {
      if (left) {
        l = sin(radians(l));
        dVal = str(l);
      } else if (!left) {
        r = sin(radians(r));
        dVal = str(r);
      }
    } else if (opB[i].on && opB[i].val.equals("√")) {
      if (left) {
        l = sqrt(l);
        dVal = str(l);
      } else if (!left) {
        r = sqrt(r);
        dVal = str(r);
      }
    } else if (opB[i].on && opB[i].val.equals("\n  =")) {
      performCalc();
    } else if (opB[i].on && opB[i].val.equals("X")) {
      dVal = dVal + "x";
      op = "";
    }  else if (opB[i].on && opB[i].val.equals("*π")) {
      dVal = "0";
      op = "*π";
      left = false;
    } 
    println("L:" + l + " Op:" + op + " R:" + r + " Result:" + result + " Left:" + left);
  }
}

void updateDisplay() {
  fill(255);
  rect(50, 50, 575, 125);
  fill(0);
  textAlign(RIGHT);
  textSize(90);
  if (dVal.length()<12) {
    textSize(80);
  } else if (dVal.length()<13) {
    textSize(75);
  } else if (dVal.length()<14) {
    textSize(72);
  } else if (dVal.length()<15) {
    textSize(69);
  } else if (dVal.length()<16) {
    textSize(66);
  } else if (dVal.length()<17) {
    textSize(63);
  } else if (dVal.length()<18) {
    textSize(60);
  } else if (dVal.length()<19) {
    textSize(57);
  } else if (dVal.length()<20) {
    textSize(54);
  } else if (dVal.length()<21) {
    textSize(51);
  } else if (dVal.length()<22) {
    textSize(48);
  } else if (dVal.length()<23) {
    textSize(45);
  } else if (dVal.length()<24) {
    textSize(42);
  } else if (dVal.length()<25) {
    textSize(39);
  } else if (dVal.length()<26) {
    textSize(36);
  } else if (dVal.length()<27) {
    textSize(33);
  } else if (dVal.length()<28) {
    textSize(30);
  } else if (dVal.length()>=28) {
    textSize(32);
    dVal = "ERROR: Shorten the number";
  }
  text(dVal, width-100, 150);
}

void performCalc() {
  if (op.equals("+")) {
    result = l+r;
  } else if (op.equals("-")) {
    result = l-r;
  } else if (op.equals("*")) {
    result = l*r;
  } else if (op.equals("/")) {
    result = l/r;
  } else if (op.equals("(-)")) {
    result = l*-1;
  } else if (op.equals("*π")) {
    result = l*3.1415927;
  }
  dVal = str(result);
  l = result;
  left = true;
}

void handleEvent(String val, boolean num) {
  if (num) {
    if (dVal.equals("0")) {
      dVal = val;
      if (left) {
        l = float(dVal);
      } else if (!left) {
        r = float(dVal);
      }
    } else if (dVal.length()<28) {
      dVal = dVal + val;
      if (left) {
        l = float(dVal);
      } else if (!left) {
        r = float(dVal);
      }
    }
    //} else  if (val.equals("  CLR")) {
    //  dVal = "0";
    //  op ="";
    //  left = true;
    //  r = 0.0;
    //  l = 0.0;
    //  result = 0.0;
    //} else if (val.equals("+")) {
    //  left = false;
    //  dVal = "0";
    //  op = "+";
    //} else if (val.equals("\n  =")) {
    //  performCalc();
    //} else if (val.equals("-")) {
    //  left = false;
    //  dVal = "0";
    //  op = "-";
    //} else if (val.equals("*")) {
    //  left = false;
    //  dVal = "0";
    //  op = "*";
    //} else if (val.equals("/")) {
    //  left = false;
    //  dVal = "0";
    //  op = "/";
    //} else if (val.equals(".")) {
    //  if (!dVal.contains(".") || dVal.contains(".0")) {
    //    dVal = dVal + ".";
    //  }
  }
}

void keyPressed() {
  print("key:" + key);
  println("keyCode:" + keyCode);
  if (keyPressed) {
    if (keyCode == 49 || keyCode == 97) {
      handleEvent("1", true);
    } else if (keyCode == 50 || keyCode == 98) {
      handleEvent("2", true);
    } else if (keyCode == 51 || keyCode == 99) {
      handleEvent("3", true);
    } else if (keyCode == 52 || keyCode == 100) {
      handleEvent("4", true);
    } else if (keyCode == 53 || keyCode == 101) {
      handleEvent("5", true);
    } else if (keyCode == 54 || keyCode == 102) {
      handleEvent("6", true);
    } else if (keyCode == 55 || keyCode == 103) {
      handleEvent("7", true);
    } else if (keyCode == 56 || keyCode == 104) {
      handleEvent("8", true);
    } else if (keyCode == 57 || keyCode == 105) {
      handleEvent("9", true);
    } else if (keyCode == 48 || keyCode == 96) {
      handleEvent("0", true);
    }
  }
}
