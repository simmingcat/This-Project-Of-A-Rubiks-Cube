//kill me
//OOF
color red = #FF2424;
color green = #4CFF17;
color yellow = #FFF817;
color blue = #21CDFF;
color white =#FFFFFF;
color orange = #FF7A21;


void setup() {
  size(640, 360, P3D);
}

void draw() {
  background(0);
  camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  translate(width/2, height/2, -100);
  stroke(255);
  noFill();
  box(200);
  translate(width/2, height/2, -100);
  box(80);
  
  
}
