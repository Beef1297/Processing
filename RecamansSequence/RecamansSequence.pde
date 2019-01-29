Boolean[] numbers = new Boolean[1000000];
ArrayList<Integer> sequence = new ArrayList<Integer>();
ArrayList<Arc> arcs = new ArrayList<Arc>();
int count = 1;
int index = 0;
int biggest = 0;

class Arc {

  float end;
  float start;
  int dir;

  public Arc(float end, float start, int dir) {
    this.end = end;
    this.start = start;
    this.dir = dir;
  }

  void show() {
    float d = abs(end - start);
    float x = (end + start) / 2.0;
    stroke(255);
    noFill();
    //ellipse(x, 0, d, d);
    if (dir % 2 == 0) {
      arc(x, 0, d, d,  0.0, PI);
    } else {
      arc(x, 0, d, d, PI, TWO_PI);
    }
  }
}

void setup() {
  //size(600, 600);
  fullScreen();
  background(0);
  for (int i = 0; i < numbers.length; i++) {
    numbers[i] = false;
  }
  numbers[index] = true;
  sequence.add(index);
  frameRate(60);
}

void step() {
  int next = index - count;
  if (next < 0 || numbers[next]) {
    next = index + count;
  }
  sequence.add(next);
  numbers[next] = true;

  Arc a = new Arc(next, index, count % 2);
  arcs.add(a);

  index = next;
  if (index > biggest) {
    biggest = index;
  }
  count++;
}

void draw() {
  step();
  translate(0, height / 2);
  scale(float(width / biggest) * 5);
  background(0);

  for (Arc a : arcs) {
    a.show();
  }
}
