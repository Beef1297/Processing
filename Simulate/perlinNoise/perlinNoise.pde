void setup() {
  size(600, 400);
  background(255);
  frameRate(24);
}

void draw() {
  loadPixels();
  
  for (int x = 0;x < width; x++) {
    for (int y = 0;y < height;y++) {
      float bright = random(255);
      pixels[x+y*width] = color(bright);
    }
  }
  
  jsdf
  updatePixels();
}
