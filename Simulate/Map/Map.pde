int[] Map = new int[100];
void setup(){
  int sum = 0;
  size(600, 400);
  background(255);
  stroke(0);
  for(int i=0;i < 1000;i++) {
    Monkey m = new Monkey();
    sum += m.getTall();
    int index = m.getTall() - 200; // 正規化
    Map[index] ++;
  }
  println(sum/1000);
}

void draw() {
  background(255);
  translate(0, height/2);
  scale(1, -1);
  for(int i=0;i < Map.length - 1;i++) {
    float x1 = map(i, 0, 100, 0, 600);
    float x2 = map(i+1, 0, 100, 0, 600);
    line(x1, Map[i], x2, Map[i+1]);   
  }
}
