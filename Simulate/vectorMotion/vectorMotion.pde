PVector velocity;
PVector location;

void setup() {
  size(600, 400);
  background(255);
  location = new PVector(100, 100);
  velocity = new PVector(2.5, 5);
}

void draw() {
  background(255);
  
  location.add(velocity);
  if ((location.getX() > width || location.getX() < 0)) {
    velocity.setX(velocity.getX() * -1);
  }
  if ((location.getY() > height || location.getY() < 0)) {
    velocity.setY(velocity.getY() * -1);
  }
  
  stroke(0);
  fill(175);
  ellipse(location.getX(), location.getY(), 16, 16);
  
}
