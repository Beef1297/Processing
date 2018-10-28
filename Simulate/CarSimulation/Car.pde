// Move class を 継承
class Car extends Mover{
  
  public void up() {
     this.velocity.add(new PVector(0.01, 0.01));
  }
  public void down() {
    this.velocity.sub(new PVector(0.01, 0.01));
  }
  public void display() {
    noStroke();
    fill(125, 100, 80);
    pushMatrix();
    translate(location.x, location.y, 0);
    box(50);
    popMatrix();
  }
}
