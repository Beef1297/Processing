
class Mover {
  PVector velocity;
  PVector location;
  
  public Mover() {
    velocity = new PVector(random(-2, 2), random(-2, 2));
    location = new PVector(random(width), random(height));
  }
  
  public void update() {
    location.add(velocity);
  }
  
  public void display() {
    noStroke();
    fill(125);
    ellipse(location.x, location.y, 16, 16);
  }
}
