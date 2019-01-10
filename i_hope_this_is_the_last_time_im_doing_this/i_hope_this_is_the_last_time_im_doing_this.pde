int cube = 300;


void setup(){
  size(1080, 1060);
}

void draw(){
  background(0);
 translate(width/ 2, height/2, 0);
 
for ( int xo = cube; xo <= cube; xo += 50) {
   pushMatrix();
   translate(xo, 0, 0);
   box(30);
   popMatrix();
}
}
