void CW1(){//R
  for(int count=0; count<(w); count++){
    sub =                    block[0][count]    [2];
    block[0][count]    [2] = block[0][w-1-count][4];
    block[0][w-1-count][4] = block[0][w-1-count][3];
    block[0][w-1-count][3] = block[0][count]    [5];
    block[0][count]    [5] = sub;
  }
  //corners
  for(int ecount=0; ecount<w-1; ecount++){
    sub                              = block[v-1]       [ecount]    [1];
    block[v-1]       [ecount]    [1] = block[v-1-ecount][w-1]       [1];
    block[v-1-ecount][w-1]       [1] = block[0]         [w-1-ecount][1];
    block[0]         [w-1-ecount][1] = block[ecount]    [0]         [1];
    block[ecount]    [0]         [1] = sub;
  }
}
void CCW0(){//L'
  for(int count=0; count<(w); count++){
    sub =                      block[v-1][count]    [2];
    block[v-1][count]    [2] = block[v-1][w-1-count][4];
    block[v-1][w-1-count][4] = block[v-1][w-1-count][3];
    block[v-1][w-1-count][3] = block[v-1][count]    [5];
    block[v-1][count]    [5] = sub;
  }
  //corners
  for(int ecount=0; ecount<w-1; ecount++){
    sub                              = block[v-1]       [ecount]    [0];
    block[v-1]       [ecount]    [0] = block[v-1-ecount][w-1]       [0];
    block[v-1-ecount][w-1]       [0] = block[0]         [w-1-ecount][0];
    block[0]         [w-1-ecount][0] = block[ecount]    [0]         [0];
    block[ecount]    [0]         [0] = sub;
  }
}
void CCW1(){//R'
  for(int count=0; count<(w); count++){
    sub                    = block[0][count]    [5];
    block[0][count]    [5] = block[0][w-1-count][3];
    block[0][w-1-count][3] = block[0][w-1-count][4];
    block[0][w-1-count][4] = block[0][count]    [2];
    block[0][count]    [2] = sub;
  }
  //corners
  for(int ecount=0; ecount<w-1; ecount++){
    sub                              = block[ecount]    [0]         [1];
    block[ecount]    [0]         [1] = block[0]         [w-1-ecount][1];
    block[0]         [w-1-ecount][1] = block[v-1-ecount][w-1]       [1];
    block[v-1-ecount][w-1]       [1] = block[v-1]       [ecount]    [1];
    block[v-1]       [ecount]    [1] = sub;
  }
}
void CW0(){//L
  for(int count=0; count<(w); count++){
    sub                      = block[v-1][count]    [5];
    block[v-1][count]    [5] = block[v-1][w-1-count][3];
    block[v-1][w-1-count][3] = block[v-1][w-1-count][4];
    block[v-1][w-1-count][4] = block[v-1][count]    [2];
    block[v-1][count]    [2] = sub;
  }
  //corners
  for(int ecount=0; ecount<w-1; ecount++){
    sub                              = block[ecount]    [0]         [0];
    block[ecount]    [0]         [0] = block[0]         [w-1-ecount][0];
    block[0]         [w-1-ecount][0] = block[v-1-ecount][w-1]       [0];
    block[v-1-ecount][w-1]       [0] = block[v-1]       [ecount]    [0];
    block[v-1]       [ecount]    [0] = sub;
  }
}
/*8*8*8*8*8*8*8*   *8*8*8*8*8*8*8*   *8*8*8*8*8*8*8*/
void CW2(){//U
  for(int count=0; count<(v); count++){
    sub                      = block[count]    [w-1][0];
    block[count]    [w-1][0] = block[count]    [w-1][4];
    block[count]    [w-1][4] = block[v-1-count][w-1][1];
    block[v-1-count][w-1][1] = block[v-1-count][w-1][5];
    block[v-1-count][w-1][5] = sub;
  }
  //corners
  for(int ecount=0; ecount<w-1; ecount++){
    sub                              = block[0]         [ecount]    [2];
    block[0]         [ecount]    [2] = block[v-1-ecount][0]         [2];
    block[v-1-ecount][0]         [2] = block[v-1]       [w-1-ecount][2];
    block[v-1]       [w-1-ecount][2] = block[ecount]    [w-1]       [2];
    block[ecount]    [w-1]       [2] = sub;
  }
}
void CCW3(){//D'
  for(int count=0; count<(v); count++){
    sub                    = block[count]    [0][0];
    block[count]    [0][0] = block[count]    [0][4];
    block[count]    [0][4] = block[v-1-count][0][1];
    block[v-1-count][0][1] = block[v-1-count][0][5];
    block[v-1-count][0][5] = sub;
  }
  //corners
  for(int ecount=0; ecount<w-1; ecount++){
    sub                              = block[0]         [ecount]    [3];
    block[0]         [ecount]    [3] = block[v-1-ecount][0]         [3];
    block[v-1-ecount][0]         [3] = block[v-1]       [w-1-ecount][3];
    block[v-1]       [w-1-ecount][3] = block[ecount]    [w-1]       [3];
    block[ecount]    [w-1]       [3] = sub;
  }
}
void CCW2(){//U'
  for(int count=0; count<(v); count++){
    sub                      = block[v-1-count][w-1][5];
    block[v-1-count][w-1][5] = block[v-1-count][w-1][1];
    block[v-1-count][w-1][1] = block[count]    [w-1][4];
    block[count]    [w-1][4] = block[count]    [w-1][0];
    block[count]    [w-1][0] = sub;
  }
  //corners
  for(int ecount=0; ecount<w-1; ecount++){
    sub                              = block[ecount]    [w-1]       [2];
    block[ecount]    [w-1]       [2] = block[v-1]       [w-1-ecount][2];
    block[v-1]       [w-1-ecount][2] = block[v-1-ecount][0]         [2];
    block[v-1-ecount][0]         [2] = block[0]         [ecount]    [2];
    block[0]         [ecount]    [2] = sub;
  }
}
void CW3(){//D
  for(int count=0; count<(v); count++){
    sub                    = block[v-1-count][0][5];
    block[v-1-count][0][5] = block[v-1-count][0][1];
    block[v-1-count][0][1] = block[count]    [0][4];
    block[count]    [0][4] = block[count]    [0][0];
    block[count]    [0][0] = sub;
  }
  //corners
  for(int ecount=0; ecount<w-1; ecount++){
    sub                              = block[ecount]    [w-1]       [3];
    block[ecount]    [w-1]       [3] = block[v-1]       [w-1-ecount][3];
    block[v-1]       [w-1-ecount][3] = block[v-1-ecount][0]         [3];
    block[v-1-ecount][0]         [3] = block[0]         [ecount]    [3];
    block[0]         [ecount]    [3] = sub;
  }
}
/*8*8*8*8*8*8*8*   *8*8*8*8*8*8*8*   *8*8*8*8*8*8*8*/
void CW4(){//F
  for(int count=0; count<(v); count++){
    sub                            = block[0]        [count]    [0];
    block[0]        [count]    [0] = block[count]    [w-1]      [3];
    block[count]    [w-1]      [3] = block[0]        [w-1-count][1];
    block[0]        [w-1-count][1] = block[v-1-count][w-1]      [2];
    block[v-1-count][w-1]      [2] = sub;
  }
  //corners
  for(int ecount=0; ecount<w-1; ecount++){
    sub                              = block[0]         [ecount]    [4];
    block[0]         [ecount]    [4] = block[ecount]    [w-1]       [4];
    block[ecount]    [w-1]       [4] = block[v-1]       [w-1-ecount][4];
    block[v-1]       [w-1-ecount][4] = block[v-1-ecount][0]         [4];
    block[v-1-ecount][0]         [4] = sub;
  }
}
void CCW5(){//B'
  for(int count=0; count<(v); count++){
    sub                            = block[v-1]      [count]    [0];
    block[v-1]      [count]    [0] = block[count]    [0]        [3];
    block[count]    [0]        [3] = block[v-1]      [w-1-count][1];
    block[v-1]      [w-1-count][1] = block[v-1-count][0]        [2];
    block[v-1-count][0]        [2] = sub;
  }
  //corners
  for(int ecount=0; ecount<w-1; ecount++){
    sub                              = block[0]         [ecount]    [5];
    block[0]         [ecount]    [5] = block[ecount]    [w-1]       [5];
    block[ecount]    [w-1]       [5] = block[v-1]       [w-1-ecount][5];
    block[v-1]       [w-1-ecount][5] = block[v-1-ecount][0]         [5];
    block[v-1-ecount][0]         [5] = sub;
  }
}
void CCW4(){//F'
  for(int count=0; count<(v); count++){
    sub                            = block[v-1-count][w-1]      [2];
    block[v-1-count][w-1]      [2] = block[0]        [w-1-count][1];
    block[0]        [w-1-count][1] = block[count]    [w-1]      [3];
    block[count]    [w-1]      [3] = block[0]        [count]    [0];
    block[0]        [count]    [0] = sub;
  }
  //corners
  for(int ecount=0; ecount<w-1; ecount++){
    sub                              = block[v-1-ecount][0]         [4];
    block[v-1-ecount][0]         [4] = block[v-1]       [w-1-ecount][4];
    block[v-1]       [w-1-ecount][4] = block[ecount]    [w-1]       [4];
    block[ecount]    [w-1]       [4] = block[0]         [ecount]    [4];
    block[0]         [ecount]    [4] = sub;
  }
}
void CW5(){//B
  for(int count=0; count<(v); count++){
    sub                            = block[v-1-count][0]        [2];
    block[v-1-count][0]        [2] = block[v-1]      [w-1-count][1];
    block[v-1]      [w-1-count][1] = block[count]    [0]        [3];
    block[count]    [0]        [3] = block[v-1]      [count]    [0];
    block[v-1]      [count]    [0] = sub;
  }
  //corners
  for(int ecount=0; ecount<w-1; ecount++){
    sub                              = block[v-1-ecount][0]         [5];
    block[v-1-ecount][0]         [5] = block[v-1]       [w-1-ecount][5];
    block[v-1]       [w-1-ecount][5] = block[ecount]    [w-1]       [5];
    block[ecount]    [w-1]       [5] = block[0]         [ecount]    [5];
    block[0]         [ecount]    [5] = sub;
  }

<<<<<<< HEAD
void CubyDraw() {
  fill(r2);

  //cube1
  noStroke();
  translate(0, 0, 10);
  box(55);
  stroke(1);
  noFill();
  fill(r3);
  //cube2
  noStroke();
  translate(0, 65, 0);
  box(55);
  stroke(1);
  noFill();
  fill(r2);
  //cube3
  noStroke();
  translate(0, 65, 0);
  box(55);
  stroke(1);
  noFill();
  fill(r3);
  //cube4
  noStroke();
  translate(65, -130, 0);
  box(55);
  stroke(1);
  noFill();
  fill(r2);
  //cube5
  noStroke();
  translate(0, 65, 0);
  box(55);
  stroke(1);
  noFill();
  fill(r3);
  //cube6
  noStroke();
  translate(0, 65, 0);
  box(55);
  stroke(1);
  noFill();
  fill(r2);
  //cube7
  noStroke();
  translate(65, -130, -2);
  box(55);
  stroke(1);
  noFill();
  //cube8
  fill(r3);
  noStroke();
  translate(0, 65, 0);
  box(55);
  stroke(1);
  noFill();
  fill(r2);
  //cube9
  noStroke();
  translate(0, 65, 0);
  box(55);
  stroke(1);
 // noFill();
  //Box 1
  
  noStroke();
  translate(10, 0, -5);
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

  //box 4
  noStroke();
  translate(0, 130, -70);
  box(55);
  stroke(1);

  //box 5
  noStroke();
  translate(0, -65, 0);
  box(55);
  stroke(1);

  //box 6
  noStroke();
  translate(0, -65, 0);
  box(55);
  stroke(1);

  //box7
  noStroke();
  translate(0, 0, -65);
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

  fill(r3);

  //Box 1
  noStroke();
  translate(-150, 0, 135);
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

  //box 4
  noStroke();
  translate(0, 130, -70);
  box(55);
  stroke(1);

  //box 5
  noStroke();
  translate(0, -65, 0);
  box(55);
  stroke(1);

  //box 6
  noStroke();
  translate(0, -65, 0);
  box(55);
  stroke(1);

  //box7
  noStroke();
  translate(0, 130, -65);
  box(55);
  stroke(1);

  //box 8
  noStroke();
  translate(0, -65, 0);
  box(55);
  stroke(1);

  //box 9
  noStroke();
  translate(0, -65, 0);
  box(55);
  stroke(1);

  fill(r3);

  //cube1
  noStroke();
  translate(10, 138, 135);
  box(55);
  stroke(1);

  //box 2
  noStroke();
  translate(65, 0, 0);
  box(55);
  stroke(1);

  //box 3
  noStroke();
  translate(65, 0, 0);
  box(55);
  stroke(1);

  //box 4
  noStroke();
  translate(-130, 0, -70);
  box(55);
  stroke(1);

  //box 5
  noStroke();
  translate(65, 0, 0);
  box(55);
  stroke(1);

  //box 6
  noStroke();
  translate(65, 0, 0);
  box(55);
  stroke(1);

  //box 7
  noStroke();
  translate(-130, 0, -65);
  box(55);
  stroke(1);

  //box 8
  noStroke();
  translate(65, 0, 0);
  box(55);
  stroke(1);

  //box 9
  noStroke();
  translate(65, 0, 0);
  box(55);
  stroke(1);

  fill(r2);

  //cube1
  noStroke();
  translate(-130, -148, 130);
  box(55);
  stroke(1);

  //box 2
  noStroke();
  translate(65, 0, 0);
  box(55);
  stroke(1);

  //box 3
  noStroke();
  translate(65, 0, 0);
  box(55);
  stroke(1);

  //box 4
  noStroke();
  translate(-130, -0, -68);
  box(55);
  stroke(1);

  //box 5
  noStroke();
  translate(65, 0, 0);
  box(55);
  stroke(1);

  //box 6
  noStroke();
  translate(65, 0, 0);
  box(55);
  stroke(1);

  //box 7
  noStroke();
  translate(-130, -0, -65);
  box(55);
  stroke(1);

  //box 9
  noStroke();
  translate(65, 0, 0);
  box(55);
  stroke(1);

  //box 9
  noStroke();
  translate(65, 0, 0);
  box(55);
  stroke(1);

  fill(r3);

  //cube1
  noStroke();
  translate(0, 10, -5);
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

  //box 4
  noStroke();
  translate(-65, -130, 0);
  box(55);
  stroke(1);

  //cube 5
  noStroke();
  translate(0, 65, 0);
  box(55);
  stroke(1);

  //cube 6
  noStroke();
  translate(0, 65, 0);
  box(55);
  stroke(1);

  //cub e7
  noStroke();
  translate(-65, -130, -2);
  box(55);
  stroke(1);

  //cube 8
  noStroke();
  translate(0, 65, 0);
  box(55);
  stroke(1);

  //cube 9
  noStroke();
  translate(0, 65, 0);
  box(55);
  stroke(1);
=======
>>>>>>> c35bd3d26e68b7d340b602872587d934148f022f
}

 void M1CW(){
    for(int count=0; count<(w); count++){
      sub =                    block[1][count]    [2];
      block[1][count]    [2] = block[1][w-1-count][4];
      block[1][w-1-count][4] = block[1][w-1-count][3];
      block[1][w-1-count][3] = block[1][count]    [5];
      block[1][count]    [5] = sub;
    }
  }
  void M1CCW(){
    for(int count=0; count<(w); count++){
      sub                    = block[0][count]    [5];
      block[0][count]    [5] = block[0][w-1-count][3];
      block[0][w-1-count][3] = block[0][w-1-count][4];
      block[0][w-1-count][4] = block[0][count]    [2];
      block[0][count]    [2] = sub;
    }
  }
  void E1CW(){
    for(int count=0; count<(v); count++){
      sub                      = block[count]    [w-2][0];
      block[count]    [w-2][0] = block[count]    [w-2][4];
      block[count]    [w-2][4] = block[v-1-count][w-2][1];
      block[v-1-count][w-2][1] = block[v-1-count][w-2][5];
      block[v-1-count][w-2][5] = sub;
    }
  }
  void E1CCW(){
    for(int count=0; count<(v); count++){
      sub                      = block[v-1-count][w-2][5];
      block[v-1-count][w-2][5] = block[v-1-count][w-2][1];
      block[v-1-count][w-2][1] = block[count]    [w-2][4];
      block[count]    [w-2][4] = block[count]    [w-2][0];
      block[count]    [w-2][0] = sub;
    }
  }
  void S1CW(){
    for(int count=0; count<(v); count++){
      sub                            = block[1]        [count]    [0];
      block[1]        [count]    [0] = block[count]    [w-2]      [3];
      block[count]    [w-2]      [3] = block[1]        [w-1-count][1];
      block[1]        [w-1-count][1] = block[v-1-count][w-2]      [2];
      block[v-1-count][w-2]      [2] = sub;
    }
  }
  void S1CCW(){
    for(int count=0; count<(v); count++){
      sub                            = block[v-1-count][w-2]      [2];
      block[v-1-count][w-2]      [2] = block[1]        [w-1-count][1];
      block[1]        [w-1-count][1] = block[count]    [w-2]      [3];
      block[count]    [w-2]      [3] = block[1]        [count]    [0];
      block[1]        [count]    [0] = sub;
    }
  }
