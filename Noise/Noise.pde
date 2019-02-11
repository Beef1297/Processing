
void setup() {
 size(400, 400);
 colorMode(HSB, 360);
}

float xoff;
float yoff;
float xstep;
float ystep;

void draw() {

  int len = 1;
  xoff = random(0, 1);
  yoff = random(0, 1);;
  for (int i=0; i < width; i += len) {
    xstep = xoff; ystep = yoff;
    xoff += 0.004; yoff += 0.001;
    for (int j=0; j < height; j += len) {
        stroke(250, 360 * noise(xstep, ystep), 360);
        point(i, j);
        xstep += 0.004;
        ystep += 0.006;
    }
  }
  
}
