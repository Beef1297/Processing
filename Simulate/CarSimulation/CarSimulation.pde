
Car c;
void setup() {
  size(600, 400, P3D);
  c = new Car();
}

void draw() {
  background(255);
  c.update();
  c.checkEdges();
  pushMatrix();
  translate(width/2, height/2, -200);
  rotateY(PI/3);
  rotateX(-PI/1.5);
  _drawAxis();
  c.display();
  popMatrix();
}

void keyPressed() {
  if (keyCode == UP) {
    c.up();
  }
  if (keyCode == DOWN) {
    println("down");
    c.down();
  }
}

void _drawAxis() {
  strokeWeight(5);
  stroke(255, 0, 0);
  line(0, 0, 0, 999, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 999, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 999);
}
