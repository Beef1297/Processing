import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

import ddf.minim.*;

PostFX fx;
Minim minim;
AudioInput in;

void setup() {

  size(700, 700, P3D);
  noStroke();
  colorMode(HSB, 255);
  fill(255, 200);
  frameRate(30);
  fx = new PostFX(this);
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 256);
}
float xstart = random(20);
float ynoise = random(20);
void draw() {

    background(0);
    lights();
    quaria(xstart, ynoise);
    fx.render()
      .blur(10, .6)
      .bloom(.3, 10, 20)
      .compose();
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

  fill(120, abs(z*50000)%255, 255);
  pushMatrix();
  translate(x * noiseFactor * 4, y * noiseFactor * 4, z);
  float edgeSize = noiseFactor * 5;
  sphere(edgeSize);
  popMatrix();
}