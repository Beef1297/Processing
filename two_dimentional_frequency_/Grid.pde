
class Grid {
  int w_detail;
  int h_detail;
  float  weight;

  public Grid() {
    w_detail = 10;
    h_detail = 10;
    weight = 0.5;
  }

  public Grid(int wd, int hd, float w) {
    w_detail = wd;
    h_detail = hd;
    weight = w;
  }

  public void grid() {
    strokeWeight(weight);
    stroke(10, 30, 50, 50);
    int x_scale = width / w_detail;
    int y_scale = height / h_detail;

    for (float x = 0; x< width; x += x_scale) {
      line(x, 0, x, height);
    }

    for (float y = 0; y < height; y += y_scale) {
      line(0, y, width, y);
    }
  }
}
