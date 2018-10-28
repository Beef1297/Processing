
class PVector {
  private float x;
  private float y;
  
  public PVector(float x_, float y_) {
    x = x_;
    y = y_;
  }
  
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
  public void setX(float x_) {
    x = x_;
  }
  public void setY(float y_) {
    y = y_;
  }
  public void add(PVector v) {
    x += v.getX();
    y += v.getY();
  }
}
