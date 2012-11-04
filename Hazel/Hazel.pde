import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

PFont f1;
PFont f2;

PImage imgw;
PImage imgb;

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
int brit = 0;
int sat = 0;

boolean spacebar = false;

void setup() {
  size(screenWidth,screenHeight);
  imgw = loadImage("logo-w.png");
  imgb = loadImage("logo-b.png");
  f1 = createFont("Arial",16,true);
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
  
  colorMode(HSB, 360, 100, 100);
  
  red = arduino.analogRead(redpin);
  green = arduino.analogRead(greenpin);
  blue = arduino.analogRead(bluepin);
  lum = (red + blue + green) / 3;
  brit = round(lum/2.55);
  sat = 56;
  
  noStroke();
  if (spacebar) {
    fill(30, sat, brit);
    rect(width/2,0,width/2,height);
  } else {
    fill(30, sat, brit);
    rect(0,0,width,height);
  }
  
  copy(width/2-60, 0, 60, 120, width/2-60, height/2-60, 60, 120);
  
  if (lum > 127) {
    image(imgb,width/2-60,height/2-60);
  } else {
    image(imgw,width/2-60,height/2-60);
  }
  
  textFont(f1);
  textAlign(CENTER);
  if (spacebar) {
    if (lum > 127) {
      fill(#000000);
    } else {
      fill(#ffffff);
    }
    text(100-round(lum/2.55),width*.75,height/2+5);
  } else {
    text(100-round(lum/2.55),width/2,height/2+5);
  }
  
  delay(200);
}

void keyPressed() {
  if (key == ' ') {
    fill(30, sat, brit);
    rect(0,0,width,height);
    if (lum > 127) {
      image(imgb,width/2-60,height/2-60);
      fill(#000000);
    } else {
      image(imgw,width/2-60,height/2-60);
      fill(#ffffff);
    }
    textFont(f1);
    text(100-round(lum/2.55),width/4,height/2+5);
    if (spacebar == true) {
      spacebar = false;
    } else {
      spacebar = true;
    }
  }
}
