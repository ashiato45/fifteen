final int PIXEL_CHIP = 64;
final int MARGIN_CHIP = 3;
final int ROUND_CHIP = 7;
int size = 4;

class Piece{
  int number;
  int x;
  int y;
  
  Piece(int number_, int x_, int y_){
    number = number_;
    x = x_;
    y = y_;
  }
  
  void draw(){
    /* Draw the piece */
    stroke(0, 0, 0);
    fill(255, 255, 255);
    rect(x*PIXEL_CHIP + MARGIN_CHIP,
      y*PIXEL_CHIP + MARGIN_CHIP,
      PIXEL_CHIP - MARGIN_CHIP*2,
      PIXEL_CHIP - MARGIN_CHIP*2,
      ROUND_CHIP);
    /* Draw numbers */
    fill(0, 0, 0);
    textSize(12);
    textAlign(CENTER, CENTER);
    text(str(number),
      x*PIXEL_CHIP + PIXEL_CHIP/2,
      y*PIXEL_CHIP + PIXEL_CHIP/2);
  }
}

void settings(){
  size(PIXEL_CHIP*size, PIXEL_CHIP*size);
}

void setup(){
  background(200, 200, 255);
}

void draw(){
  test(0);
}

void test(int n_){
  switch(n_){
    case 0:
      Piece p = new Piece(12, 1, 2);
      p.draw();
      Piece q = new Piece(1, 2, 2);
      q.draw();
      break;
  }
}