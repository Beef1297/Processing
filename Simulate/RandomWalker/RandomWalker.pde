
Walker w;
void setup() {
  size(640, 360);
  w = new Walker();
  background(255);
  frameRate(60);
}

void draw() {
  w.step();
  w.display();
  
}
