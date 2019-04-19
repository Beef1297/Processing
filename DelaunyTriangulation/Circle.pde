
class Circle {

  Point center;
  float radius;
  
  public Circle(PVector c, float r) {
    this.center = c instanceof Point ? (Point) c : new Point(c);
    this.radius = r;
  }
  
  // for debug
  public void draw() {
    ellipse(center.x, center.y, radius * 2, radius * 2);
  }
  
}
