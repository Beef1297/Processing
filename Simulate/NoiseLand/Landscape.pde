
class Landscape {
  int scale;
  int w, h;
  int rows, colums;
  float[][]z;
  float zoff = 0.0;

  public Landscape(int _scl_, int _w_, int _h_) {
    this.scale = _scl_;
    this.w = _w_;
    this.h = _h_;
    this.rows = w / scale;
    this.colums = h / scale;
    z = new float[colums][rows];
  }
  /* the way of method, this is important. this is how to apply 3d noise */
  void calc() {
    float xoff = 0.0;
    for (int i = 0; i < colums; i++) {
      float yoff = 0.0;
      for (int j = 0; j < rows; j++) {
        z[i][j] = map(noise(xoff, yoff, zoff), 0, 1, -120, 120);
        yoff += 0.1;
      }
      xoff += 0.1;
    }
    zoff += 0.01;
  }
  
  void render() {
    for (int x = 0; x < z.length-1; x++) {
      beginShape(QUAD_STRIP);
      for (int y = 0; y < z[x].length; y++) {
        stroke(0);
        float currentElevation = z[x][y];
        float currentShade = map(currentElevation, -120, 120, 0, 255);
        fill(currentShade, 255);
        float xCoordinate = x * scale - w/2;
        float yCoordinate = y * scale - h/2;
        vertex(xCoordinate, yCoordinate, z[x][y]);
        vertex(xCoordinate + scale, yCoordinate, z[x+1][y]);
      }
      endShape();
    }
  }
}
