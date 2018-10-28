
class PVector {
  float x;
  float y;
  
  public PVector(float x_, float y_) {
    x = x_;
    y = y_;
  }
  
  public void add(PVector v) {
    x += v.x;
    y += v.y;
  }
}
