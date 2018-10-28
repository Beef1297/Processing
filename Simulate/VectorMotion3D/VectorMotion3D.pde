PVector3d location;
PVector3d velocity;

void setup() {
  size(500, 500, P3D);
  location = new PVector3d(100, 100, 100);
  velocity = new PVector3d(2.5, 3, 5);
}

void draw() {
  background(255);

  location.add(velocity);
  if ((location.x > 300 || location.x < 0)) {
    velocity.x *= -1;
  }
  if ((location.y > 300 || location.y < 0)) {
    velocity.y *= -1;
  }
  if ((location.z > 300 || location.z < 0)) {
    velocity.z *= -1;
  }

  pushMatrix();
  noFill();
  translate(width/2, height/2, 0);
  rotateY(PI/3);
  stroke(0);
  box(300);
  fill(125);
  noStroke();
  translate(location.x - 150, location.y - 150, location. z - 150);
  sphere(16);
  popMatrix();
}
