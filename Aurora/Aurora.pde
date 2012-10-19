import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

PFont f1;
PFont f2;

final int ledpin = 13;
final int GSR1 = 12;
final int GSR0 = 11;
final int GSG1 = 10;
final int GSG0 = 9;
final int GSB1 = 8;
final int GSB0 = 7;

int redpin = 0;
int greenpin = 1;
int bluepin = 2;

int red = 0;
int green = 0;
int blue = 0;

int rrgb = 0;
int grgb = 0;
int brgb = 0;
int lum = 0;

boolean spacebar = false;

void setup() {
  size(750,750);
  f1 = createFont("Arial",16,true);
  f2 = createFont("Arial",12,true);
  arduino = new Arduino(this, Arduino.list()[4], 57600);
  
  arduino.pinMode(ledpin, Arduino.OUTPUT);
  arduino.pinMode(GSR1, Arduino.OUTPUT);
  arduino.pinMode(GSR0, Arduino.OUTPUT);
  arduino.pinMode(GSG1, Arduino.OUTPUT);
  arduino.pinMode(GSG0, Arduino.OUTPUT);
  arduino.pinMode(GSB1, Arduino.OUTPUT);
  arduino.pinMode(GSB0, Arduino.OUTPUT);
  
  arduino.digitalWrite(ledpin, Arduino.HIGH);
  
  arduino.digitalWrite(GSR1, Arduino.LOW);
  arduino.digitalWrite(GSR0, Arduino.LOW);
  arduino.digitalWrite(GSG1, Arduino.LOW);
  arduino.digitalWrite(GSG0, Arduino.LOW);
  arduino.digitalWrite(GSB1, Arduino.LOW);
  arduino.digitalWrite(GSB0, Arduino.LOW);
}

void draw() {
  
  red = arduino.analogRead(redpin);
  green = arduino.analogRead(greenpin);
  blue = arduino.analogRead(bluepin);
  lum = (red + blue + green) / 3;
  
  noStroke();
  if (spacebar) {
    fill(red, green, blue);
    rect(width/2,0,width/2,height/2);
    fill(lum);
    rect(width/2,height/2,width/2,height);
    fill(255);
    rect(width/2.0-40,14,80,24);
  } else {
    fill(red, green, blue);
    rect(0,0,width,height/2);
    fill(lum);
    rect(0,height/2,width,height);
    fill(255);
    rect(width/2.0-90,height/2-13,180,24);
  }
  
  if (lum > 127) {
    fill(0);
  } else {
    fill(255);
  }
  
  textFont(f1);
  textAlign(CENTER);
  if (spacebar) {
    text("R:" + round(red/2.55) + "% G:" + round(green/2.55) + "% B:" + round(blue/2.55) + "%",width*.75,height/4.0);
    text("L:" + round(lum/2.55) + "%",width*.75,height*.75);
    textFont(f2);
    fill(0);
    text("COMPARE", width/2, 30);
  } else {
    text("R:" + round(red/2.55) + "% G:" + round(green/2.55) + "% B:" + round(blue/2.55) + "%",width/2.0,height/4.0);
    text("L:" + round(lum/2.55) + "%",width/2.0,height*.75);
    textFont(f2);
    fill(0);
    text("press spacebar to compare", width/2, height/2 + 3);
  }
  
  delay(200);
}

void keyPressed() {
  if (key == ' ') {
    fill(red, green, blue);
    rect(0,0,width,height/2);
    fill(lum);
    rect(0,height/2,width,height);
    if (lum > 127) {
      fill(0);
    } else {
      fill(255);
    }
    textFont(f1);
    text("R:" + round(red/2.55) + "% G:" + round(green/2.55) + "% B:" + round(blue/2.55) + "%",width*.25,height/4.0);
    text("L:" + round(lum/2.55) + "%",width*.25,height*.75);
    if (spacebar == true) {
      spacebar = false;
    } else {
      spacebar = true;
    }
  }
}
