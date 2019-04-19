import processing.sound.*;
import processing.core.*;
import java.util.*;

SinOsc sinWave;
Grid gridline;

ArrayList<Particle> particles;
ArrayDeque<FreqPosition> freqPositions;
FreqConverter freqConverter;
boolean isUpdated = false;

void setup() {
  size(640, 480, P3D);
  loadFont("ISOCP_IV50-48.vlw");
  textSize(12);

  gridline = new Grid();
  freqConverter = new FreqConverter();

  particles = new ArrayList<Particle>();
  freqPositions = new ArrayDeque<FreqPosition>();

  // for test
  for (float t = 0; t < TWO_PI; t += PI / 30) {
    float rad = 100;
    Particle p = new Particle(rad * cos(t), rad * sin(t));
    particles.add(p);
  }
  isUpdated = true;
}

void draw() {
  background(255);
  // display framerate
  fill(0);
  text("framerate: " + frameRate, 10, 20);
  // for debug(?) : display grid line
  gridline.grid();
  // environment
  lights();

  push();
  translate(width / 2, height / 2);
  for (Particle p : particles) {
    p.show();
    p.update();
  }
  pop();

  if (isUpdated) {
    println("update sinosc");
    freqPositions = freqConverter.convertToFrequencyList(particles);
    isUpdated = false;
  }
}
