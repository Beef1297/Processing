
class Rule {
  
  private HashMap<String, String> rules = new HashMap<String, String>();
  
  Rule(String[] keys, String[] values) {
     if (keys.length != values.length) {
       println("wrong set of keys and values for Rule Class. keys: " + keys.length + " vals: " + values.length);
       exit();
     }
     int index = keys.length;
     for (int i = 0; i < index; i++) {
       rules.put(keys[i], values[i]);
     }
  }
  
  public void printRules() {
    for (Map.Entry<String, String> entry : rules.entrySet()) {
      String k = entry.getKey();
      String v = entry.getValue();
      println("key: " + k + "-> val: " + v);
    }
  }
  
  public String get(String key) {
    return rules.get(key);
  }
  
}
