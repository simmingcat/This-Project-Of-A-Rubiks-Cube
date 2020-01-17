<<<<<<< HEAD
  
void resetButtonPressed() {
  if (key == 'r' || key == 'R') {
    startGame = true;
  }
}

void startGame() {
  loop();
  if (startGame == true) {
    startGame = false;
    coloryBoi();
  }
=======
void restart(){
  for(int l=0; l<v; l++){
    for(int m=0; m<w; m++){
    for(int n=0; n<colors; n++){
    block[l][m][n]=n;
    }
    }
    }
>>>>>>> c35bd3d26e68b7d340b602872587d934148f022f
}
