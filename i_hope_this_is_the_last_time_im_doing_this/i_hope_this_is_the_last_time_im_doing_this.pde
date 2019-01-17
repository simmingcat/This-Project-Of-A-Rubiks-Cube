float M[][] = new float[4][4];
 
color cubeFaceColors[] = {
  color(255, 255, 0), color(255, 127, 0), color(0, 0, 255), color(255, 0, 0), color(0, 255, 0), color(255)
};
 //maroon: AA5522; red: FF2222; blue: 2222BB; green: 22EE22; white: FFFFFF; yellow: FFDD33
int axis=0, slice=2, direction=1, speed=10;//speed: default=3; max=16;
float theta = 0.0;
 
boolean orient=false;
boolean firstRun = true;
float xRot=-35.264, yRot=45, zRot=0;
 
PVector frontBound[], topBound[], rightBound[], downBound[], backBound[], leftBound[];
float backViewDisp;
 
stack stackOfMoves = new stack();
rubikCube rc;
 
String moveStr, algorithm = "";
boolean moveStrValid = false;
int strMoveCount=0;
 
boolean inMove = false;
int thetaCount = 0;
 
String[] solvingMethod = {"undo", "Beginner\'s", "Fridrich/CFOP", "Petrus"};
 
void setup() {
  size(1210, 600, OPENGL);//P3D works same
  ortho();
  strokeJoin(ROUND);
  frame.setTitle("Rubik's Cube from RCube 3");
  rc = new rubikCube(height/8);
  //rc.setSize(5); //100 by default (cubies split)
 
  rc.cubePosition = new PVector (width/3, height/2.0, 0.0);
  backViewDisp = width/3;
  for (int i=0;i<8;i++) {
    rot(rc.frontY, 1, rc.boundary.points[i]);
    rot(rc.frontX, 0, rc.boundary.points[i]);
    trans(rc.cubePosition.x, rc.cubePosition.y, rc.cubePosition.z, rc.boundary.points[i]);
    rot(rc.backY, 1, rc.boundary2.points[i]);
    rot(rc.backX, 0, rc.boundary2.points[i]);
    trans(rc.cubePosition.x + backViewDisp, rc.cubePosition.y, rc.cubePosition.z, rc.boundary2.points[i]);
  }
  computeBoundaries();
  //scramble();
}
 
void draw() {
  background(200);
  strokeWeight(1.0);
  if (!inMove && moveStrValid) strOfMoves();
  move(false);//stay on the first move
  strokeWeight(5.0);
  //rc.drawBound();
  pushMatrix() ;
  translate(rc.cubePosition.x, rc.cubePosition.y, rc.cubePosition.z);
  pushMatrix();
  rotateX(radians(rc.frontX));
  rotateY(radians(rc.frontY));
 
  rc.drawRubikCube(theta);//draw the first cube
  popMatrix() ;
  translate(backViewDisp, 0, 0) ;
  rotateX(radians(rc.backX));
  rotateY(radians(rc.backY));
  rc.drawRubikCube(0.0); //draw the back view (second cube)
  popMatrix();
  textSize(20);
  text(strMoveCount+" moves", width/2, height-40);
  if(strMoveCount!=0) println("moves: "+strMoveCount);
  else algorithm = "";
  text("scramble: "+algorithm, 20, 40);
  if(algorithm != "") println("scramble: "+algorithm);
  fill(255, 0, 0);
  textSize(24);
  if(rc.isSolved()) text("Solved", 60, height/2);
  //fastMove();
}

class cube {
  PVector pos;
  int id, size;
  PVector points[];
  float angX, angY, angZ;
  String code;
 
  cube(int id, int size) {
    this.id = id;
    pos = new PVector(0, 0, 0);
    points = new PVector[8] ;
    for (int i=0;i<8;i++) points[i] = new PVector();
    this.size = size;
    for (int i=0;i<8;i++) {
      int xSign = (i%2==0)?1:-1;
      int ySign = (i/4 == 0)?1:-1;
      int zSign = ((i/2)%2 == 0)?1:-1;
      points[i].x = xSign*size/2.0;
      points[i].y = ySign*size/2.0;
      points[i].z = zSign*size/2.0;
    }
    angX = angY = angZ = 0.0;
    code = new String ("") ;
  }
 
  void setPos(PVector p) {
    for (int i=0;i<8;i++) trans(p.x, p.y, p.z, points[i]) ;
  }
 
  void findCenter() {
    PVector temp;
    temp = PVector.add(points[0], points[7]);
    temp.div(2.0) ;
  }
 
  void drawCube(PVector t) {
    int idx[] = {
      0, 1, 3, 2, 3, 7, 6, 2, 0, 2, 6, 4, 0, 4, 5, 1, 1, 5, 7, 3, 4, 6, 7, 5
    };
    for (int i=0;i<8;i++) rot(angY, 1, points[i]);
    for (int i=0;i<8;i++) rot(angX, 0, points[i]);
    for (int i=0;i<8;i++) rot(angZ, 2, points[i]);
    angX = angY = angZ = 0.0;
    for (int i=0;i<6;i++) {
      if ((this.id & (1<<i)) != 0) fill(cubeFaceColors[i]) ;
      else fill(0);
      stroke(60);
      beginShape(QUADS);
      for (int j=0;j<4;j++) {
        int pt = idx[i*4+j] ;
        vertex(this.points[pt].x, this.points[pt].y, this.points[pt].z);
      }
      endShape();
    }
    findCenter();
  }
 
  PVector getCenter() {
    return this.pos;
  }
}
 
class stack {
  char data[];
  int top;
 
  stack() {
    top = -1;
    data = new char[9999];
  }
 
  void push(char v) {
    if (top < 9999) data[++top] = v;
  }
  char pop() {
    if (top>=0) return data[top--];
    return 1;
  }
  boolean isEmpty() {
    return (top<0);
  }
  void reset () {
    top = -1;
  }
}

class rubikCube {
  cube grid[][][] ;
  cube boundary, boundary2;
  PVector cubePosition;
  char UP, FRONT, RIGHT, BACK, LEFT, DOWN, MIDDLE, STANDING, EQUATOR;
  int GREEN, BLUE, WHITE, YELLOW, ORANGE, RED, size;
  float frontX, frontY, backX, backY;
 
  rubikCube (int sz) {
    WHITE = 32;
    RED = 8;
    BLUE = 4;
    ORANGE = 2;
    GREEN = 16;
    YELLOW = 1;
 
    grid = new cube [3][][];
    for (int i=0;i<3;i++) {
      grid[i] = new cube[3][] ;
      for (int j=0;j<3;j++) {
        grid[i][j] = new cube[3];
      }
    }
 
    int code=0;
    for (int x=0;x<3;x++)//color the cubies
      for (int y=0;y<3;y++)
        for (int z=0;z<3;z++)
        {
          if (x==0)
            code |= GREEN;
          else if (x==2)
            code |= BLUE;
          if (y==0)
            code |= YELLOW;
          else if (y==2)
            code |= WHITE;
          if (z==2)
            code |= RED;
          else if (z==0)
            code |= ORANGE;
 
          grid[x][y][z] = new cube(code, sz);
          code = 0;
        }
 
    UP = 'U';
    EQUATOR = 'E';
    DOWN = 'D';
    FRONT = 'F';
    STANDING = 'S';
    BACK = 'B';
    RIGHT = 'R';
    MIDDLE = 'M';
    LEFT = 'L';
    frontY = -45.0;
    frontX = -23.26;
    backX = -frontX;
    backY = frontY+180;
 
    setSize(sz);
    assignCode();
    boundary = new cube(0, 3*size);
    boundary2 = new cube(0, 3*size);
  }
 
  void assignCode() {
    grid[1][2][2].code = new String("UF");
    grid[2][2][1].code = new String("UR");
    grid[1][2][0].code = new String("UB");
    grid[0][2][1].code = new String("UL");
    grid[1][0][2].code = new String("DF");
    grid[2][0][1].code = new String("DR");
    grid[1][0][0].code = new String("DB");
    grid[0][0][1].code = new String("DL");
    grid[2][1][2].code = new String("FR");
    grid[0][1][2].code = new String("FL");
    grid[2][1][0].code = new String("BR");
    grid[0][1][0].code = new String("BL");
 
    grid[2][2][2].code = new String("UFR");
    grid[2][2][0].code = new String("URB");
    grid[0][2][0].code = new String("UBL");
    grid[0][2][2].code = new String("ULF");
 
    grid[2][0][2].code = new String("DRF");
    grid[0][0][2].code = new String("DFL");
    grid[0][0][0].code = new String("DLB");
    grid[2][0][0].code = new String("DBR");
  }
 
  void lTurn() {
    grid[0][2][2].code = rotateStr(grid[0][2][2].code, 1); // ULF
    grid[0][2][0].code = rotateStr(grid[0][2][0].code, 2); // UBL
    grid[0][0][0].code = rotateStr(grid[0][0][0].code, 1); // DLB
    grid[0][0][2].code = rotateStr(grid[0][0][2].code, 2); // DFL
  }
  void rTurn() {
    grid[2][2][2].code = rotateStr(grid[2][2][2].code, 2); // UFR
    grid[2][2][0].code = rotateStr(grid[2][2][0].code, 1); // URB
    grid[2][0][0].code = rotateStr(grid[2][0][0].code, 2); // DBR
    grid[2][0][2].code = rotateStr(grid[2][0][2].code, 1); // DRF
  }
  void fTurn() {
    grid[1][2][2].code = flipEdge (grid[1][2][2].code); // UF
    grid[1][0][2].code = flipEdge (grid[1][0][2].code); // DF
    grid[2][1][2].code = flipEdge (grid[2][1][2].code); // FR
    grid[0][1][2].code = flipEdge (grid[0][1][2].code); // FL
 
    grid[2][2][2].code = rotateStr(grid[2][2][2].code, 1); // UFR
    grid[0][0][2].code = rotateStr(grid[0][0][2].code, 1); // DFL
    grid[2][0][2].code = rotateStr(grid[2][0][2].code, 2); // DRF
    grid[0][2][2].code = rotateStr(grid[0][2][2].code, 2); // ULF
  }
  void bTurn() {
    grid[1][2][0].code = flipEdge (grid[1][2][0].code); // UB
    grid[1][0][0].code = flipEdge (grid[1][0][0].code); // DB
    grid[2][1][0].code = flipEdge (grid[2][1][0].code); // BR
    grid[0][1][0].code = flipEdge (grid[0][1][0].code); // BL
 
    grid[2][2][0].code = rotateStr(grid[2][2][0].code, 2); // URB
    grid[0][2][0].code = rotateStr(grid[0][2][0].code, 1); // UBL
    grid[0][0][0].code = rotateStr(grid[0][0][0].code, 2); // DLB
    grid[2][0][0].code = rotateStr(grid[2][0][0].code, 1); // DBR
  }
 
  String codeString () {
    return new String(grid[1][2][2].code + " " + grid[2][2][1].code + " " + grid[1][2][0].code + " " + grid[0][2][1].code + " " + grid[1][0][2].code + " " + grid[2][0][1].code
      + " " + grid[1][0][0].code + " " + grid[0][0][1].code + " " + grid[2][1][2].code + " " + grid[0][1][2].code + " " + grid[2][1][0].code + " " + grid[0][1][0].code
      + " " + grid[2][2][2].code + " " + grid[2][2][0].code + " " + grid[0][2][0].code + " " + grid[0][2][2].code + " " + grid[2][0][2].code + " " + grid[0][0][2].code
      + " " + grid[0][0][0].code + " " + grid[2][0][0].code);
  }
  boolean isSolved() {
    return grid[1][2][2].code.equals("UF") && grid[2][2][1].code.equals("UR") && grid[1][2][0].code.equals("UB") && grid[0][2][1].code.equals("UL") 
      && grid[1][0][2].code.equals("DF") && grid[2][0][1].code.equals("DR") && grid[1][0][0].code.equals("DB") && grid[0][0][1].code.equals("DL")
        && grid[2][1][2].code.equals("FR") && grid[0][1][2].code.equals("FL") && grid[2][1][0].code.equals("BR") && grid[0][1][0].code.equals("BL")
          && grid[2][2][2].code.equals("UFR") && grid[2][2][0].code.equals("URB") && grid[0][2][0].code.equals("UBL") && grid[0][2][2].code.equals("ULF")
            && grid[2][0][2].code.equals("DRF") && grid[0][0][2].code.equals("DFL") && grid[0][0][0].code.equals("DLB") && grid[2][0][0].code.equals("DBR");
  }
  void setSize(int size) {
    PVector p;
    int xOff, yOff, zOff;
    xOff = -size;
    for (int x=0;x<3;x++) {
      yOff = size;
      for (int y=0;y<3;y++) {
        zOff = -size;
        for (int z=0;z<3;z++) {
          p = new PVector();
          p.x = xOff;
          p.y = yOff;
          p.z = zOff;
          grid[x][y][z].setPos(p);
          zOff += size;
        }
        yOff -= size;
      }
      xOff += size;
    }
    this.size = size;
  }
 
  void drawRubikCube (float th) {
    for (int x=0;x<3;x++)
      for (int y=0;y<3;y++)
        for (int z=0;z<3;z++) {
          if (axis== 0 && x==slice)
            grid[x][y][z].angX = th;
          else if (axis== 1 && y==slice)
            grid[x][y][z].angY = -th;
          else if (axis== 2 && z==slice)
            grid[x][y][z].angZ = th;
          grid[x][y][z].drawCube(cubePosition) ;
        }
  }
 
  void updateRotate(int a, int s, int d) {
    cube temp;
    //PVector tpos;
    if (d == 1) {
      if (a == 0) {
        temp = grid[s][0][0];
        grid[s][0][0] = grid[s][2][0];
        grid[s][2][0] = grid[s][2][2];
        grid[s][2][2] = grid[s][0][2];
        grid[s][0][2] = temp;
        temp = grid[s][1][0];
        grid[s][1][0] = grid[s][2][1];
        grid[s][2][1] = grid[s][1][2];
        grid[s][1][2] = grid[s][0][1];
        grid[s][0][1] = temp;
      }
      else if (a == 1) {
        temp = grid[0][s][2] ;
        grid[0][s][2] = grid[2][s][2];
        grid[2][s][2] = grid[2][s][0];
        grid[2][s][0] = grid[0][s][0];
        grid[0][s][0] = temp ;
 
        temp = grid[0][s][1]  ;
        grid[0][s][1] = grid[1][s][2];
        grid[1][s][2] = grid[2][s][1];
        grid[2][s][1] = grid[1][s][0];
        grid[1][s][0] = temp;
      }
      else {
        temp = grid[0][0][s];
        grid[0][0][s] = grid[2][0][s];
        grid[2][0][s] = grid[2][2][s];
        grid[2][2][s] = grid[0][2][s];
        grid[0][2][s] = temp;
        temp = grid[1][0][s];
        grid[1][0][s] = grid[2][1][s];
        grid[2][1][s] = grid[1][2][s];
        grid[1][2][s] = grid[0][1][s];
        grid[0][1][s] = temp;
      }
    }
    else {
      if (a == 0) {
        temp = grid[s][0][2] ;
        grid[s][0][2] = grid[s][2][2];
        grid[s][2][2] = grid[s][2][0];
        grid[s][2][0] = grid[s][0][0];
        grid[s][0][0] = temp ;
 
        temp = grid[s][0][1]  ;
        grid[s][0][1] = grid[s][1][2];
        grid[s][1][2] = grid[s][2][1];
        grid[s][2][1] = grid[s][1][0];
        grid[s][1][0] = temp;
      }
      else if (a == 1) {
 
        temp = grid[0][s][0];
        grid[0][s][0] = grid[2][s][0];
        grid[2][s][0] = grid[2][s][2];
        grid[2][s][2] = grid[0][s][2];
        grid[0][s][2] = temp;
        temp = grid[1][s][0];
        grid[1][s][0] = grid[2][s][1];
        grid[2][s][1] = grid[1][s][2];
        grid[1][s][2] = grid[0][s][1];
        grid[0][s][1] = temp;
      }
      else {
        temp = grid[0][2][s] ;
        grid[0][2][s] = grid[2][2][s];
        grid[2][2][s] = grid[2][0][s];
        grid[2][0][s] = grid[0][0][s];
        grid[0][0][s] = temp ;
 
        temp = grid[0][1][s]  ;
        grid[0][1][s] = grid[1][2][s];
        grid[1][2][s] = grid[2][1][s];
        grid[2][1][s] = grid[1][0][s];
        grid[1][0][s] = temp;
      }
    }
    if (a == 2 && s == 2)
      fTurn();
    else if (a == 2 && s == 0)
      bTurn();
    else if (a == 0 && s == 2)
      rTurn();
    else if (a == 0 && s == 0)
      lTurn();
  }
 
  void drawBound() {
    noFill();
    stroke(0);
    beginShape();
    for (int i=0;i<4;i++) {
      vertex(leftBound[i].x, leftBound[i].y, leftBound[i].z);
    }
    endShape(CLOSE);
  }
 
  void rotateOnU() {//y
    char temp = FRONT;
    FRONT = RIGHT;
    RIGHT = BACK;
    BACK = LEFT;
    LEFT = temp;
    frontY -= 90;
    backY = frontY + 180;
  }
  void rotateOnD() {//y'
    char temp = FRONT;
    FRONT = LEFT;
    LEFT = BACK;
    BACK = RIGHT;
    RIGHT = temp;
    frontY += 90;
    backY = frontY + 180;
  }
  void rotateOnR() {//x
    char temp = FRONT;
    FRONT = DOWN;
    DOWN = BACK;
    BACK = UP;
    UP = temp;
    frontY -= 90;
    backY = frontY + 180;
  }
  void rotateOnL() {//x'
    char temp = FRONT;
    FRONT = UP;
    UP = BACK;
    BACK = DOWN;
    DOWN = temp;
    frontY -= 90;
    backY = frontY + 180;
  }
  void rotateDown() {//rotate in FR Y-axis when 2*rotateDown()=z x' z
    char temp = FRONT;
    FRONT = UP;
    UP = BACK;
    BACK = DOWN;
    DOWN = temp;
    frontX -= 90;
    backX = -frontX;
  }   
  void rotateUp() {
    char temp = FRONT;
    FRONT = DOWN;
    DOWN = BACK;
    BACK = UP;
    UP = temp;
    frontX += 90;
    backX = -frontX;
  }
  void rotateOnF(){//z
    char temp = LEFT;
    LEFT = DOWN;
    DOWN = RIGHT;
    RIGHT = UP;
    UP = temp;
    frontX += 180;
    backY = frontY + 180;
  }
  String flipEdge (String c) {
    char temp[] = {
      c.charAt(1), c.charAt(0)
      };
      return new String(temp);
  }
  String rotateStr(String c, int b) {
    char temp[] = {
      't', 't', 't'
    };
    for (int i=0;i<3;i++) {
      temp[(i+b)%3] = c.charAt(i) ;
    }
    return new String(temp) ;
  }
}

<<<<<<< HEAD
void rot (float th, int ax, PVector v) {
  for (int i=0;i<4;i++)
    for (int j=0;j<4;j++)
      if (i==j)
        M[i][j] = 1.0 ;
      else
        M[i][j] = 0.0 ;
 
  float cosTh = cos(radians(th));
  float sinTh = sin(radians(th));
  if (ax==0) {
    M[1][1] = M[2][2] = cosTh ;
    M[1][2] = -sinTh ;
    M[2][1] = sinTh ;
  }
  else if (ax==1) {
    M[0][0] = M[2][2] = cosTh ;
    M[0][2] = sinTh ;
    M[2][0] = -sinTh ;
  }
  else if (ax==2) {
    M[1][1] = M[0][0] = cosTh ;
    M[0][1] = -sinTh ;
    M[1][0] = sinTh ;
  }
 
  float tp[] = {
    v.x, v.y, v.z, 1.0
  };
  float res[] = {
    0, 0, 0, 0
  };
 
  for (int i=0;i<4;i++)
    for (int k=0;k<4;k++) {
      res[i] += M[i][k] * tp[k];
    }
  v.x = res[0] ;
  v.y = res[1] ;
  v.z = res[2] ;
}
 
void trans(float dx, float dy, float dz, PVector v) {
  v.x += dx;
  v.y += dy;
  v.z += dz;
}
 
void scal(float sx, float sy, float sz, PVector v) {
  v.x *= sx;
  v.y *= sy;
  v.z *= sz;
}
 
void move(boolean newCall) {
  if (newCall) {
    if (inMove || thetaCount != 0) return;
    if (inMove==false && newCall == true) {
      inMove = true;
      thetaCount = 0;
    }
  }
 
  if (inMove) {
    if (thetaCount > 90/speed) {
      rc.updateRotate(axis, slice, direction) ;
      inMove = false;
      theta = 0;
      thetaCount = 0;
      return;
    }
    theta = direction*speed;
    thetaCount ++ ;
  }
} 
 
void fastMove() {
  if (!inMove) {
    rc.drawRubikCube(90.0*direction);
    rc.updateRotate(axis, slice, direction) ;
  }
}
void scramble() {
  String j[] = {
    new String("FBUDlrfbudLR"), new String("LRFBUDlr"), new String("FBUDlr"), new String("FFBBRRLLudlrbf"), new String(randAlgo(8, 50)), new String(randAlgo2(4, 25)), new String(randomAlgo(50)), new String(randomAlgo2(25)),
    new String(extremAlgo()), new String(extremAlgo2()),
    new String("FRUFRUFRU"), new String("MMEESS"), new String("drDRdrDRdrDR"), new String("FRUruRUruRUruf"), new String("FSRUruRUruRUrufs"), new String("MUMUMUMUMUMUMU"), new String("FrFrFrFrFrFrFrFrFr"), new String("MESMESMESMES")
    };
  moveStr = j[int(random(100.0))%j.length];
  //moveStr = j[11];
  algorithm = moveStr;
  moveStrValid = true;
  if(rc.isSolved()) text("Solved", 60, height/2);
}
String randAlgo(int min, int max){
  int r=(int) random(min, max);
  return randomAlgo(r);
}
String randomAlgo(int moves){ //fonction qui retourne un algorithme avec #moves mouvements (simple moves)
  //regroupement de tout movement lorsque le rubik's cube est fixe notament les mouvements
  String[] allmoves = {"F", "f", "L", "l", "R", "r", "U", "u", "D", "d", "B", "b", "S", "s", "M", "m", "E", "e"}; //45-dblmvs-ccwmvs ... (17)
  String algo = ""; //création de la variable algo contenant l'algorithme
  for(int i=0; i<moves; i++){ //ajout de mouvements choisi aléatoirement en fonction du nombres de mouvements
    algo += allmoves[int(random(allmoves.length))];
  }
  return algo; //retourne l'algorithme
}
String randAlgo2(int min, int max){
  int r=(int) random(min, max);
  return randomAlgo2(r);
}
String randomAlgo2(int moves){ //fonction qui retourne un algorithme avec #moves mouvements
  //regroupement de tout movement lorsque le rubik's cube est fixe notament les mouvements
  String[] allmoves = {"F", "f", "FF", "L", "l", "LL", "R", "r", "RR", "U", "u", "UU", "D", "d", "DD", "B", "b", "BB", "S", "s", "SS", "M", "m", "MM", "E", "e", "EE"}; //18
  String algo = ""; //création de la variable algo contenant l'algorithme
  for(int i=0; i<moves; i++){ //ajout de mouvements choisi aléatoirement en fonction du nombres de mouvements
    algo += allmoves[int(random(allmoves.length))]+" ";
  }
  return algo; //retourne l'algorithme
}
String extremAlgo(){
  return randomAlgo(100);
}
String extremAlgo2(){
  return randomAlgo2(100);
}

void solve(String method){//method to use to solve the cube
  String solverStat = "calculating solution...";
  println(solverStat);
  if(!rc.isSolved()){
    println(rc.codeString());
    if(method.toLowerCase()=="undo" || method.toLowerCase() == solvingMethod[0]){//the robot method
      while(!rc.isSolved()){//while the cube isn't solved the computer undo the moves
        undo();
      }
    }else if(method.toLowerCase()=="beginner" || method.toLowerCase() == solvingMethod[1]){//method used by beginners
      String[][][] CrossEdgeF = findCubie("UF"), CrossEdgeR = findCubie("UR"), CrossEdgeB = findCubie("UB"), CrossEdgeL = findCubie("UL");
      if(/*CrossEdgeF == rc.grid[1][0][2]*/CrossEdgeF[1][0][2] == "UF") moveStr = "DMdm";//
      algorithm = moveStr;moveStrValid = true;
    }else if(method.toLowerCase()=="fridrich" || method.toLowerCase()=="cfop" || method.toLowerCase() == solvingMethod[2]){//method used by speedcubers
 
    }else if(method.toLowerCase()=="petrus" || method.toLowerCase() == solvingMethod[3]){//method used by speedcubers
 
    }else{
      println("the method selected to solve the cube isn't available for the moment.\nThe methods available are: "+solvingMethod);
    }
  }else{//if the cube is already solved, it announce it if it wasn't the case and do nothing to the cube
    fill(255, 0, 0);
    textSize(24);
    text("Solved", 60, height/2);
  }
}
String[][][] getCubiePos(int[] fpos, String code){
  String[][][] gpos = {{{code}}};
  gpos[fpos[0]][fpos[1]][fpos[2]] = code;
  return gpos;
}
String[][][] findCubie(String code){
  int[] pos = {0};
  for(int x=0; x<3; x++){
    for(int y=0; y<3; y++){
      for(int z=0; z<3; z++){
        //int[][][] pos = {x{y{z}}};
        if(rc.grid[x][y][z].code.equals(code)){pos[0] = x; pos[1] = y; pos[2] = z;}
      }
    }
  }
  String[][][] cpos = getCubiePos(pos, code);
  return cpos;
}
void reset(){
  background(200);
  rc = new rubikCube(height/8);
 
  rc.cubePosition = new PVector (width/3, height/2.0, 0.0);
  backViewDisp = width/3;
  for (int i=0;i<8;i++) {
    rot(rc.frontY, 1, rc.boundary.points[i]);
    rot(rc.frontX, 0, rc.boundary.points[i]);
    trans(rc.cubePosition.x, rc.cubePosition.y, rc.cubePosition.z, rc.boundary.points[i]);
    rot(rc.backY, 1, rc.boundary2.points[i]);
    rot(rc.backX, 0, rc.boundary2.points[i]);
    trans(rc.cubePosition.x + backViewDisp, rc.cubePosition.y, rc.cubePosition.z, rc.boundary2.points[i]);
  }
}
void keyPressed(){
  println(key+":"+keyCode);
  if(keyCode == 70 || keyCode == 86 || keyCode == 82 || keyCode == 84 || keyCode == 85 || keyCode == 73
    || keyCode == 66 || keyCode == 78 || keyCode == 76 || keyCode == 77 || keyCode == 68 || keyCode == 67
    || keyCode == 65 || keyCode == 49 || keyCode == 81 || keyCode == 50 || keyCode == 69 || keyCode == 51){
    if(key == 'F' || keyCode == 70) moveStr = "F";//F
    else if(key == 'V' || keyCode == 86) moveStr = "f";//F'
    else if(key == 'R' || keyCode == 82) moveStr = "R";//R
    else if(key == 'T' || keyCode == 84) moveStr = "r";//R'
    else if(key == 'U' || keyCode == 85) moveStr = "U";//U
    else if(key == 'I' || keyCode == 73) moveStr = "u";//U'
    else if(key == 'B' || keyCode == 66) moveStr = "B";//B
    else if(key == 'N' || keyCode == 78) moveStr = "b";//B'
    else if(key == 'L' || keyCode == 76) moveStr = "L";//L
    else if(key == 'M' || keyCode == 77) moveStr = "l";//L'
    else if(key == 'D' || keyCode == 68) moveStr = "D";//D
    else if(key == 'C' || keyCode == 67) moveStr = "d";//D'
    else if(key == 'A' || keyCode == 65) moveStr = "M";//M
    else if(key == '1' || keyCode == 49) moveStr = "m";//M'
    else if(key == 'Q' || keyCode == 81) moveStr = "S";//S
    else if(key == '2' || keyCode == 50) moveStr = "s";//S'
    else if(key == 'E' || keyCode == 69) moveStr = "E";//E
    else if(key == '3' || keyCode == 51) moveStr = "e";//E'
    moveStrValid = true;
  }
  if(key==ENTER || keyCode == 32 || keyCode == 10) solve("beginner");
  else if(key=='S' || keyCode == 83) scramble();
  else if(key == CONTROL || keyCode == 17) reset();
  /*else if(key == 'P' || keyCode == 80){//stop the moves
    println("run stopped");
    stop();
  }
  else if(key == 'O' || keyCode == 79){//restart the moves
    println("run restarted");
    start();
  }*/
  else if(key == 'X' || keyCode == 88) rc.rotateOnR();
  else if(key == 'Y' || keyCode == 89) rc.rotateOnU();
  else if(key == 'Z' || keyCode == 90) rc.rotateUp();
  else if(key == '0' || keyCode == 48) println("Current code: "+rc.codeString());
  algorithm += moveStr;
}void faceMove(char face) {
  char pVal;
  switch(face) {
  case 'R':
    axis = 0;
    slice = 2;
    direction = 1;
    break;
  case 'r':
    axis = 0;
    slice = 2;
    direction = -1;
    pVal = 'R';
    break;
  case 'M':
    axis = 0;
    slice = 1;
    direction = -1;
    break;
  case 'm':
    axis = 0;
    slice = 1;
    direction = 1;
    pVal = 'M';
    break;
  case 'L':
    axis = 0;
    slice = 0;
    direction = -1;
    pVal = 'l';
    break;
  case 'l':
    axis = 0;
    slice = 0;
    direction = 1;
    pVal = 'L';
    break;
  case 'D':
    axis = 1;
    slice = 0;
    direction = -1;
    pVal = 'd';
    break;
  case 'd':
    axis = 1;
    slice = 0;
    direction = 1;
    pVal = 'D';
    break;
  case 'E':
    axis = 1;
    slice = 1;
    direction = -1;
    break;
  case 'e':
    axis = 1;
    slice = 1;
    direction = 1;
    pVal = 'E';
    break;
  case 'U':
    axis = 1;
    slice = 2;
    direction = 1;
    pVal = 'u';
    break;
  case 'u':
    axis = 1;
    slice = 2;
    direction = -1;
    pVal = 'U';
    break;
  case 'B':
    axis = 2;
    slice = 0;
    direction = -1;
    pVal = 'b';
    break;
  case 'b':
    axis = 2;
    slice = 0;
    direction = 1;
    pVal = 'B';
    break;
  case 'S':
    axis = 2;
    slice = 1;
    direction = 1;
    break;
  case 's':
    axis = 1;
    slice = 1;
    direction = -1;
    pVal = 'S';
    break;
  case 'F':
    axis = 2;
    slice = 2;
    direction = 1;
    pVal = 'f';
    break;
  case 'f':
    axis = 2;
    slice = 2;
    direction = -1;
    pVal = 'F';
    break;
  default:
    return ;
  }
  move(true);
}
void undo(){
  if (!inMove) {
    char p = stackOfMoves.pop();
    faceMove(p);
  }
}//EOF
void computeBoundaries() {//not important
  PVector pt[] = new PVector [8];
  PVector pt2[] = new PVector [8];
  for (int i=0;i<8;i++) {
    pt[i] = new PVector (screenX(rc.boundary.points[i].x, rc.boundary.points[i].y, rc.boundary.points[i].z),
    screenY(rc.boundary.points[i].x, rc.boundary.points[i].y, rc.boundary.points[i].z), 0.0);
    pt2[i] = new PVector (screenX(rc.boundary2.points[i].x, rc.boundary2.points[i].y, rc.boundary2.points[i].z),
    screenY(rc.boundary2.points[i].x, rc.boundary2.points[i].y, rc.boundary2.points[i].z), 0.0);
  }
  topBound = new PVector[4];
 
  topBound[0] = new PVector(pt[4].x, pt[4].y, pt[4].z);
  topBound[1] = new PVector(pt[5].x, pt[5].y, pt[5].z);
  topBound[2] = new PVector(pt[7].x, pt[7].y, pt[7].z);
  topBound[3] = new PVector(pt[6].x, pt[6].y, pt[6].z);
 
  frontBound = new PVector[4];
  frontBound[0] = new PVector(pt[0].x, pt[0].y, pt[0].z);
  frontBound[1] = new PVector(pt[1].x, pt[1].y, pt[1].z);
  frontBound[2] = new PVector(pt[5].x, pt[5].y, pt[5].z);
  frontBound[3] = new PVector(pt[4].x, pt[4].y, pt[4].z);
  rightBound = new PVector[4];
  rightBound[0] = new PVector(pt[0].x, pt[0].y, pt[0].z);
  rightBound[1] = new PVector(pt[2].x, pt[2].y, pt[2].z);
  rightBound[2] = new PVector(pt[6].x, pt[6].y, pt[6].z);
  rightBound[3] = new PVector(pt[4].x, pt[4].y, pt[4].z);
  downBound = new PVector[4];
 
  downBound[0] = new PVector(pt2[0].x, pt2[0].y, pt2[0].z);
  downBound[1] = new PVector(pt2[2].x, pt2[2].y, pt2[2].z);
  downBound[2] = new PVector(pt2[3].x, pt2[3].y, pt2[3].z);
  downBound[3] = new PVector(pt2[1].x, pt2[1].y, pt2[1].z);
 
  backBound = new PVector[4];
  backBound[0] = new PVector(pt2[2].x, pt2[2].y, pt2[2].z);
  backBound[1] = new PVector(pt2[6].x, pt2[6].y, pt2[6].z);
  backBound[2] = new PVector(pt2[7].x, pt2[7].y, pt2[7].z);
  backBound[3] = new PVector(pt2[3].x, pt2[3].y, pt2[3].z);
 
  leftBound = new PVector[4];
  leftBound[0] = new PVector(pt2[1].x, pt2[1].y, pt2[1].z);
  leftBound[1] = new PVector(pt2[3].x, pt2[3].y, pt2[3].z);
  leftBound[2] = new PVector(pt2[7].x, pt2[7].y, pt2[7].z);
  leftBound[3] = new PVector(pt2[5].x, pt2[5].y, pt2[5].z);
}
void strOfMoves() {
  if (!inMove) {
    if (strMoveCount < moveStr.length()) {
      faceMove(moveStr.charAt(strMoveCount));
      strMoveCount ++ ;
    }
    else {
      moveStrValid = false;
      strMoveCount = 0;
    }
  }
=======
void draw() {
  background(pink);
  bulitDraw();
//println ("mousex:", mouseX, "\tmouseY:", mouseY);
>>>>>>> 62a30736e831af91a884108f8033b9675adef02e
}
