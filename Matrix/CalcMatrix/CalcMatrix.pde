
void setup() {
  size(600, 400);
  frameRate(30);
}

float theta = 0;
void draw() {
  // clear
  background(#f5deb3);

  // 原点の移動
  translate(width/2, height/2);
  scale(1, -1);

  // 環境
  Grid();

  // 描画

  // color
  noFill();
  stroke(0);
  strokeWeight(1);

  //rect(0, 0, 40, 30);
  Vector2D a = new Vector2D(0, 0);
  Vector2D b = new Vector2D(40, 0);
  Vector2D c = new Vector2D(40, 30);
  Vector2D d = new Vector2D(0, 30);
  beginShape(QUAD);
  vertex(a.x, a.y); 
  vertex(b.x, b.y);
  vertex(c.x, c.y); 
  vertex(d.x, d.y);
  endShape();

  // matrix
  float[][] R = {
    {cos(radians(theta)), sin(radians(theta))}, 
    {-sin(radians(theta)), cos(radians(theta))}
  };
  Matrix2D.coordinateTransform(a, R);
  Matrix2D.coordinateTransform(b, R);
  Matrix2D.coordinateTransform(c, R);
  Matrix2D.coordinateTransform(d, R);
  beginShape(QUAD);
  vertex(a.x, a.y); 
  vertex(b.x, b.y);
  vertex(c.x, c.y); 
  vertex(d.x, d.y);
  endShape();
  theta += 0.1;
}

void Grid() {
  // center line
  stroke(80);
  strokeWeight(1);
  line(0, -height/2, 0, height/2);
  line(-width/2, 0, width/2, 0);

  stroke(100);
  strokeWeight(0.25);
  int interval = 10;
  for (int i = -width/2; i <= width/2; i += interval) {
    line(i, -height/2, i, height/2);
  }
  for (int j = -height/2; j < height/2; j +=interval) {
    line(-width/2, j, width/2, j);
  }
}
