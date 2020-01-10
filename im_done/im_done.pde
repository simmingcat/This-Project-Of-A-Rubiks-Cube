float rotation=0;

color purple = #C433B6;

color black = #000000;
int rubiksCube = 300;
boolean startGame = false;

void setup() {
  size(840, 560, P3D);
  bulitDraw();
}

void draw() {
  background(purple);
  bulitDraw();
  buildDraw();
  CubyDraw();
    

  float orbitRadius= mouseX/2+50;
  float ypos= mouseY/3/orbitRadius;
  float xpos= cos(radians(rotation))*orbitRadius;
  float zpos= sin(radians(rotation))*orbitRadius;
  
  //tan is springy boit

  camera(xpos, ypos, zpos, 0, 0, 0, 0, -1, 0);

  rotation++;


  //println ("mousex:", mouseX, "\tmouseY:", mouseY);
}
void keyPressed() {
  resetButtonPressed();
  coloryBoi() ;
}
