class MyLine {
  float x;
  float y;
  int direction;
  int LN_UP;
  int LN_DOWN;
  int LN_LEFT;
  int LN_RIGHT;

  float lineSize;

  MyLine(float lineX, float lineY) {
    LN_RIGHT = 0;
    LN_UP = 1;
    LN_LEFT = 2;
    LN_DOWN = 3;
    x = lineX;
    y = lineY;
    direction = LN_UP;
    lineSize = 30;
  }

  void TurnRight() {
    float oldX = x;
    float oldY = y;

    if (direction == LN_UP) { //LN_UP
      x += lineSize;
      direction = LN_RIGHT;
    } else if (direction == LN_DOWN) {
      x -= lineSize;
      direction = LN_LEFT;
    } else if (direction == LN_RIGHT) {
      y += lineSize;
      direction = LN_DOWN;
    } else if (direction == LN_LEFT) {
      y -= lineSize;
      direction = LN_UP;
    }

    stroke(255);
    line(oldX, oldY, x, y);
  }

  void TurnLeft() {
    float oldX = x;
    float oldY = y;

    if (direction == LN_UP) { //LN_UP
      x -= lineSize;
      direction = LN_LEFT;
    } else if (direction == LN_DOWN) {
      x += lineSize;
      direction = LN_RIGHT;
    } else if (direction == LN_RIGHT) {
      y -= lineSize;
      direction = LN_UP;
    } else if (direction == LN_LEFT) {
      y += lineSize;
      direction = LN_DOWN;
    }

    stroke(255);
    line(oldX, oldY, x, y);
  }
}
