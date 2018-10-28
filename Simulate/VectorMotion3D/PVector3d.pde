
class PVector3d {
  float x;
  float y;
  float z;
  
  public PVector3d(float x_, float y_, float z_) {
    x = x_;
    y = y_;
    z = z_;
  }
  
  void add(PVector3d v) {
    x += v.x;
    y += v.y;
    z += v.z;
  }
}
