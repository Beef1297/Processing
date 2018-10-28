import java.util.Random;
Random generator;

void setup() {
  size(640, 360);
  background(255);
  colorMode(HSB);
  generator = new Random();
}

void draw() {
  float numx = (float) generator.nextGaussian();
  float numy = (float) generator.nextGaussian(); 
  float sdx = 60;
  float sdy = 36;
  float meanx = 320;
  float meany = 180;
  
  float x = sdx * numx + meanx;
  float y = sdy * numy + meany;
  
  noStroke();
  color c;
  c = color(map(x, 0, width, 0, 255), 255, 255, 10);
  fill(c);
  ellipse(x, y, 8, 8);
}
