class Triangle {
  public Point p1, p2, p3;

  public Triangle(PVector p1, PVector p2, PVector p3) {
    this.p1 = p1 instanceof Point ? (Point)p1 : new Point(p1);
    this.p2 = p2 instanceof Point ? (Point)p2 : new Point(p2);
    this.p3 = p3 instanceof Point ? (Point)p3 : new Point(p3);
  }

  public boolean equals(Object obj) {
    try {
      Triangle t = (Triangle)obj;

      return (p1.equals(t.p1) && p2.equals(t.p2) && p3.equals(t.p3) ||
        p1.equals(t.p2) && p2.equals(t.p3) && p3.equals(t.p1) ||
        p1.equals(t.p3) && p2.equals(t.p1) && p3.equals(t.p2) ||

        p1.equals(t.p3) && p2.equals(t.p2) && p3.equals(t.p1) ||
        p1.equals(t.p2) && p2.equals(t.p1) && p3.equals(t.p3) || 
        p1.equals(t.p1) && p2.equals(t.p3) && p3.equals(t.p2));
    } 
    catch (Exception e) {
      println(e);
      return false;
    }
  }

  public int hashCode() {
    return 0;
  }

  public void draw() {
    beginShape();
    colorMode(HSB);
    strokeWeight(0.8);
    stroke(floor(abs((p1.x + p2.x + p3.x)) / 3.0) % 255, 255, 255, 50);

    fill((floor(abs(p1.y + p1.y + p1.y)) / 3.0) % 255, 255, 255, 50);
    vertex(p1.x, p1.y, p1.z);
    vertex(p2.x, p2.y, p2.z);
    vertex(p3.x, p3.y, p3.z);
    endShape(CLOSE);
    
    //triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
  }

  public boolean hasCommonPoints(Triangle t) {
    return (p1.equals(t.p1) || p1.equals(t.p2) || p1.equals(t.p3) ||
      p2.equals(t.p1) || p2.equals(t.p2) || p2.equals(t.p3) ||
      p3.equals(t.p1) || p3.equals(t.p2) || p3.equals(t.p3) );
  }
}   
