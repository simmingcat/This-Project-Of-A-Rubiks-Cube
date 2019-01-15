//you should really lable your stuff, it would be really helpful if you are looking for something

void bulitDraw(){
   camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, -360, 0, 1, -360);
  translate(width/2, height/2, -100);
  stroke(255);
 noFill();
 fill(black);
 box(195);//main cube
 stroke(1);
 
  //row1 for red
   noStroke();
   translate(65, 65, 68);
 box(65);//this is what makes the black outline
  stroke(1);
  
 noStroke();
translate(0, -65, 0);
 box(65);//this is what makes the black outline
  stroke(1);
  
noStroke();
translate(0, -65, 0);
 box(65);//this is what makes the black outline
  stroke(1);
  
  //row2 for red
  noStroke();
   translate(-65, 130, 0);
 box(65);//this is what makes the black outline
  stroke(1);
  
 noStroke();
translate(0, -65, 0);
 box(65);//this is what makes the black outline
  stroke(1);
  
noStroke();
translate(0, -65, 0);
 box(65);//this is what makes the black outline
  stroke(1);
  
 //row3 for red
  noStroke();
   translate(-65, 130, -2);
 box(65);//this is what makes the black outline
  stroke(1);
  
 noStroke();
translate(0, -65, 0);
 box(65);//this is what makes the black outline
  stroke(1);
  
noStroke();
translate(0, -65, 0);
 box(65);//this is what makes the black outline
  stroke(1);

 fill(red);
 //cube1
  noStroke();
 translate(0, 0, 10);
  box(55);
  stroke(1);
  
  //cube2
  noStroke();
  translate(0, 65, 0);
  box(55);
  stroke(1);

  //cube3
  noStroke();
translate(0, 65, 0);
 box(55);
  stroke(1);
  
  //cube4
  noStroke();
  translate(65, -130, 0);
  box(55);
  stroke(1);
  
  //cube5
  noStroke();
  translate(0, 65, 0);
  box(55);
  stroke(1);

  //cube6
  noStroke();
translate(0, 65, 0);
 box(55);
  stroke(1);

 //cube7
  noStroke();
 translate(65, -130, -2);
  box(55);
  stroke(1);
  
  //cube8
  noStroke();
  translate(0, 65, 0);
  box(55);
  stroke(1);

  //cube9
  noStroke();
translate(0, 65, 0);
 box(55);
  stroke(1);
  
  fill(white);
  //Box 1
  noStroke();
 translate(10, 0, -10);
  box(55);
  stroke(1);
  
  //box 2
   noStroke();
 translate(0, -65, 0);
  box(55);
  stroke(1);
  
  //box3
   noStroke();
 translate(0, -65, 0);
  box(55);
  stroke(1);
  
  //box7
  noStroke();
 translate(0, 0, -150);
  box(55);
  stroke(1);

  //box 8
   noStroke();
 translate(0, 65, 0);
  box(55);
  stroke(1);
  
 //box9
   noStroke();
 translate(0, 65, 0);
  box(55);
  stroke(1);
 
}
