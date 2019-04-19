
class DelaunayTriangles {

  public HashSet triangleSet;

  public DelaunayTriangles(ArrayList pointList) {
    DelaunayTriangulation(pointList);
  }

  public void DelaunayTriangulation(ArrayList pointList) {

    triangleSet = new HashSet();

    Triangle hugeTriangle = getHugeTriangle();
    triangleSet.add(hugeTriangle);

    try {

      println("start calcurate... ");

      for (Iterator pIter = pointList.iterator(); pIter.hasNext(); ) {
        Object element = pIter.next();
        Point p = element instanceof Point ? (Point) element : new Point((PVector)element);

        HashMap tmpTriangleSet = new HashMap(); // tempolary hashset

        for (Iterator tIter = triangleSet.iterator(); tIter.hasNext(); ) {
          Triangle t = (Triangle)tIter.next();

          Circle c = getCircumscribedCirclesOfTriangle(t);

          if (Point.dist(c.center, p) <= c.radius) {
            addElementToRedundanciesMap(tmpTriangleSet, new Triangle(p, t.p1, t.p2));
            addElementToRedundanciesMap(tmpTriangleSet, new Triangle(p, t.p2, t.p3));
            addElementToRedundanciesMap(tmpTriangleSet, new Triangle(p, t.p3, t.p1));

            tIter.remove();
          }
        }

        for (Iterator tmpIter = tmpTriangleSet.entrySet().iterator(); tmpIter.hasNext(); ) {
          Map.Entry entry = (Map.Entry)tmpIter.next();
          Object t = entry.getKey();

          boolean isUnique = ((Boolean)entry.getValue()).booleanValue();

          if (isUnique) {
            triangleSet.add(t);
          }
        }
      }

      for (Iterator tIter = triangleSet.iterator(); tIter.hasNext(); ) {
        Triangle t = (Triangle)tIter.next();
        if (hugeTriangle.hasCommonPoints(t)) {
          tIter.remove();
        }
      }
    } 
    catch (Exception e) {
      println(e);
      return;
    }
    println("calcurate done!");
  }

  public void draw() {
    for (Iterator it = triangleSet.iterator(); it.hasNext(); ) {
      Triangle t = (Triangle)it.next();
      t.draw();
    }
  }

  private void addElementToRedundanciesMap(HashMap hashMap, Object t) {
    if (hashMap.containsKey((Triangle)t)) {
      hashMap.put(t, new Boolean(false));
    } else {
      hashMap.put(t, new Boolean(true));
    }
  }

  private Triangle getHugeTriangle() {
    return getHugeTriangle(new PVector(0, 0), new PVector(width, height));
  }

  private Triangle getHugeTriangle(PVector start, PVector end) {
    if (end.x < start.x) {
      float tmp = start.x;
      start.x = end.x;
      end.x = tmp;
    }
    if (end.y < start.y) {
      float tmp = start.y;
      start.y = end.y;
      end.y = tmp;
    }

    Point center = new Point((end.x - start.x) / 2.0, (end.y - start.y) / 2.0);
    float radius = Point.dist(center, start) + 1.0; // the both of start and end is ok

    float x1 = center.x - sqrt(3) * radius;
    float y1 = center.y - radius;
    Point p1 = new Point(x1, y1);

    float x2 = center.x + sqrt(3) * radius;
    float y2 = center.y - radius;
    Point p2 = new Point(x2, y2);

    float x3 = center.x;
    float y3 = center.y + 2 * radius;
    Point p3 = new Point(x3, y3);

    return new Triangle(p1, p2, p3);
  }

  private Circle getCircumscribedCirclesOfTriangle(Triangle t) {
    /*
       regarding the position of center as x and y, calucurate Quadratic equation
     */

    float x1 = t.p1.x;
    float y1 = t.p1.y;
    float x2 = t.p2.x;
    float y2 = t.p2.y;
    float x3 = t.p3.x;
    float y3 = t.p3.y;

    float c = 2.0 * ((x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1));
    float x = ((y3 - y1) * (x2 * x2 - x1 * x1 + y2 * y2 - y1 * y1)
      + (y1 - y2) * (x3 * x3 - x1 * x1 + y3 * y3 - y1 * y1)) / c;
    float y = ((x1 - x3) * (x2 * x2 - x1 * x1 + y2 * y2 - y1 * y1)
      + (x2 - x1) * (x3 * x3 - x1 * x1 + y3 * y3 - y1 * y1)) / c;


    Point center = new Point(x, y);
    float r = Point.dist(center, t.p1);
    return new Circle(center, r);
  }
}
