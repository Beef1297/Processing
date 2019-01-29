
class Lines {
  
  ArrayList<PVector>positions = new ArrayList<PVector>();
  PVector now;
  PVector init;
  int top;
  int step;
  int sign;
  Lines(float x_, float y_, int step_, int sign_) {
    positions.add(new PVector(x_, y_));
    now = positions.get(0);
    init = new PVector(x_, y_);
    step = step_;
    top = 0;
    sign = sign_;
  }
  
  void next() {
    float x = (random(0, 100) >= 50) ? step : 0;
    float y = sign *  (step - x);
    positions.add(new PVector(x + positions.get(top).x, y + positions.get(top).y));
    top++;
    now = positions.get(top);
  }
  
  void decline() {
    if (positions.size() >= 10) {
      positions.remove(0);
      top--;
    }
  }
  
  void show() {
    PVector prev = positions.get(0);
    int size = positions.size();
    int index = 0;
    for (PVector p : positions) {
      colorMode(HSB);
      stroke(255, 255, 255 - 50 * abs(size / 2 - index));
      strokeWeight(1);
      line(prev.x, prev.y, p.x, p.y);
      stroke(230, 200, 255 * noise(index/100));
      strokeWeight(0.1);
      line(prev.x + 0.1, prev.y + 0.1, p.x + 0.1, p.y + 0.1);
      line(prev.x - 0.1, prev.y - 0.1, p.x - 0.1, p.y - 0.1);
      prev = p;
      index++;
    }
  }
  
  boolean finished() {
    boolean result = false;
    if (now.x > width || now.y < -height) {
      result = true;
    }
    return result;
  }
  
  void reset() {
    positions = new ArrayList<PVector>();
    positions.add(new PVector(init.x, init.y));
    top = 0;
  }
  
}
