import java.util.Map;
import java.util.LinkedHashMap;

LSystemBuffer buffer =  new LSystemBuffer("F1F1F1");
Rule rule;

// 文字列と数値列を分けて考える.
// TODO: String は使いたくない
void setup() {
  size(600, 600);
  String[] keys = {
    "000", 
    "001", 
    "010", 
    "011", 
    "100", 
    "101", 
    "110", 
    "111", 
    "+", 
    "-", 
  };
  String[] values = {
    "1", 
    "1[-F1F1]", 
    "1", 
    "1F0", 
    "0", 
    "1F1", 
    "1", 
    "0", 
    "-", 
    "+"
  };
  rule = new Rule(keys, values);
  for (int i = 0; i < 50; i++) {
    //generate();
  }
}

float y;
void draw() {
  background(255);
  fill(0);
  translate(width/2, height);
  scale(1, -1);
  //rotate(-22.5 * PI / 180);
  //ellipse(0, y, 10, 10);
  //y++;
  generate();
  buffer.drawTree();
}

void generate() {
  LinkedHashMap<Integer, String> result = new LinkedHashMap<Integer, String>(); // index and change value
  for (int i = 0; i < buffer.getLength(); i ++) {
    HashMap<Integer, String> str_w_index = searchReccursive(i);
    if (str_w_index == null) {
      continue;
    }
    result.putAll(str_w_index);
  }
  buffer.update(result);
}


HashMap<Integer, String> searchReccursive(int from) {
  String concat = "";
  int len = buffer.getLength();
  int[] indexStack = new int[3];
  int s_index = 0;
  HashMap<Integer, String> result = new HashMap<Integer, String>();

  while (concat.length() < 3 && from < len) {
    char c = buffer.get(from);
    if (c == '+') {
      // + は強制的に - へ
      result.put(from, "+");
      return result;
    } else if (c == '-') {
      // - は強制的に + へ
      result.put(from, "-");
      return result;
    }
    if (c != '0' && c != '1') {
      if (concat.equals("")) {
        return null;
      }
      from++;
      continue;
    }
    concat += c;
    indexStack[s_index++] = from;
    from++;
  }
  if (concat.length() < 3) {
    println("not found");
    return null;
  }
  //println(concat);
  result.put(indexStack[1], concat);
  return result;
}
