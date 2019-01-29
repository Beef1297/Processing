class Particle {

  PVector pos = new PVector();
  float r;
  float hue;
  
  Particle(float x, float y, float h) {
    pos.x = x;
    pos.y = y;
    r = 2;
    hue = h;
  }

  void update() {
    pos.x -= 1;
    pos.y += random(-4, 4);
    
    float angle = pos.heading();
    angle = constrain(angle, 0, PI / 6);
    float mag = pos.mag();
    pos = new PVector().fromAngle(angle);
    pos.setMag(mag);
  }
  
  void show() {
    hue = (hue + 1) % 100;
    fill(hue, 255, 255);
    stroke(hue, 255, 255);
    ellipse(pos.x, pos.y, r * 2, r * 2);
  }
  
  boolean finished() {
    boolean result = false;
    result = pos.x < 1;
    return result;
  }
  
  boolean intersects(ArrayList<Particle> snowflake) {
    boolean result = false;
    for (Particle s : snowflake) {
       float d = dist(s.pos.x, s.pos.y, pos.x, pos.y);
       if (d <= 2 * r) {
         result = true;
         break;
       }
    }
    return result;
  }
}
