//keyboard interaction
boolean up, down, left, right, space, w, a, s, d;

//textures
PImage qblock, dT, dS, dB;

//maps
PImage map;

//World manipulation
float rotx = PI/4, roty = PI/4;
int bs = 100;


//camera variables
float lx = 2500, ly = height/2 -bs/2, lz =2500;
PVector xzDirection = new PVector(0, -10); // which way we facing
PVector xyDirection = new PVector(10,0); //looking up and down
PVector strafeDir = new PVector(10, 0);
float leftRightHeadAngle = 0;
float upDownHeadAngle = 0;

//pallate 
color black = #000000;
color white = #FFFFFF;

ArrayList <Bullet> bullets;
ArrayList <Snow> snowflakes;

void setup() {
  size(800, 600, P3D);

  //load textures
  qblock = loadImage("block.png");
  dT    = loadImage("dirt_top.png");
  dS   = loadImage("dirt_side.jpg");
  dB = loadImage("dirt_bottom.jpg");
  textureMode(NORMAL);
  bullets = new  ArrayList <Bullet>();
  snowflakes = new ArrayList<Snow>();
  map = loadImage("map.png");
}

void draw() {
  background(0);

  float dx = lx+ xzDirection.x;
  float dy = ly+ xyDirection.y;
  float dz = lz + xzDirection.y;
  camera(lx, ly, lz, dx,dy,dz, 0, 1, 0);
  xzDirection.rotate(leftRightHeadAngle);
  xyDirection.rotate(upDownHeadAngle);
  leftRightHeadAngle = -(pmouseX - mouseX) *0.01;
  upDownHeadAngle = (pmouseY - mouseY) * 0.01;

  //headAngle = headAngle + 0.01;

  strafeDir = xzDirection.copy();
  strafeDir.rotate(PI/2);

  if (up) {
    lx = lx + xzDirection.x;
    lz = lz + xzDirection.y;
  }
  if (down) {
    lx = lx - xzDirection.x;
    lz = lz - xzDirection.y;


  }
  if (left) {
    lx = lx -strafeDir.x; 
    lz = lz - strafeDir.y;
  }
  if (right) {
    lx = lx +strafeDir.x; 
    lz = lz + strafeDir.y;
  }
  //if (space) {
  //  ly = ly - 20;
  //}
  //pushMatrix();
  //rotateX(rotx);
  //rotateY(roty);
  drawMap();
  drawFloor();
  drawBullets();
  drawSnow();
  //bullets.add(new Bullet(lx, ly, lz, direction.x, direction.y));
  //popMatrix();
}


void drawSnow() { 
  int s = 0;
  snowflakes.add(new Snow());
  snowflakes.add(new Snow());
  snowflakes.add(new Snow());
    snowflakes.add(new Snow());
  while (s < snowflakes.size()) {
    Snow flake = snowflakes.get(s);
    flake.act();
    flake.show();

if (flake.lives == 0) snowflakes.remove(s);
    else s++;
  }
}


void drawBullets() {
  int i =0;
  while (i < bullets.size()) { 
    Bullet b = bullets.get(i);
    b.act();
    b.show();
    i++;
  }
  if (mousePressed) {
    bullets.add(new Bullet(lx, ly, lz, xzDirection.x, xzDirection.y));
  }
}
void drawFloor() {
  int x =0;
  int y = height/2 + bs/2;
  stroke(100);
  strokeWeight(1);
  while (x< map.width*bs) {
    line(x, y, 0, x, y, map.width*bs);
    x=x+ bs;
  }
  int z= 0;
  while (z < map.height*bs) {
    line (0, y, z, map.width*bs, y, z);
    z= z+ bs;
  }
  noStroke();
}

void drawMap() {


  int mapX = 0, mapY= 0;
  int worldX = 0, worldZ = 0;

  while (mapY < map.height) {
    //read in a pixel
    color pixel =  map.get(mapX, mapY);

    worldX = mapX*bs;
    worldZ = mapY*bs;

    if (pixel == black) {
      texturedBox(dT, dS, dB, worldX, height/2, worldZ, bs/2);
    }

    mapX++;
    if (mapX > map.width) {
      mapX = 0; 
      mapY++;
    }
  }
}


void texturedBox(PImage top, PImage side, PImage bottom, float x, float y, float z, float size) {
  pushMatrix();
  translate(x, y, z);
  scale(size);

  beginShape(QUADS);
  noStroke();
  texture(side);


  // +Z Front Face
  vertex(-1, -1, 1, 0, 0);
  vertex( 1, -1, 1, 1, 0);
  vertex( 1, 1, 1, 1, 1);
  vertex(-1, 1, 1, 0, 1);

  // -Z Back Face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, 1, -1, 1, 1);
  vertex(-1, 1, -1, 0, 1);

  // +X Side Face
  vertex(1, -1, 1, 0, 0);
  vertex(1, -1, -1, 1, 0);
  vertex(1, 1, -1, 1, 1);
  vertex(1, 1, 1, 0, 1);

  // -X Side Face
  vertex(-1, -1, 1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(-1, 1, -1, 1, 1);
  vertex(-1, 1, 1, 0, 1);

  endShape();

  beginShape();
  texture(bottom);

  // +Y Bottom Face
  vertex(-1, 1, -1, 0, 0);
  vertex( 1, 1, -1, 1, 0);
  vertex( 1, 1, 1, 1, 1);
  vertex(-1, 1, 1, 0, 1);

  endShape();

  beginShape();
  texture(top);

  // -Y Top Face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, -1, 1, 1, 1);
  vertex(-1, -1, 1, 0, 1);

  endShape();

  popMatrix();
}

void keyPressed() {
  if (key == 'W' || key == 'w' ) up = true;
  if (key == 'S' || key == 's' ) down = true;
  if (key == 'A' || key == 'a' ) left = true;
  if (key == 'D' || key == 'd' ) right = true;
  if (key == ' ') space = true;
}

void keyReleased() {
  if (key == 'W' || key == 'w' ) up = false;
  if (key == 'S' || key == 's' ) down = false;
  if (key == 'A' || key == 'a' ) left = false;
  if (key == 'D' || key == 'd' ) right = false;
  if (key == ' ' ) space = false;
}

void mouseDragged() {

  //rotx = rotx + (pmouseY - mouseY) *0.01; 
  //roty= roty + (pmouseX - mouseX) * 0.01;
}
