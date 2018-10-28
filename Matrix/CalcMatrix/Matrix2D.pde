
// 2x2 行列の計算クラス
static class Matrix2D {

  static public float[][] add(float[][] a, float[][] b) {
    float[][] c = new float[2][2];
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 2; j++) {
        c[i][j] = a[i][j] + b[i][j];
      }
    }
    return c;
  }

  static public float[][] diff(float[][] a, float[][] b) {
    float[][] c = new float[2][2];
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 2; j++) {
        c[i][j] = a[i][j] - b[i][j];
      }
    }
    return c;
  }
  
  static public float[][]  mult(float[][] a, float[][] b) {
    float[][] c = new float[2][2];
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 2; j++) {
        float sum = 0;
        for (int k = 0; k < 2; k++) {
          sum += a[i][k] * b[k][j];
        }
        c[i][j] = sum;
      }
    }
    return c;
  }
  
  static public void printMatrix(float[][] a){
    println("--------------");
    for (int i = 0; i < 2; i++) {
      for (int j = 0;j < 2; j++) {
        print(a[i][j] + " ");
      }
      println();
    }
    println("--------------");    
  }
  
  // 破壊的
  static public Vector2D coordinateTransform(Vector2D v, float[][] M){
    float tmpx = v.x, tmpy = v.y;
    v.x = tmpx * M[0][0] + tmpy * M[1][0];
    v.y = tmpx * M[0][1] + tmpy * M[1][1];
    return v;
  }
}
