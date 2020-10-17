import javax.swing.JColorChooser;
import java.awt.Color;
import controlP5.*;
import drop.*;

// Constants
int Y_AXIS = 1;
int X_AXIS = 2;
int R = 111;
int G = 111;
int B = 111;
color RGB_COLOR = color(R,G,B);
float SHADOW_RATIO = 0.9;
SDrop drop;

PGraphics alphaG;
PImage img;

ControlP5 cp5;

ColorPicker cp;

void setup() {
  size(512,512);
  imageMode(CENTER);
  
  drop = new SDrop(this);
  cp5 = new ControlP5(this);
  cp = cp5.addColorPicker("picker")
          .setPosition(130, 420)
          .setColorValue(color(R, G, B, 255))
          ;
}

void draw() {
  background(0,0,0,0);
  alphaG = createGraphics(width,height, JAVA2D);
  alphaG.imageMode(CENTER);
  alphaG.smooth();
  alphaG.beginDraw();
  draw_hex();
  if (img != null) alphaG.image(img, 512/2, 512/2, width/1.5, height/1.5);
  draw_gradient();
  alphaG.endDraw();
  image(alphaG, 512/2, 512/2);
}

void draw_gradient() {
    for (int i=0; i<186;i++) {
        setGradient(66 + i,int(360 + i*(359-465)/(66-252)));
    }
    for (int i=0; i<(260 - 254); i++) {
        setGradient(252 + i,465);
    }
    for (int i=0; i<186;i++) {
        setGradient(258 + i,int(465 - i*(359-465)/(66-252)));
    }
}
  
void draw_hex() {
    draw_shadow();
    alphaG.fill(cp.getColorValue());
    alphaG.strokeWeight(0);
    alphaG.beginShape();
    alphaG.smooth();
    alphaG.vertex(66,133);
    alphaG.vertex(254,24);
    alphaG.vertex(258,24);
    alphaG.vertex(446,133);
    alphaG.vertex(446,359);
    alphaG.vertex(260,465);
    alphaG.vertex(252,465);
    alphaG.vertex(66,359);
    alphaG.endShape(CLOSE);
}
    
void draw_shadow() {
    color curr_color = cp.getColorValue();
    color shadow_color=color(red(curr_color)*SHADOW_RATIO, green(curr_color)*SHADOW_RATIO, blue(curr_color)*SHADOW_RATIO, alpha(curr_color));
    alphaG.fill(shadow_color);
    alphaG.strokeWeight(0);
    alphaG.beginShape();
    alphaG.vertex(66,358);
    alphaG.vertex(252,465);
    alphaG.vertex(260,465);
    alphaG.vertex(446,358);
    alphaG.vertex(446,377);
    alphaG.vertex(258,486);
    alphaG.vertex(254,486);
    alphaG.vertex(66,377);
    alphaG.endShape(CLOSE);
}

void setGradient(int x, int y) {
  color c1 = color(0,0,0,255);
  color c2 = color(0,0,0,0);
  float w = 1;
  float h = 18;
  noFill();
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      alphaG.stroke(c);
      alphaG.line(x, i, x+w, i);
    }
}


void dropEvent(DropEvent theDropEvent) {
  if(theDropEvent.isImage()) {
    img = theDropEvent.loadImage();
  }
}

void keyPressed() {
  switch(key) {
    case(' '):
    alphaG.save("output.png");
    break;
  }
}
