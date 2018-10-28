
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
  
  public void sub(PVector v) {
    x -= v.x;
    y -= v.y;
  }
  
  public void mult(float n) {
    x *= n;
    y *= n;
  }
  
  public void div(float n) {
    x /= n;
    y /= n;
  }
  public void normalize() {
    float m = mag();
    div(m);
  }
  public float mag() {
    return sqrt(x*x + y*y);
  }
  public void limit(float max) {
    if (this.mag() > max) {
      normalize();
      mult(max);
    }
  }
}
