// SinOsc を作るために PApplet を継承してみる
class FreqPosition  extends PApplet {
  SinOsc left;
  SinOsc right;

  public FreqPosition (float leftFreq, float rightFreq) {
    int sound_num = particles.size();
    left = new SinOsc(this);
    left.freq(leftFreq);
    left.pan(-1.0);
    println("amplitude is: " + (1.0 / ((sound_num + 1) * 2)));
    left.amp(1.0 / ((sound_num + 1) * 2));
    
    right = new SinOsc(this);
    right.freq(rightFreq);
    right.pan(1.0);
    right.amp(1.0 / ((sound_num + 1) * 2));
    
    left.play();
    right.play();
  }
  
}
