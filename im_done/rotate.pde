class rubikCube {
char UP, FRONT, RIGHT, BACK, LEFT, DOWN, MIDDLE, STANDING, EQUATOR;
 float frontX, frontY, backX, backY;{
    UP = 'U';
    EQUATOR = 'E';
    DOWN = 'D';
    FRONT = 'F';
    STANDING = 'S';
    BACK = 'B';
    RIGHT = 'R';
    MIDDLE = 'M';
    LEFT = 'L';
    frontY = -45.0;
    frontX = -23.26;
    backX = -frontX;
    backY = frontY+180;
}
}
