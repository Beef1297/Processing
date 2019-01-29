Lines[] ls = {
  new Lines(0, 0, 15, -1),
  new Lines(0, 0, 15, -1),
  new Lines(0, 0, 15, -1),
  new Lines(0, 0, 15, -1),
  new Lines(0, - 600, 15, 1),
  new Lines(0, - 600, 15, 1),
  new Lines(0, - 600, 15, 1),
  new Lines(0, - 600, 15, 1)
};
void setup() {
  size(600, 600);
  colorMode(RGB);
  
}
float step;
void draw() {
  background(0);
  translate(0, height);
  stroke(255, 0, 0);
  fill(255, 255, 255);
  step += 0.01;
  
  for (Lines l : ls) {
    l.next();
    l.decline();
    l.show();
    if (l.finished()) {
      l.reset();
    }
  }
}
