float rotation=0;

color red = #FF2424;
color green = #4CFF17;
color yellow = #FFF817;
color blue = #21CDFF;
color white =#FFFFFF;
color orange = #FF7A21;
color purple = #C433B6;

color black = #000000;
int rubiksCube = 300;
boolean startGame = false;

void setup() {
  size(840, 560, P3D);
}

void draw() {
  loop();
  background(purple);
  bulitDraw();
  rando();
  buildDraw();

  float orbitRadius= mouseX/2+50;
  float ypos= mouseY/3;
  float xpos= cos(radians(rotation))*orbitRadius;
  float zpos= sin(radians(rotation))*orbitRadius;

  camera(xpos, ypos, zpos, 0, 0, 0, 0, -1, 0);

  rotation++;


  //println ("mousex:", mouseX, "\tmouseY:", mouseY);
}
void keyPressed() {
  resetButtonPressed();
  rando();
}
