
// 座標を周波数に変換する
class FreqConverter {
  
  float minFreq;
  float maxFreq;
  
  public FreqConverter() {
    minFreq = 0;
    maxFreq = 10000;
  }

  // 本当は ArrayList<PVector> を受け取って汎用化したかった
  public ArrayDeque<FreqPosition> convertToFrequencyList(ArrayList<Particle> particles) {
    ArrayDeque<FreqPosition> convertList = new ArrayDeque<FreqPosition>();
    
    for (PVector p : particles) {
      convertList.add(convertToFrequency(p));
    }
    
    return convertList;
  }

  public FreqPosition convertToFrequency(PVector pos) {
    // とりあえず，周波数は 0 ~ 10000 Hz とする
    // チャンネルごとに周波数を変えるようにしたいな．
    // left channel 用, right channel 用を用意してそれぞれ pan させるという風にする
    // 本当は channel にセットするっていうのがいいと思う．
    float x_freq = map(pos.x, 0, width, minFreq, maxFreq);
    float y_freq = map(pos.y, 0, width, minFreq, maxFreq);
    
    FreqPosition freqPosition = new FreqPosition(x_freq, y_freq);    
    
    return freqPosition;
  }
}
