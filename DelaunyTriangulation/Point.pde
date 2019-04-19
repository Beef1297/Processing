
class Point extends PVector {

  
    public Point() {
      super();
    }
    public Point(float x, float y) {
      super(x, y);
    }
    public Point(float x, float y, float z) {
      super(x, y, z);
    }
    
    public Point(PVector v) {
      this.x = v.x;
      this.y = v.y;
      this.z = v.z;
    }
    
    
    public boolean equals(Object o) {      
      try {
        PVector p = (PVector)o;
        return (x == p.x && y == p.y && z == p.z);
      } catch (Exception e) {
        println(e);
        return false;
      }
    }
    
    public void draw() {
      point(x, y);
    }   
}
