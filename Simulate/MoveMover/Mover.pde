
class Mover {
  PVector velocity;
  PVector location;
  PVector acceleration;
  float topspeed;

  public Mover() {
    topspeed = 5;
    velocity = new PVector(0, 0);
    location = new PVector(random(width/2), random(height/2));
    acceleration = new PVector(-0.001, 0.01);
  }

  public float getLocX() {
    return location.x;
  }

  public float getLocY() {
    return location.y;
  }
  public float getVelX() {
    return velocity.x;
  }
  public float getVelY() {
    return velocity.y;
  }
  public void setVelX(float x) {
    velocity.x = x;
  }
  public void setVelY(float y) {
    velocity.y = y;
  }
  public void update() {
    acceleration = PVector.random2D();
    acceleration.mult(50);
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }
  public void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }

  public void display() {
    noStroke();
    fill(125);
    ellipse(location.x, location.y, 16, 16);
  }
}
