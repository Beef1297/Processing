Particle current;
ArrayList<Particle> snowflake;
float hue = 0;
void setup() {
  size(600, 600);
  background(0);
  colorMode(HSB, 100);
  current = new Particle(width / 2, 0, hue);
  snowflake = new ArrayList<Particle>();
}

void draw() {
  hue = (hue + 0.5) % 100;
  translate(width/2, height/2);
  rotate(PI / 6);
  background(0);
  current.update();

  while (!current.finished() && !current.intersects(snowflake)) {
    current.update();
  }
  snowflake.add(current);
  current = new Particle(width / 2, 0, hue);
  for (int i = 0; i < 6; i++) {
    rotate(PI / 3);
    current.show();
    for (Particle s : snowflake) {
      s.show();
    }
    pushMatrix();
    scale(1, -1);
    current.show();
    for (Particle s : snowflake) {
      s.show();
    }
    popMatrix();
  }
}
