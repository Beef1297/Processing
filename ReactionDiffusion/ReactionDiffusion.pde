int SPACE_GRID_SIZE = 256;
float dx = 0.01;
float dt = 1;
int VISUALIZATION_STEP = 8;
float Du = 2e-5;
float Dv = 1e-5;
float f = 0.022, k = 0.051; //stripe
float[][] u;
float[][] v;
int SQUARE_SIZE = 20;
/*
  → j
 ↓
 i
 */
String[] messages = new String[1];
void setup() {
  size(256, 256);
  u = new float[SPACE_GRID_SIZE][SPACE_GRID_SIZE];
  v = new float[SPACE_GRID_SIZE][SPACE_GRID_SIZE];
  strokeWeight(1);
  frameRate(1);

  for (int i = 0; i < u.length; i++) {
    for (int j = 0; j < u[i].length; j++) {
      u[i][j] = 1;
      v[i][j] = 0; // v is the same size of u, so initialize here
    }
  }
  for (float i = -SQUARE_SIZE / 2; i < SQUARE_SIZE / 2; i++) {
    for (float j = -SQUARE_SIZE / 2; j < SQUARE_SIZE / 2; j++) {
      int x = floor(SPACE_GRID_SIZE / 2) + floor(i);
      int y = floor(SPACE_GRID_SIZE / 2) + floor(j);
      u[x][y] = 0.5 + random(0, 0.1);
      v[x][y] = 0.25 + random(0, 0.1);
    }
  }
}

void draw() {
  background(0);
  for (int i = 0; i < 1; i++) {
    float[][][] param_roll_u = {
      roll(u, 1, 0), 
      roll(u, -1, 0), 
      roll(u, 1, 1), 
      roll(u, -1, 1), 
      instantiateMultiplyScalar(u, -4)
    };
    float[][][] param_roll_v = {
      roll(v, 1, 0), 
      roll(v, -1, 0), 
      roll(v, 1, 1), 
      roll(v, -1, 1), 
      instantiateMultiplyScalar(v, -4)
    };

    float[][] rolled_u = addFloat2ds(param_roll_u);
    float[][] rolled_v = addFloat2ds(param_roll_v);
    float[][] laplacian_u = divideScalar(rolled_u, dx*dx);
    float[][] laplacian_v = divideScalar(rolled_v, dx*dx);

    float[][] diffusion_u = instantiateMultiplyScalar(laplacian_u, Du);
    float[][] diffusion_v = instantiateMultiplyScalar(laplacian_v, Dv);
    
 
    float[][] uv = multiplyMatrix(u, v);
    checkNaN(uv, "uv");
    float[][] uvv = multiplyMatrix(uv, v);
    checkNaN(uvv, "uvv");
 
    
    float[][] comein = instantiateMultiplyScalar(instantiateSubFloat2d(ones(SPACE_GRID_SIZE, SPACE_GRID_SIZE), u), f);
    checkNaN(comein, "comein");
  
    float[][] goout = instantiateMultiplyScalar(v, (f + k));
    checkNaN(goout, "goout");
    
    float[][] dudt = instantiateAddFloat2d(instantiateSubFloat2d(diffusion_u, uvv), comein);
    checkNaN(dudt, "dudt");
    float[][] dvdt = instantiateSubFloat2d(instantiateAddFloat2d(diffusion_v, uvv), goout);
    checkNaN(dvdt, "dvdt");
    //printFloat2d(dudt, "dudt");

    //float[][] dudt = diffusion_u;
    //float[][] dvdt = diffusion_v;

    addFloat2d(u, instantiateMultiplyScalar(dudt, dt));
    addFloat2d(v, instantiateMultiplyScalar(dvdt, dt));
  }
  visualize(u);
}

void checkNaN(float[][] m, String mes) {
  for (int i = 0; i < m.length; i++) {
    for (int j = 0; j < m[i].length; j++) {
      if (Float.isNaN(m[i][j])) {
        println("Found NaN at " + mes);
        //printfloat2d(m, "Found NaN");
        exit();
      }
    }
  }
}

void visualize(float[][] o) {
  for (int i = 0; i < o.length; i++) {
    for (int j = 0; j < o[i].length; j++) {
      stroke(255 * (float)o[i][j]);
      point(i, j);
    }
  }
}
