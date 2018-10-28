import java.util.Random;

class Walker {
  //private int x;
  //private int y;
  PVector loc;
  private Random generator;
  public Walker() {
    loc = new PVector(width / 2, height / 2);
    generator = new Random();
  }

  public void display() {
    stroke(0);
    point(loc.x, loc.y);
  }
  public void step() {

    float step = (float)generator.nextGaussian();
    if(step < -1) {
      loc.x--;
    }else if(step < 0 ) {
      loc.x++; 
    }else if(step > 1) {
      loc.y--;
    }else {
      loc.y++;
    }
    
  }
}
