
Mover m;

void setup() {
  size(600, 400);
  m = new Mover();
}

void draw() {
   background(255);
   m.update();
   m.checkEdges();
   m.display();
}
