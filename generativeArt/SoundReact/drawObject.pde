

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

  public boolean update() {
    this.alpha -= d/10;
    return this.alpha < 0;
  }

  public void drawEllipse() {
    fill(this.hue, 360, 360, this.alpha);
    ellipse(this.x, this.y, this.d, this.d);
    return;
  }

  public void drawNoiseEllipse() {
    float radius = this.d / 2;
    float xposNoise = random(10);
    float yposNoise = random(10);
    fill(this.hue, 360, 360, this.alpha);
    
    beginShape();
    for (int ang = 0; ang <= 720; ang+=1) {
      xposNoise += 0.06;
      yposNoise += 0.05;
      float biasX = noise(xposNoise) * 60;
      float biasY = noise(yposNoise) * 90;
      float x = this.x + radius * cos(radians(ang)) + biasX;
      float y = this.y + radius * sin(radians(ang)) + biasY;
      vertex(x, y);
    }
    endShape();
    
    return;
  }
  
  public float getAlpha() {
    return this.alpha;
  }
}
