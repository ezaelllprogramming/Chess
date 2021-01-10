import processing.net.*;

Client myClient;

color yellow = #FFFF00;
color cyan  = #00FFFF;
PImage wrook, wbishop, wknight, wqueen, wking, wpawn;
PImage brook, bbishop, bknight, bqueen, bking, bpawn;
boolean firstClick;
boolean WHITE = true;
boolean BLACK = false;
boolean turn;
int row1, col1, row2, col2, counter,piece;
boolean zkey;
boolean qkey, bkey, rkey, kkey;

char grid[][] = {
  {'R', 'B', 'N', 'Q', 'K', 'N', 'B', 'R'},
  {'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'},
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
  {'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'},
  {'r', 'b', 'n', 'q', 'k', 'n', 'b', 'r'}
};

void setup() {
  size(800, 800);
  
  textAlign(CENTER);
  
  turn = BLACK;
  
  zkey = false;
  qkey = false;
  bkey = false;
  rkey = false;
  kkey = false;
  
  myClient = new Client(this,"127.0.0.1", 1234);
  
  firstClick = true;
  brook = loadImage("blackRook.png");
  bbishop = loadImage("blackBishop.png");
  bknight = loadImage("blackKnight.png");
  bqueen = loadImage("blackQueen.png");
  bking = loadImage("blackKing.png");
  bpawn = loadImage("blackPawn.png");
  wrook = loadImage("whiteRook.png");
  wbishop = loadImage("whiteBishop.png");
  wknight = loadImage("whiteKnight.png");
  wqueen = loadImage("whiteQueen.png");
  wking = loadImage("whiteKing.png");
  wpawn = loadImage("whitePawn.png");
}

void draw() {
  drawBoard();
  highlightSquare();
  drawPieces();
  recieveMove();
  menu();
}

void menu() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) {
      if (grid[0][c] == 'p'){
        fill(0,0,255,150);
        rect(150,150,250,250);
        rect(400,150,250,250);
        rect(150,400,250,250);
        rect(400,400,250,250);
        image (wrook,150,150,200,200);
        image (wbishop,400,150,200,200);
        image (wknight,150,400,200,200);
        image (wqueen,400,400,200,200);
        fill(255); 
        text("R Key", 170,170);
        text("B Key", 420,170);
        text("K Key", 170,420);
        text("Q Key", 420,420);
      }
      if (grid[7][c] == 'P') {
        fill(0,0,255,150);
        rect(150,150,250,250);
        rect(400,150,250,250);
        rect(150,400,250,250);
        rect(400,400,250,250);
        image (brook,150,150,200,200);
        image (bbishop,400,150,200,200);
        image (bknight,150,400,200,200);
        image (bqueen,400,400,200,200);
      }  
    }
  }
}

void recieveMove() {
  if (myClient.available() > 0) {
    String incoming = myClient.readString(); 
    int r1 = int(incoming.substring(0,1));
    int c1 = int(incoming.substring(2,3));
    int r2 = int(incoming.substring(4,5));
    int c2 = int(incoming.substring(6,7));
    counter = int(incoming.substring(8,9));
    int piece = int(incoming.substring(10,11));
    if (counter == 1) {
      grid[r2][c2] = grid[r1][c1];
      grid[r1][c1] = ' ';
    }else{
      grid[r1][c1] = grid[r2][c2];
      grid[r2][c2] = ' ';
    }
    if (piece == 1) {
      grid[0][col2] = 'q';
    }
    if (piece == 2) {
      grid[0][col2] = 'r';
    }
    if (piece == 3) {
      grid[0][col2] = 'b';
    }
    if (piece == 4) {
      grid[0][col2] = 'k';
    }
    
    if (piece == 5) {
      grid[7][col2] = 'Q';
    }
    if (piece == 6) {
      grid[7][col2] = 'R';
    }
    if (piece == 7) {
      grid[7][col2] = 'B';
    }
    if (piece == 8) {
      grid[7][col2] = 'K';
    }
  }
}

void drawBoard() {
  noStroke();
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) {
      if ( (r%2) == (c%2) ) {
        fill(yellow);
      } else {
        fill(cyan);
      }
      rect(c*100, r*100, 100, 100);
    }
  }
}

void highlightSquare() {
 if (firstClick == false) {
  noFill();
  stroke(0,0,255);
  strokeWeight(10);
  rect(col1*100,row1*100,100,100);
 }
}

void drawPieces() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) {
      if (grid[r][c] == 'r') image (wrook, c*100, r*100, 100, 100);
      if (grid[r][c] == 'R') image (brook, c*100, r*100, 100, 100);
      if (grid[r][c] == 'b') image (wbishop, c*100, r*100, 100, 100);
      if (grid[r][c] == 'B') image (bbishop, c*100, r*100, 100, 100);
      if (grid[r][c] == 'n') image (wknight, c*100, r*100, 100, 100);
      if (grid[r][c] == 'N') image (bknight, c*100, r*100, 100, 100);
      if (grid[r][c] == 'q') image (wqueen, c*100, r*100, 100, 100);
      if (grid[r][c] == 'Q') image (bqueen, c*100, r*100, 100, 100);
      if (grid[r][c] == 'k') image (wking, c*100, r*100, 100, 100);
      if (grid[r][c] == 'K') image (bking, c*100, r*100, 100, 100);
      if (grid[r][c] == 'p') image (wpawn, c*100, r*100, 100, 100);
      if (grid[r][c] == 'P') image (bpawn, c*100, r*100, 100, 100);
    }
  }
}

void mouseReleased() {
  if (counter == 1) {
    if (firstClick) {
    row1 = mouseY/100;
    col1 = mouseX/100;
    firstClick = false;
  } else {
    row2 = mouseY/100;
    col2 = mouseX/100;
    if (!(row2 == row1 && col2 == col1)) {
      grid[row2][col2] = grid[row1][col1];
      grid[row1][col1] = ' ';
      counter = 0;
      myClient.write(row1 + "," + col1 + "," + row2 + "," + col2 + "," + counter + "," + piece);
      firstClick = true;
    }
   }
  }
}

void keyPressed() {
  if (key == 'z' || key == 'Z') {
    zkey = true;
    grid[row1][col1] = grid[row2][col2];
    counter = 1;
    myClient.write(row1 + "," + col1 + "," + row2 + "," + col2 + "," + counter + "," + piece);
    grid[row2][col2] = ' ';
  }
  
  if (key == 'q' || key == 'Q') {
    qkey = true;
    for (int c = 0; c < 8; c++) {
      if (grid[0][c] == 'p') {
        grid[0][c] = ' ';
        myClient.write(row1 + "," + col1 + "," + row2 + "," + c + "," + counter + "," + 1);
        grid[0][c] = 'q';      
      }
    }
  }
  
  if (key == 'r' || key == 'R') {
    rkey = true;
    for (int c = 0; c < 8; c++) {
      if (grid[0][c] == 'p') {
        grid[0][c] = ' ';
        myClient.write(row1 + "," + col1 + "," + row2 + "," + c + "," + counter + "," + 2);
        grid[0][c] = 'r';      
      }
    }
  }
  
  if (key == 'b' || key == 'B') {
    bkey = true;
    for (int c = 0; c < 8; c++) {
      if (grid[0][c] == 'p') {
        grid[0][c] = ' ';
        myClient.write(row1 + "," + col1 + "," + row2 + "," + c + "," + counter + "," + 3);
        grid[0][c] = 'b';      
      }
    }
  }
  
  if (key == 'k' || key == 'K') {
    kkey = true;
    for (int c = 0; c < 8; c++) {
      if (grid[0][c] == 'p') {
        grid[0][c] = ' ';
        myClient.write(row1 + "," + col1 + "," + row2 + "," + c + "," + counter + "," + 4);
        grid[0][c] = 'k';      
      }
    }
  }
  
  if (key == 'q' || key == 'Q') {
    qkey = true;
    for (int c = 0; c < 8; c++) {
      if (grid[7][c] == 'P') {
        grid[7][c] = ' ';
        myClient.write(row1 + "," + col1 + "," + row2 + "," + c + "," + counter + "," + 5);
        grid[7][c] = 'Q';      
      }
    }
  }
  
  if (key == 'r' || key == 'R') {
    rkey = true;
    for (int c = 0; c < 8; c++) {
      if (grid[7][c] == 'P') {
        grid[7][c] = ' ';
        myClient.write(row1 + "," + col1 + "," + row2 + "," + c + "," + counter + "," + 6);
        grid[7][c] = 'R';      
      }
    }
  }
  
  if (key == 'b' || key == 'B') {
    bkey = true;
    for (int c = 0; c < 8; c++) {
      if (grid[7][c] == 'P') {
        grid[7][c] = ' ';
        myClient.write(row1 + "," + col1 + "," + row2 + "," + c + "," + counter + "," + 7);
        grid[7][c] = 'B';      
      }
    }
  }
  
  if (key == 'k' || key == 'K') {
    kkey = true;
    for (int c = 0; c < 8; c++) {
      if (grid[7][c] == 'P') {
        grid[7][c] = ' ';
        myClient.write(row1 + "," + col1 + "," + row2 + "," + c + "," + counter + "," + 8);
        grid[7][c] = 'K';      
      }
    }
  }
}
