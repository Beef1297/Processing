import java.util.LinkedList;
import java.util.ArrayDeque;

// related to LSystem
byte[] LSystem; // virtual pixel
byte[] rule;
int LSYSTEM_SIZE;
int RULE_SIZE;
float ROTATION_ANGLE;

// related to drawing
PVector dir;
PVector pos;
ArrayDeque<PVector> dirStack;
ArrayDeque<PVector> posStack;

// which one should I use byte or int... ;

void setup() {
  //fullScreen();
  size(600, 600);
  //background(255);
  LSYSTEM_SIZE = width * height;
  //println(LSYSTEM_SIZE);
  LSystem = new byte[LSYSTEM_SIZE];
  initializeVectors();
  initializeLSystem();
  initializeRule();
  //frameRate(30);
  //for (int i = 0; i < 10; i++) {    
  //  updateLSystemPixel();
  //}
  //drawLSystemTree();
  //for (int i = 0; i < 20; i++) {
  //  println(LSystem[i]);
  //}
}

void initializeVectors() {
  dir = new PVector(0, 1);
  pos = new PVector(0, 0);
  dirStack = new ArrayDeque<PVector>();
  posStack = new ArrayDeque<PVector>();
}

void initializeLSystem() {
  for (int i = 0; i < LSYSTEM_SIZE; i++) {
    LSystem[i] = 0;
  }
  LSystem[0] = 33; // 00100001 で初期化
}

// rule is just rule. dont care about specification
void initializeRule() {
  // lsystem production rules
  RULE_SIZE = 10;
  ROTATION_ANGLE = 22.5;
  rule = new byte[RULE_SIZE];
  rule[0] = 32;
  rule[1] = 4;
  rule[2] = 48; // +符号と並列化
  rule[3] = 2;
  rule[4] = 32;
  rule[5] = 4;
  rule[6] = 40; // -符号と並列化
  rule[7] = 2;
  /*
  rule[0] = 32;  // F
   rule[1] = 4;  // [
   rule[2] = 16;  // +
   rule[3] = 32;  // F
   rule[4] = 2;  // ]
   rule[5] = 32;  // F
   rule[6] = 4;  // [
   rule[7] = 8;  // -
   rule[8] = 32;  // F
   rule[9] = 2;  // ]
   */
}

void draw() {
  background(255);
  //println(frameRate);
  translate(width/2, height);
  scale(1, -1);

  updateLSystemPixel();
  drawLSystemTree();
}

void updateLSystemPixel() {
  // update lsystem production by rule
  byte[] nextLSystem = new byte[LSYSTEM_SIZE];
  int flag = LSystem[0] & 1; // 初期条件
  int i = 0;
  int j = 0;
  int resetFlag = 0;
  long time1 = System.nanoTime();
  while (flag == 1 && i < LSYSTEM_SIZE && j < LSYSTEM_SIZE && resetFlag == 0) {

    if (i >= LSYSTEM_SIZE || j >= LSYSTEM_SIZE) {
      println("LSystem overflow");
      resetFlag = 1;
      break;
    }

    if ((LSystem[i] & 32) > 0) {
      // convert and then copy;
      byte rotation = 0;
      if ((LSystem[i] & 16) > 0) rotation = 16;
      if ((LSystem[i] & 8 ) > 0) rotation = 8;
      for (int tmp = 0; tmp < RULE_SIZE; tmp++) {
        if (j + tmp >= LSYSTEM_SIZE) {
          resetFlag = 1;
          break;
        }
        nextLSystem[j + tmp] = byte(rule[tmp] + 1);
        if (tmp == 0) {
          nextLSystem[j + tmp] |= rotation;
          //println(nextLSystem[j + tmp]);
        }
      }
      j += RULE_SIZE;
      i++;
    } else {
      nextLSystem[j] = LSystem[i]; // just copy
      j++; 
      i++;
    }
    if (i >= LSYSTEM_SIZE) {
      resetFlag = 1;
      break;
    }
    flag = LSystem[i] & 1; // update flag
  }

  if (resetFlag == 1) {
    LSystem = new byte[LSYSTEM_SIZE];
    initializeLSystem();
  } else {
    LSystem = nextLSystem; // past LSystem memory will release automatically
  }
  long time2 = System.nanoTime();
  //println(time2 - time2);
}

float branchLengthAttenuation = 0.9;
float branchRadiusAttenuation = 0.6;
void drawLSystemTree() {
  int flag = LSystem[0] & 1;
  float branchLength = 10.0;
  float branchRadius = 5.0;
  int i = 0;
  dir.x = 0; 
  dir.y = 1;
  pos.x = 0; 
  pos.y = 0;
  while (flag == 1 && i < LSYSTEM_SIZE) {


    if ((LSystem[i] & 32) > 0) { // if true, value will be 32
      if ((LSystem[i] & 16) > 0) {
        dir.rotate(radians(ROTATION_ANGLE));
      } else if ((LSystem[i] & 8) > 0) {
        dir.rotate(radians(-ROTATION_ANGLE));
      }
      colorMode(RGB);
      stroke(161, 86, 28);
      strokeWeight(branchRadius);
      float newPosx = pos.x + branchLength * dir.x;
      float newPosy = pos.y + branchLength * dir.y;
      line(pos.x, pos.y, newPosx, newPosy);
      pos.x = newPosx;
      pos.y = newPosy;
    } else if ((LSystem[i] & 4) > 0) { // if true, value will be 4
      dirStack.push(dir.copy());
      posStack.push(pos.copy());
      branchLength *= branchLengthAttenuation;
      branchRadius *= branchRadiusAttenuation;
    } else if ((LSystem[i] & 2) > 0) { // if true, value will be 2
      dir = dirStack.pop();
      pos = posStack.pop();
      branchLength /= branchLengthAttenuation;
      branchRadius /= branchRadiusAttenuation;
      drawLeave(pos, dir, 10 / branchRadius);
    }
    i++;
    if (i >= LSYSTEM_SIZE) break;
    flag = LSystem[i] & 1;
  }
}

void drawLeave(PVector pos, PVector dir, float scl) {
  pushMatrix();
  translate(pos.x, pos.y);
  scale(scl, scl * 2);
  noStroke();
  fill(0, 225, 0);
  beginShape();
  vertex(0, 0);
  vertex(-dir.y / 2 + dir.x / 2, dir.x / 2 + dir.y / 2); //println(-dir.y / 2 + ", " + dir.x /2);
  vertex(dir.x, dir.y); //println(dir.x + ", " + dir.y);
  vertex(dir.y / 2 + dir.x / 2, dir.x / 2 + dir.y / 2); //println(dir.y / 2 + ", " + dir.x /2);
  endShape(CLOSE);
  popMatrix();
}
