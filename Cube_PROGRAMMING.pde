boolean up, down, left, right;

float lx= 0, ly =0, lz = 0;

//textures
PImage qblock, dT, dS, dB;

//maps
PImage map;

//World manipulation
float rotx = PI/4, roty = PI/4;
int bs = 100;

//pallate 
color black = #000000;
color white = #FFFFFF;

void setup() {
  size(800, 600, P3D);

  //load textures
  qblock = loadImage("block.png");
  dT    = loadImage("dirt_top.png");
  dS   = loadImage("dirt_side.jpg");
  dB = loadImage("dirt_bottom.jpg");
  textureMode(NORMAL);

  map = loadImage("map.png");
}

void draw() {
  background(255);

  camera(lx, ly, lz, 0, 0, -1, 0, 1, 0);

  if (up) lz = lz - 10;
  if (down) lz = lz + 10;

  if (left) lx = lx -10;
  if (right) lx = lx +10;
  //pushMatrix();
  //rotateX(rotx);
  //rotateY(roty);
  drawMap();
  drawFloor();
  //popMatrix();
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


void mouseDragged() {
  rotx = rotx + (pmouseY - mouseY) *0.01; 
  roty= roty + (pmouseX - mouseX) * 0.01;
}

void keyPressed() {
  if (keyCode == UP) up = true;
  if (keyCode == DOWN) down = true;
  if (keyCode == LEFT) left = true;
  if (keyCode == RIGHT) right = true;
}

void keyReleased() {
  if (keyCode == UP) up = false;
  if (keyCode == DOWN) down = false;
  if (keyCode == LEFT) left = false;
  if (keyCode == RIGHT) right = false;
}
