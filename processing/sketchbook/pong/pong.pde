Pong enemy;
Pong player;
Ball ball;

void setup() {
  size(720, 360); //size of the screen, multiples of 12 to make divisions easier
  noStroke();
  enemy = new Pong(60, height/2); // object that contains the Pong controlled by the computer
  player = new Pong(width-60, height/2); // object that contains the Pong controlled by the user
  ball = new Ball();
}

void draw() {
  background(255);

  // moving the enemy, according to ball position
  if (enemy.pongY > ball.ballY)
    enemy.pongY -= 1;
  else
    enemy.pongY += 1;
  enemy.display();

  // moving the user
  player.pongY = mouseY;
  player.display();

  // moving the ball
  ball.move();
  ball.display();

  // ball collision checking (changes direction)
  if (ball.ballX+ball.ballR == player.pongX-player.pongW/2) {
    if ( (ball.ballY > player.pongY - player.pongH/2) && (ball.ballY < player.pongY + player.pongH/2) )
      ball.ballVelX *= -1;
  }
  if (ball.ballX-ball.ballR == enemy.pongX+enemy.pongW/2) {
    if ( (ball.ballY > enemy.pongY - enemy.pongH) && (ball.ballY < enemy.pongY + enemy.pongH) )
      ball.ballVelX *= -1;
  }
}

/* ********************************* */
/* ***********  CLASSES  *********** */
/* ********************************* */

class Pong {
  float pongX; // X coordinate
  float pongY; // Y coordinate
  float pongW; // total width
  float pongH; // total height

  Pong(float tempX, float tempY) {
    pongX = tempX;
    pongY = tempY;
    pongW = 20;
    pongH = 80;
  }

  void display() {
    fill(127);
    // Pong is constructed referencing the center of the rectangle
    rect(pongX-pongW/2, pongY-pongH/2, pongW, pongH);
  }
}

class Ball {
  float ballX; // X coordinate
  float ballY; // Y coordinate
  float ballVelX; // ball's velocity X component
  float ballVelY; // ball's velocity Y component
  float ballR; //ball's radius
  color ballColor;

  Ball() {
    ballR = 17;
    ballX = width/2; // centering the ball on the window
    ballY = random(height/6, height*5/6); // to start close, but not actually on the borders
    ballColor = color(0, 255, 0);

    ballVelX = -3;
    ballVelY = random(1); // to randomize going up or down
    if (ballVelY > 0.5)
      ballVelY = 3;
    else
      ballVelY = -3;
  }

  void reset() { 
    // brings the ball back to the center
    ballX = width/2;
    ballY = random(height/6, height*5/6);

    ballVelX = -3;
    ballVelY = random(1);
    if (ballVelY > 0.5)
      ballVelY = 3;
    else
      ballVelY = -3;
  }


  void move() {
    ballX += ballVelX;
    ballY += ballVelY;

    // if the ball reached the wall behind the players, resets
    if ( (ballX <= ballR) || (ballX >= width-ballR) )
      reset();

    // if the ball reached the ceiling or the floor, bounces back
    if ( (ballY <= ballR) || (ballY >= height-ballR) )
      ballVelY *= -1;
  }

  void display() {
    fill(ballColor);
    ellipse(ballX, ballY, ballR*2, ballR*2);
  }
}
