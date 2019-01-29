
class LSystemBuffer {

  private String buf;
  private float theta;
  private float treeBranch;

  LSystemBuffer(String init) {
    this.buf = init;
    this.theta = 22.5 * PI / 180;
    this.treeBranch = 5;
  }

  public void printBuffer() {
    //for (char c : buf) {
    //  print(c);
    //}
    //println();
    println(buf);
  }

  public int getLength() {
    return buf.length();
  }

  public char get(int index) {
    char[] ca_buf = this.buf.toCharArray();
    if (index > ca_buf.length) {
      println("out of array exception");
      exit();
    }
    return ca_buf[index];
  }

  // index の 部分に string をつなぐ
  private void replace(int index, String str) {
    String former = this.buf.substring(0, index);// index(を含めない)まで の文字列
    String latter = this.buf.substring(index+1); // index(を含めない)以降の文字列
    buf = former + str + latter;
  }

  public void update(LinkedHashMap<Integer, String> source) {
    ArrayList<Integer> c_indexList = new ArrayList<Integer>(source.keySet());
    // here, c_ means change, o_ means origin
    for (int i = c_indexList.size() - 1; i >= 0; i--) {
      int index = c_indexList.get(i);
      String o_str = source.get(index);
      String c_str = rule.get(o_str);
      //println(index + ", " + c_str);
      this.replace(index, c_str);
    }
    this.printBuffer();
  }

  public void drawTree() {
    // here, ca_ means char buffer
    char[] ca_buf = this.buf.toCharArray();
    int hue = 0;
    colorMode(HSB);
    pushMatrix();
    for (int i = 0; i < ca_buf.length; i++) {
      if (ca_buf[i] == '1' || ca_buf[i] == '0') {
        continue;
        // 描画時は 0, 1 を無視
      }
      if (ca_buf[i] == 'F') {
        stroke(0);
        line(0, 0, 0, treeBranch);
        translate(0, treeBranch);
      }
      if (ca_buf[i] == '[') {
        pushMatrix();
        treeBranch /= 1.1;
        i++;
        if (ca_buf[i] == '+') {
          rotate(theta);
        } else if (ca_buf[i] == '-') {
          rotate(-theta);
        }
      }
      if (ca_buf[i] == ']') {
        popMatrix();
        treeBranch *= 1.1;
      }
    }
    popMatrix();
  }
}
