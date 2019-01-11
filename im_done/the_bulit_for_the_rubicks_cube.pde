//you should really lable your stuff, it would be really helpful if you are looking for something

void bulitDraw(){
   camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 360, 0, -1, 360);
  translate(width/2, height/2, -100);
  stroke(255);
  
 noFill();
 box(195);//main cube
 stroke(1);
 
  fill(black);
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
  ////
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
  ////
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
  ////
  //cube1
  noStroke();
  translate(65, -130, 0);
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
  ////
  //cube1
  noStroke();
 translate(65, -130, -2);
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
  
 
}
