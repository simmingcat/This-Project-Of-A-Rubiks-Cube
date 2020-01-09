int selected = (int)random(0, 3);
long choicesR[] = {255, 36, 36};
long choicesG[] = {76, 255, 23};
long choicesB[] = {33, 205, 255};
long choicesY[] = {255, 248, 23};
color r2 = color(choicesR[selected], choicesG[selected], choicesB[selected], choicesY[selected]);

color red = #FF2424;
color green = #4CFF17;
color yellow = #FFF817;
color blue = #21CDFF;
color white =#FFFFFF;
color orange = #FF7A21;


void coloryBoi() {
  if (key == 's' || key == 'S') {
    random(color(r2));
    fill(r2);
  }
}
