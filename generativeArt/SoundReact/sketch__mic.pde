import ddf.minim.*;
import ddf.minim.analysis.*;


import java.util.Collections;
import java.util.Comparator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.HashMap;
import java.util.LinkedHashMap;

Minim minim;
AudioInput in;
FFT fft;
Map<String, Float>  std_Scale;


void setup() {
  size(1024, 400);
  background(255);
  translate(0, height/2);
  minim = new Minim(this);

  in = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.window(FFT.HAMMING);

  // 標準の音階をセット
  std_Scale = new LinkedHashMap<String, Float>();
  setScale();

  frameRate(20);
  colorMode(HSB, 360);
  //stroke(255);
  //strokeWeight(2);
  noStroke();
}

void setScale() {
  std_Scale.put("C", 261.63);
  std_Scale.put("C#", 277.18); // = Db
  std_Scale.put("D", 293.66);
  std_Scale.put("D#", 311.13); // = Eb
  std_Scale.put("E", 329.63);
  std_Scale.put("F", 349.23);
  std_Scale.put("F#", 369.99); // = Gb
  std_Scale.put("G", 392.00);
  std_Scale.put("G#", 415.30); // = Ab
  std_Scale.put("A", 440.00);
  std_Scale.put("A#", 466.16); // = Bb
  std_Scale.put("B", 493.88);
}

float _prevPBand = 0; // 一つ前の値を記憶
int _counter = 0;
ArrayList<DrawObject> _drownObjects = new ArrayList<DrawObject>();
int LIMIT = 10;
int INTERVAL = 3;
void draw() {
  Map<Float, Float> specific_freqMap = new LinkedHashMap<Float, Float>();
  //key   : Frequency
  //value : Amplitude
  _prevPBand = 0;
  background(0);

  fft.forward(in.mix);

  for (int i = 0; i < fft.specSize(); i++) {
    float curPBand = fft.getBand(i) * fft.getBand(i);
    float frequency = fft.indexToFreq(i);
    putSpecificValue_from_data(specific_freqMap, curPBand, _prevPBand, frequency);
    _prevPBand = curPBand;
  }
  if (++_counter % INTERVAL == 0) {
    //value(Amplitude) で 降順にソート
    ArrayList sorted_map = sort_map_descending(specific_freqMap);
    println(sorted_map.size()); 
    /*
      頻度が高い音を抽出
     */
    ArrayList<Integer> mode_sounds = extract_often_sound(sorted_map);
    if (mode_sounds.size() != 0) {
      for (int i=0; i < mode_sounds.size(); i++) {
        Map.Entry element = (Map.Entry) sorted_map.get(i);
        float freq = (float)element.getKey();
        float amp  = (float)element.getValue();
        float x = noise(map(i, 0, fft.specSize(), 0, width)) * random(width/2, width);
        float y = noise(map(i, 0, fft.specSize(), 0, height)) * random(height/2, height);
        drawCircle(freq, amp, x, y, mode_sounds.get(i));
      }
    }
  }
  update_objects();
}

// 前の値が次の値より大きかったら挿入する
// スペクトルグラフの山頂をいれていくイメージ
void putSpecificValue_from_data(Map<Float, Float> specV, float cB, float pB, float freq) {
  if (pB > cB) {
    //println(pB, cB);
    specV.put(freq, pB);
  }
}

ArrayList<Integer> extract_often_sound(ArrayList sorted_map) {
  ArrayList<Integer> sounds = new ArrayList<Integer>();
  int[] scale = new int[13];
  for (int i=0; i < sorted_map.size(); i++) {
    float freq = (float)((Map.Entry)sorted_map.get(i)).getKey();
    int d = _calc_scale_index(freq);
    scale[d]++;
    if (scale[d] >= 3) {
      sounds.add(d);
    }
  }
  return sounds;
}

ArrayList sort_map_descending(Map<Float, Float> sfM) {
  ArrayList sorted_map = new ArrayList(sfM.entrySet());
  Collections.sort(sorted_map, new Comparator() {
    public int compare(Object o1, Object o2) {
      Map.Entry<Float, Float> e1 = (Map.Entry<Float, Float>)o1;
      Map.Entry<Float, Float> e2 = (Map.Entry<Float, Float>)o2;
      return e2.getValue().compareTo(e1.getValue());
    }
  }
  );
  return sorted_map;
}

void drawCircle (float freq, float amp, float x, float y, int d) {
  // 音ごとにいろ分け
  // FIXME 音の分け方

  if (d == 3/*C*/ || d == 4/*C#*/) {
    _drawCircleProcess(freq, amp, x, y, 0);
  }
  if (d == 5/*D*/ || d == 6/*D#*/) {
    _drawCircleProcess(freq, amp, x, y, 60);
  }
  if (d == 7 /*E*/) {
    _drawCircleProcess(freq, amp, x, y, 120);
  }
  if (d == 8 /*F*/ || d == 9 /*F#*/ ) {
    _drawCircleProcess(freq, amp, x, y, 180);
  }
  if (d == 10/*G*/ || d == 11 /*G#*/) {
    _drawCircleProcess(freq, amp, x, y, 240);
  }
  if (d == 0/*A*/ || d == 1 /*A#*/) {
    _drawCircleProcess(freq, amp, x, y, 300);
  }
  if (d == 2) {
    _drawCircleProcess(freq, amp, x, y, 360);
  }
}


void _drawCircleProcess(float freq, float amp, float x, float y, int h) {
  float a = map(amp, 0, 300, 0, 360);
  DrawObject d = new DrawObject(x, y, h, a, amp);
  if (_drownObjects.size() <= LIMIT) {
    println("( freq, amp ) : " + freq + "," + amp);
    println("(x, y) : " + x + "," + y);
    _drownObjects.add(d);
  }
}

void update_objects() {
  for (int i=0; i < _drownObjects.size(); i++) {
    boolean bool = _drownObjects.get(i).update();
    if (bool) {
      _drownObjects.remove(i);
      continue;
    }
    _drownObjects.get(i).drawEllipse();
  }
}

/*
  f = 440 * pow(2, d/12) より
 周波数と音階を合わせる計算式
 440Hz 基準
 */
int _calc_scale_index(float freq) {
  int d;
  d = (int)(12 * (log(freq) - log(440))/log(2)); 
  return abs(d%12);
}


void stop() {
  minim.stop();
  super.stop();
}
