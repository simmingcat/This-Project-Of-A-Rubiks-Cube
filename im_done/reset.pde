  
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
}
