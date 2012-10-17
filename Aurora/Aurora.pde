import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont f;

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

void setup() {
  size(500,500);
  f = createFont("Arial",16,true);
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
  
  background(red, green, blue);
  //background(lum);
  
  textFont(f);
  fill(255);
  textAlign(CENTER);
  text("R:" + red + " G:" + green + " B:" + blue,width/2,100);
  
  text("L:" + lum,width/2,150);
  
  delay(200);
}
