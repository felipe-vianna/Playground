/* How random is random()? 
   Felipe Vianna Rdorigues
   
 The idea of this program was to tweak with parameters and draw colored dots on 
 the screen in an attempt to check if the random() function was really random (and also
 familiarize myself with Processing).
 
 The dots are given random (x,y) coordinates and a color according to the colorwheel. 
 As the number of dots increases, we walk
 around the colorwheel in a proportional rate. 
 
 So if, at the end, we found a predominance of a given color around a certain region, 
 that would show a bias of the function and therefore it would not be random.
 
 -> Change the value of these variables to tweak the parameters
 -- maxDots: total number of dots to be printed on the screen
 -- radius: the radius of the dots to be printed on the screen
 -- alhpa: the alpha value of the dots (transparency) in percentage
 */

class Dot {
  int x; // x coordinate
  int y; // y coordinate
  int r; // radius
  int c; // color

  Dot(int tempR) {
    r = tempR;
    c = 0;
    x = width/2;
    y = height/2;
  }

  void display(int tempAlpha) {
    noStroke();
    colorMode(HSB, 360, 100, 100,100);
    fill(c, 100, 100,tempAlpha);
    ellipse(x, y, r, r);
  }

  void walk() {
    x = int(random(width));
    y = int(random(height));
  }
}

/****************** 
 *** PARAMETERS ***
 ******************/
 
int maxDots = 10000;
int radius = 10;
int alpha = 50;

size(1080, 720);
background(255);

/******************/

Dot dorothy;

dorothy = new Dot(radius);

for (int i = 0; i < maxDots; i++) {
  dorothy.display(alpha);
  dorothy.walk();
  dorothy.c = int(map(i, 0, maxDots, 0, 360));
}

/* After running the program with different parameters, I couldn't find a region 
  with a predominant color and therefore I conclude the function is indeed
  random, or at least random enough. 
  
  I did find, however, that there was a predominance of red and purple dots if the 
  number of dots, as well as the alpha value, were too high.
  
  That is because the final bunch of dots get the colors closer to the end of a 
  turn on the colorwheel (purple-ish and red), and Processing draws the new dots on 
  top of the older ones, blocking them.
 */
