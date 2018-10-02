

public class DrawObject {
  private float hue;
  private float alpha;
  private float x, y;
  private float d;

  public DrawObject(float x, float y, float hue, float alpha, float d) {
    this.hue = hue;
    this.alpha = alpha;
    this.x = x;
    this.y = y;
    this.d = d;
  }

  public boolean update(){
    this.alpha -= 10;
    return this.alpha < 0;
  }
  
  public void drawEllipse() {
    fill(this.hue, 360, 360, this.alpha);
    ellipse(this.x, this.y, this.d, this.d);
  }

  public float getAlpha() {
    return this.alpha;
  }
}
