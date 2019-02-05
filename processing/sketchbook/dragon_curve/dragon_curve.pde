int VALE = -1;
int MONT = 1;

MyLine tip;

int[] Fold(int folds) {
  int[] curves = new int[int(pow(2, folds))];

  for (int level = 1; level < folds; level++) {
    // level conta o nivel dentro da árvore, de baixo pra cima
    int step = int(pow(2, level));
    // step conta a distancia entre duas curvas no vetor curvas[]
    int offset = step/2;
    // offset conta a posicao a partir da qual comecamos
    // a escrever as curvas naquele determinado nivel da
    // arvore 

    for (int i = 0; i*step+offset+step < curves.length; i+=2) {
      curves[offset+i*step] = VALE;
      curves[offset+i*step+step] = MONT;
    }
  }

  curves[curves.length/2] = VALE;

  return curves;
}


int numFolds = 1;
int MAX_FOLDS = 16;

// Array that contains the folds (turn L or R)
// [0] won't hold any useful information
int[] dragon = new int[int(pow(2, MAX_FOLDS))];
float centerX = width/2;
float centerY = height/2;

void setup() {
  size(1080, 720, P2D);
  background(0);
  dragon = Fold(MAX_FOLDS);
  tip = new MyLine(0, 0);
  tip.lineSize = 35;
  tip.direction = tip.LN_UP;
}

void draw() {
  translate((width/2-centerX)*2, (height/2-centerY)*2);
  tip.x = 0;
  tip.y = 0;

  background(0);
  for (int i = 0; i < int(pow(2, numFolds)); i++) {
    if (dragon[i] == VALE)
      tip.TurnLeft();
    else
      tip.TurnRight();
  }
  //println(tip.lineSize);
}

/* ******************* */
/* INTERFACE FUNCTIONS */
/* ******************* */

void mouseMoved() {
  centerX = mouseX;
  centerY = mouseY;
}

void mousePressed() {
  if ((mouseButton == LEFT) && (numFolds < MAX_FOLDS))
    numFolds++;
  else if ((mouseButton == RIGHT) && (numFolds > 1))
    numFolds--;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  //if (e > 0)
  //  println('+');
  //if (e < 0)
  //  println('-');
  if ((tip.lineSize >= -60) && (e > 0)) {// zoom out
    tip.lineSize -= 1.5*e;
    if (tip.lineSize == 0)
      tip.lineSize = -1;
  }

  if ((tip.lineSize <= 60) && (e < 0)) { // zoom in
    tip.lineSize -= 1.5*e;
    if (tip.lineSize == 0)
      tip.lineSize = 1;
  }
}
