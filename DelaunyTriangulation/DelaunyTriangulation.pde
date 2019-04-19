import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;

/*
  source code is from http://tercel-sakuragaoka.blogspot.com/2011/06/processingdelaunay_3958.html
 great blog
 
 something is wrong with my code...
 */

DelaunayTriangles delaunay;
ArrayList ptList;
void setup() {
  size(1080, 960, P3D);
  ptList = new ArrayList();

  frameRate(5);
}

void draw() {

  background(255);
  strokeWeight(0.8);
  smooth();

  pushMatrix();
  translate(width / 2, height / 2);
  rotateY(frameCount / 10);
  int num = 0;
  for (float t = 0; t <= TWO_PI; t += PI / 10.0 + random(PI / 45.0)) {
    for (float p = 0; p <= TWO_PI; p += PI / 10 + random(PI / 45.0)) {
      float x = 500 * cos(t) * sin(p);
      float y = 500 * sin(t) * sin(p);
      float z = 500 * sin(t);
      ptList.add(new Point(x, y, z));
      num++;
    }
  }
  println(num);

  delaunay = new DelaunayTriangles(ptList);
  delaunay.draw();
  popMatrix();

  ptList.clear();
}
