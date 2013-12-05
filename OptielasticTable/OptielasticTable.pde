import processing.serial.*;
Serial myPort;

Animation playing;
String message;
String newMessage;
//int frame = 5;

void setup() {
  size(700,700, P3D);
  myPort = new Serial(this, "/dev/cu.usbmodemfa141", 9600);
  playing = new Animation(this, "bootup2.gif", 25, 50);
}

void draw() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();   
    if (inBuffer != null) {
      println(inBuffer);
    }
  }

  newMessage = "";
  
  int speed = 5;
  int duration = playing.animationPreview.length;
  int frame = frameCount/speed-((frameCount/speed)/duration)*duration;
  
  background(25);
  image(playing.preview(frame),10,10);
  
  pushMatrix();
  spotLight(255, 255, 255, width/2, height/2, 400, 0, 0, -1, PI/4, 2);
  
  if (mousePressed == true) {
    cursor(HAND);
    camera(mouseX*2-width/2, mouseY*2-height, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  } else {
    noCursor();
  }
    translate(width/2-110, height/2-110, 0);
    rotateX(PI/5);
    
    fill(0,50);
    noStroke();
    pushMatrix();
    translate(110,110,-1);
    box(375,375,0);
    popMatrix();
    stroke(1);
    
    for (int j=0; j<playing.aWidth; j++) {
      pushMatrix();
      for (int k=0; k<playing.aHeight/2; k++) {
        newMessage += char(unbinary(
          binary(int(map(red(playing.data(frame,j,k).led()),0,255,0,7))).substring(29) +
          binary(int(map(green(playing.data(frame,j,k).led()),0,255,0,7))).substring(29) +
          binary(int(map(blue(playing.data(frame,j,k).led()),0,255,0,3))).substring(30)));
        newMessage += int(map(red(playing.data(frame,j,k).volume()),0,255,0,9));
        
        pushMatrix();
        translate(0,0,red(playing.data(frame,j,k).volume())/4.0);
        fill(playing.data(frame,j,k).led());
        box(50,50,red(playing.data(frame,j,k).volume())/2.0);
        popMatrix();
        translate(0, 55, 0);
      }
      popMatrix();
      translate(55, 0, 0);
    }
  popMatrix();
  
  newMessage = newMessage + "!@#";
  if (!newMessage.equals(message)) {
    message = newMessage;
    myPort.write(message);
  }
}

void keyReleased() {
  if (key == '1') {
//      frame = 0;
      playing = new Animation(this, "bootup2.gif", 25, 50);
  } else if (key == '2') {
//      frame = 0;
      playing = new Animation(this, "ripple.gif", 25, 50);
  } else if (key == '3') {
//      frame = 0;
      playing = new Animation(this, "arrow.gif", 25, 50);
  } else if (key == '4') {
//      frame = 0;
      playing = new Animation(this, "arrow2.gif", 25, 50);
  }
  
//  if (key == CODED) {
//    if (keyCode == RIGHT) {
//      frame += 1;
//    } else if (keyCode == LEFT) {
//      frame -= 1;
//    }
//    if (frame > playing.animationPreview.length - 1) { frame = 0; }
//    if (frame < 0) { frame = 45; }
//  }
}
