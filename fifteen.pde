final int PIXEL_CHIP = 64;
final int MARGIN_CHIP = 3;
final int ROUND_CHIP = 7;
int size = 4;
int[][] board = new int[size][size];
Piece[] pieces = new Piece[size*size - 1];
boolean flagClicked = false; 

class Piece{
  int number;
  int x;
  int y;
  
  Piece(int number_, int x_, int y_){
    number = number_;
    x = x_;
    y = y_;
  }
  
  int getLeft(){
    return x*PIXEL_CHIP + MARGIN_CHIP;
  }
  
  int getTop(){
    return y*PIXEL_CHIP + MARGIN_CHIP;
  }
  
  int getRight(){
    return (x + 1)*PIXEL_CHIP - MARGIN_CHIP;
  }
  
  int getBottom(){
    return (y + 1)*PIXEL_CHIP - MARGIN_CHIP;
  }
  
  void draw(){
    /* Draw the piece */
    stroke(0, 0, 0);
    fill(255, 255, 255);
    rect(getLeft(),
      getTop(),
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
  
  boolean isClicked(){
    if(flagClicked){
      if(getLeft() <= mouseX && mouseX <= getRight()
        && getTop() <= mouseY && mouseY <= getBottom()){
        println(number, x, y);
        return true;
      }
    }
    return false;
  }
}

void settings(){
  size(PIXEL_CHIP*size, PIXEL_CHIP*size);
}

void setup(){
  background(200, 200, 255);
  
  for(int x=0; x < size; x++){
    for(int y=0; y < size; y++){
      int index = x + y*size;
      if(index < size*size -1){
        board[x][y] = x + y*size + 1;
        pieces[index] = new Piece(index + 1, x, y);
      }
    }
  }
  board[size - 1][size - 1] = 0;
  
  test(1);
}

void rearrangePieces(){
  for(int x=0; x < size; x++){
    for(int y=0; y < size; y++){
      int number = board[x][y];
      if(number != 0){
        int index = number - 1;
        pieces[index].x = x;
        pieces[index].y = y;
      }
    }
  }
}

void drawPieces(){
  for(Piece p: pieces){
    p.draw();
  }
}

void swapPieces(int x1, int y1, int x2, int y2){
  int temp = board[x1][y1];
  board[x1][y1] = board[x2][y2];
  board[x2][y2] = temp;
}



boolean movePiece(int x, int y){
  int[] dxs = {0, 1, 0, -1};
  int[] dys = {1, 0, -1, 0};
  for(int i=0; i < 4; i++){
    int dx = dxs[i];
    int dy = dys[i];
    if(0 <= x + dx && x + dx < size
      && 0 <= y + dy && y + dy < size){
      if(board[x + dx][y + dy] == 0){
        swapPieces(x, y, x + dx, y + dy);
        return true;
      }
    }
  }
  return false;
}

void mouseClicked(){
  flagClicked = true;
}

void draw(){
  /* update */
  for(Piece p: pieces){
    if(p.isClicked()){
      movePiece(p.x, p.y);
      break;
    }
  }
  
  rearrangePieces();
  flagClicked = false;
  
  /* draw */
  background(200, 200, 255);
  drawPieces();
  

}

void test(int n_){
  switch(n_){
    case 0:
      Piece p = new Piece(12, 1, 2);
      p.draw();
      Piece q = new Piece(1, 2, 2);
      q.draw();
      break;
    case 1:
      swapPieces(1, 3, 2, 3);
      break;
  }
}