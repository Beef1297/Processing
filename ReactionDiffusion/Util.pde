
/***********
*
* multiply
*
***********/

float[][] multiplyMatrix(float[][] a, float[][] b) {
  float[][] result = new float[a.length][b[0].length];
  
  for (int i = 0;i < a[0].length; i++) {
    for (int j = 0; j < b.length; j++) {
       float sum = 0;
       for (int k = 0; k < a[0].length; k++) {
         sum += a[i][k] * b[k][j];
       }
       result[i][j] = sum;
    }
  }
  
  return result;
}


float[][] multiplyScalar(float[][] a, float s) {
  for (int i = 0; i < a.length; i++) {
    for (int j = 0; j < a[i].length; j++) {
      a[i][j] *= s;
    }
  }
  return a;
}

float[][] instantiateMultiplyScalar(float[][] a, float s) {
  float[][] result = new float[a.length][a.length];
  for (int i = 0; i < a.length; i++) {
    for (int j = 0; j < a[i].length; j++) {
      result[i][j] = a[i][j] * s;
    }
  }
  return result;
}

float[][] instantiateMultiplyFloat2d(float[][] o, float[][] s) {
  float[][] result = new float[o.length][o.length];
  for (int i = 0; i < o.length; i++) {
    for (int j = 0; j < o[i].length; j++) {
      result[i][j] = o[i][j] * s[i][j];  
    }
  }
  return result;
}

/************
*
* divide
*
***************/

float[][] divideScalar(float[][] a, float s) {
  for (int i = 0; i < a.length; i++) {
    for (int j = 0; j < a[i].length; j++) {
      a[i][j] /= s;
    }
  }
  return a;
}

float[][] instantiateDivideScalar(float[][] a, float s) {
  float[][] result = new float[a.length][a.length];
  for (int i = 0; i < a.length; i++) {
    for (int j = 0; j < a[i].length; j++) {
      result[i][j] = a[i][j] / s;
    }
  }
  return result;
}

/**
* for debug
*/

void printFloat2d(float[][] p, String message) {
  for (int i = 0; i < p.length; i++) {
    for (int j = 0; j < p[i].length; j++) {
      print(p[i][j] + " ");
    }
    println();
  }
}

String makeMessage(float[][] p, String[] messages) {
  String ret = "";
  for (int i = 0; i < p.length; i++) {
    for (int j = 0; j < p[i].length; j++) {
      if (Float.isNaN(p[i][j])){
        println("NaN appeared at " + messages);
        saveStrings("error2.txt", messages);
        exit();
        break;
      }
      ret += p[i][j] + " ";
    }
    ret += "\n";
  }
  return ret;
}

/******************
*
* add
*
*******************/
// s include some float 2 dimentional array 
float[][] addFloat2ds(float[][][] s) {
  float[][] result = new float[s[0].length][s[0].length];
  
  for (int k = 0; k < s.length; k++) {
    for (int i = 0; i < s[k].length; i++) {
      for (int j = 0; j < s[k][i].length; j++) {
        result[i][j] += s[k][i][j];
      }
    }
  }
  return result;
}

float[][] addFloat2d(float[][] o, float[][] s) {
  for (int i = 0; i < o.length; i++) {
    for (int j = 0; j < o[i].length; j++) {
      o[i][j] += s[i][j];
    }
  }
  return o;
}

float[][] instantiateAddFloat2d(float[][] o, float[][] s) {
  float[][] result = new float[o.length][o.length];
  for (int i = 0; i < o.length; i++) {
    for (int j = 0; j < o[i].length; j++) {
      result[i][j] = o[i][j] + s[i][j];
    }
  }
  return result;
}

// return pointer of o, that is to say
// using return is not recommended
float[][] addScalar(float[][] o, float s) {
  for (int i = 0; i < o.length; i++) {
    for (int j = 0; j < o[i].length; j++) {
      o[i][j] += s;
    }
  }
  return o;
}

/******************
*
*  sub
*
********************/
float[][] subFloat2d(float[][] o, float[][] s) {
  for (int i = 0; i < o.length; i++) {
    for (int j = 0; j < o[i].length; j++) {
      o[i][j] -= s[i][j];
    }
  }
  return o;
}

float[][] instantiateSubFloat2d(float[][] o, float[][] s) {
  float[][] result = new float[o.length][o.length];
  for (int i = 0; i < o.length; i++) {
    for (int j = 0; j < o[i].length; j++) {
      result[i][j] = o[i][j] - s[i][j];
    }
  }
  return result;
}


// s include some float 2 dimentional array 
float[][] subFloat2ds(float[][][] s) {
  
  float[][] result = new float[s[0].length][s[0].length];
  for (int k = 0; k < s.length; k++) {
    for (int i = 0; i < s[k].length; i++) {
      for (int j = 0; j < s[k][i].length; j++) {
        result[i][j] -= s[k][i][j];
      }
    }
  }
  return result;
}



float[][] instantiateSubScalar(float[][] o, float s) {
  float[][] result = new float[o.length][o.length];
  for (int i = 0; i < o.length; i ++) {
    for (int j = 0; j < o[i].length; j++) {
      o[i][j] -= s;
    }
  }
  return result;
}


/**
*  roll
**/

float[][] roll(float[][] r, int range, int axis) {
  float[][] result = new float[r.length][r.length];
  if (axis == 0) {
    for (int i = 0; i < r.length; i++) {
      int index = i + range;
      if ( index < 0 ) {
        index += r.length;
      }
      result[index % r.length] = r[i];
    }
  } else if (axis == 1) {
    for (int i = 0; i < r.length; i++) {
      for (int j = 0; j < r[i].length; j++) {
        int index = j + range;
        if ( index < 0 ) {
           index += r[i].length;
        } 
        result[i][index % r[i].length] = r[i][j];
      }
    }
  }
  return result;
}

float[][] ones(int raw, int column) {
  float[][] array = new float[raw][column];
  for (int i = 0; i < raw; i++) {
    for (int j = 0; j < column; j++) {
      array[i][j] = 1;
    }
  }
  return array;
}
