// FelipeViannaRodrigues
/* Use WASD keys to toggle around the values (BE CAREFUL, COMPUTER MIGHT SLOW DOWN) */

float dotRadius = 2;
float x = 0;
float y = 0;
float radiusStep = 1;
float angleStep = 1;

float dotColor = 0;
float radius = 0;
float angle = 0;

void setup() {
  size(700, 700, P2D);
  stroke(255);
  colorMode(HSB, 360, 1, 1);
}

void draw() {
  background(0);
  dotRadius = 2;
  x = 0;
  y = 0;
  //radiusStep = map(mouseX,0,width,0.05,2.5);
  //angleStep = map(mouseY,0,width,0.1,2);

  dotColor = 0;
  radius = 0;
  angle = 0;
  //radiusStep = mouseX;
  if (keyPressed)
    switch(key) {
    case 'a':
      if (radiusStep < 3)
        radiusStep += 0.01;
      break;
    case 'd':
      if (radiusStep > 0.05)
        radiusStep -= 0.01;
      break;

    case 'w':
      angleStep +=  0.0005;
      break;
    case 's':
      angleStep -= 0.0005;
      break;
    }
  while (radius < height) {
    x = radius*(cos(angle));
    y = radius*(sin(angle));

    dotColor = angle % 360;
    stroke(dotColor, 1, 1);
    circle(width/2+x, height/2+y, dotRadius);

    radius += radiusStep;
    angle += angleStep;
  }
}
