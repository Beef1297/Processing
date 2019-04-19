
class Particle extends PVector {
  public Particle() {
    super();
  }

  public Particle(float x, float y) {
    super(x, y);
  }

  public Particle(float x, float y, float z) {
    super(x, y, z);
  }

  public Particle(PVector v) {
    this.x = v.x;
    this.y = v.y;
    this.z = v.z;
  }

  public boolean equals(Object p) {
    try {
      if ((p instanceof PVector)) {
        PVector q = (PVector)p;
        return (x == q.x && y == q.y && z == q.z);
      } else {
        println("passed wrong parameter");
      }
    } 
    catch (Exception e) {
      print(e);
      return false;
    }
    return false;
  }

  public void show() {
    strokeWeight(3.0);
    stroke(30, 250, 50);
    point(x, y);
  }
  
  public void update() {
    float px = x;
    float py = y;
    
    if (px != x || py != y) {
      isUpdated = true;
    }
  }
}
