
Landscape land;
float theta = 0.0;

void setup() {
  size(600, 200, P3D);
  background(255);
  land = new Landscape(20, 800, 400);
}

void draw() {
  background(255);
  pushMatrix();
  translate(width/2, height/2 + 20, -160);
  rotateX(PI/3);
  rotateZ(theta);
  land.render();
  popMatrix();
  
  land.calc();
  theta += 0.0025;
  
}
