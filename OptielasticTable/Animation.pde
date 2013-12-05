import gifAnimation.*;

class Animation {
  public PImage[] animationPreview;
  public int aWidth;
  public int aHeight;
  public int aPixelCount;
  public Pixel[][][] animationData;
  
  Animation(PApplet applet, String fileName,int pWidth, int pHeight) {
    this.animationPreview = Gif.getPImages(applet, fileName);
    this.aWidth = animationPreview[0].width;
    this.aHeight = animationPreview[0].height;
    this.aPixelCount = aWidth * aHeight;
    this.animationData = new Pixel[animationPreview.length][aWidth][aHeight/2];
    
    for (int i=0; i<animationPreview.length; i++) {
      PImage resizedFrame = createImage(pWidth,pHeight,RGB);
      PImage pixelPreview = createImage((resizedFrame.width/aWidth),(resizedFrame.height/aHeight),RGB);
      animationPreview[i].loadPixels();
      
      for (int j=0; j<aPixelCount; j++) {
        int row = (j/aWidth);
        int col = j-(row*aWidth);
        
        if (j < aPixelCount / 2) {
          animationData[i][col][row] = new Pixel(animationPreview[i].pixels[j], animationPreview[i].pixels[j+25]);
        }
        
        pixelPreview.loadPixels();
        for (int k=0; k<(pixelPreview.width*pixelPreview.height); k++) {
          pixelPreview.pixels[k] = animationPreview[i].pixels[j];
        }
        pixelPreview.updatePixels();
        
        resizedFrame.copy(pixelPreview,0,0,pixelPreview.width,pixelPreview.height,col*pixelPreview.width,row*pixelPreview.height,pixelPreview.width,pixelPreview.height);
      }
      
      animationPreview[i] = resizedFrame;
      animationPreview[i].updatePixels();
    }
  }
  
  Animation(PApplet applet, String fileName) {
    this(applet, fileName, width, height);
  }
  
  Pixel data(int frame, int x, int y) {
    return animationData[frame][x][y];
  }
  
  Pixel[][][] data() {
    return animationData;
  }
  
  PImage preview(int frame) {
    return animationPreview[frame];
  }
  
  PImage[] preview() {
    return animationPreview;
  }
}

class Pixel {
  color led;
  color volume;
  
  Pixel(color led, color volume) {
    this.led = led;
    this.volume = volume;
  }
  
  void led(color led) {
    this.led = led;
  }
  
  color led() {
    return led;
  }
  
  void volume(color volume) {
    this.volume = volume;
  }
  
  color volume() {
    return volume;
  }
}
