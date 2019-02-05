int VALE = -1;
int MONT = 1;

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


int numFolds = 1; // number of folds to be done in the paper
int numLines = 0; // number of lines to be drawn
int MAX_FOLDS = 16;

// Array that contains the folds (turn L or R)
// [0] won't hold any useful information
int[] dragon = new int[int(pow(2, MAX_FOLDS))];
MyLine tip1;
MyLine tip2;
float centerX = width/2;
float centerY = height/2;

void setup() {
  size(1080, 720, P2D);
  background(0);
  dragon = Fold(MAX_FOLDS);
  tip1 = new MyLine(0, 0);
  tip1.lineSize = 35;
  tip1.lineColor = color(0, 255, 0, 99);
  tip1.direction = tip1.LN_RIGHT;
  tip1.TurnLeft();

  tip2 = new MyLine(0, 0);
  tip2.lineSize = 35;
  tip2.lineColor = color(255, 0, 0, 99);
  tip2.direction = tip2.LN_UP;
  tip2.TurnRight();
}

void draw() {
  println(mouseX);
  translate((width-mouseX), (height-mouseY));
  tip1.x = 0;
  tip1.y = 0;
  tip1.direction = tip1.LN_RIGHT;
  tip1.TurnLeft();


  tip2.x = -tip2.lineSize;
  tip2.y = -tip2.lineSize;
  tip2.direction = tip2.LN_UP;
  tip2.TurnRight();


  background(0);
  numLines = int(pow(2, numFolds));
  for (int i = numLines/2; i < numLines; i++) {
    if (dragon[i] == VALE)
      tip1.TurnLeft();
    else
      tip1.TurnRight();

    if (dragon[numLines-i] == MONT)
      tip2.TurnLeft();
    else
      tip2.TurnRight();
  }
  //println(tip.lineSize);
}

/* ******************* */
/* INTERFACE FUNCTIONS */
/* ******************* */

void mouseMoved() {
  centerX = -mouseX;
  centerY = -mouseY;
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
  if ((tip1.lineSize >= -60) && (e > 0)) {// zoom out
    tip1.lineSize -= 1.5*e;
    tip2.lineSize -= 1.5*e;
    if (tip1.lineSize == 0) {
      tip1.lineSize = -1;
      tip2.lineSize = 1;
    }
  }

  if ((tip1.lineSize <= 60) && (e < 0)) { // zoom in
    tip1.lineSize -= 1.5*e;
    tip2.lineSize -= 1.5*e;
    if (tip1.lineSize == 0) {
      tip1.lineSize = 1;
      tip2.lineSize = 1;
    }
  }
}
