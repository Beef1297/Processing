
PFont american_font;
PFont arialBoldItalic;
ArrayList<PFont> fonts;
ArrayList<String> textStrings ;

void setup() {
  size(600, 600);
  fonts = new ArrayList<PFont>();
  textStrings = new ArrayList<String>();
  
  fonts.add(loadFont("AmericanTypewriter-48.vlw"));
  fonts.add(loadFont("Arial-BoldItalicMT-48.vlw"));
  fonts.add(loadFont("BodoniOrnamentsITCTT-48.vlw"));
  fonts.add(loadFont("Chalkduster-48.vlw"));
  fonts.add(loadFont("Luminari-Regular-48.vlw"));
  frameRate(30);
}

float theta = height;
String input = "][]]()[]]][";
void draw() {
  float c = round(random(0, 1)) * 255;
  background(c, 100);

  //drawNoise();
  drawLine();

  int index = round(random(0, fonts.size() - 1));
  textFont(fonts.get(index));
  textSize(12);

  pushMatrix();
  translate(0, theta);
  theta--;
  fill(255);
  float offset = 0;
  for (String str : textStrings) {
    text(str, 0, offset);
    offset += 20;
  }
  textStrings.add(input);
  if (random(0, 1) >= 0.9){ 
    input += "@";
  } else if (random(0, 1) >= 0.7) {
    input += "[[///";
  } else if (random(0, 1) >= 0.8) {
    input += "}";
  }
  popMatrix();
}

float xseed;
float yseed;
void drawNoise() {
  for (float i = 0; i < width; i += 5 * random(1, 1.01)) {
    for (float j = 0; j < height; j += 5 * random(1, 1.01)) {
      colorMode(HSB);
      //noStroke();
      strokeWeight(random(0, 5));
      stroke(noise(i / 200 + xseed, j / 300 + yseed) * 255, 255, 250);
      //rect(i, j, 20, 20);
      point(i, j);
    }
  }
  xseed += 0.01 * random(0, 5);
  yseed += 0.002 * random(0, 5);
}

void drawLine() {
  stroke(255);
  float start = triRandom(0.1) * width * 5;
  for (float i = 0; i < 10; i++) {
    stroke(0);
    strokeWeight(1);
    line(start, 0, start, height);
    start += random(0, 100);
  }
}

float triRandom(float seed) {
  return sin(2 * radians(seed)) * cos(3 * radians(sqrt(seed)));
}
