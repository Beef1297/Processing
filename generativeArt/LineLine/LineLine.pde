
void setup() {
  size(600, 600);
  //fullScreen();
  colorMode(HSB);
}

float phi;
float tau = 50;
float dt = 1;
void draw() {
  translate(0, height / 2);
  background(255);
  stroke(0);
  float theta = 0;
  for (float  i = 0; i < width; i += 1) {
    float x = i;
    float y1 = 7 * sqrt(i) * sin(i / tau);
    float y2 = 7 * sqrt(i) * sin(i / tau) + 50;
    //ellipse(x, y1, 10, 10);
    drawLine(x, y1, y2, color(255, 255, 255, 150), theta);
    theta += PI / 90;
  }
  tau = ( tau + 1  * cos(phi / 200));
  phi ++;
}

float lerp = 0;
float dl = 0.1;
void drawLine(float x, float y1, float y2, color c, float theta) {
  strokeWeight(1);
  stroke(c);
  line(x, y1, x, y2);
  //line(x, y1, x, y2);
  for (float i = 1; i <= 4; i++) {
    pushMatrix();
    stroke(255 - i * 20, 255, 255, 250);
    translate(1, 0);
    line(x, y1, x, map(sin(theta / (i / 5)), -1, 1, y2, y1));
    popMatrix();
  }
  if (lerp > 1.0 || lerp < 0) {
    dl *= -1;
  }
  lerp += dl;
}
