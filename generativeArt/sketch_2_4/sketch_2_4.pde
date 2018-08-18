import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

import ddf.minim.*;

PostFX fx;
Minim minim;
AudioInput in;
boolean flag = true;
void setup() {

  size(700, 700, P3D);
  background(150);
  //stroke(0, 50);
  noStroke();
  fill(255, 200);
  frameRate(60);
  fx = new PostFX(this);
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 256);
}
float xstart = random(20);
float ynoise = random(20);
void draw() {
    flag = false;
    background(150);
    lights();
    quaria(xstart, ynoise);
    //fx.render().sobel().compose();
}

void quaria(float xstart, float ynoise) {
  //int xsig, ysig;
  float sl, sr;
  translate(width/2, height/2, 0);
  for (float y = -(height/8); y <= (height/8); y+=3) {
    sr = in.right.get(int(y+128));
    ynoise += 0.02 + sr*sr;
    float xnoise = xstart;
    for (float x = -(width/8); x <= (width/8); x+=3) {
      sl = in.left.get(int(x+128));
      xnoise += 0.02 + sl*sl;
      float noise = noise(xnoise, ynoise);
      drawPoint(x, y, sr*sl, noise);
    }
  }
}

void drawPoint(float x, float y, float z, float noiseFactor) {
  pushMatrix();
  translate(x * noiseFactor * 4, y * noiseFactor * 4, z);
  float edgeSize = noiseFactor * 5;
  sphere(edgeSize);
  popMatrix();
}
