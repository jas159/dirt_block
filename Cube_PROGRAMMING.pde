//textures
PImage qblock,dirt_top, dirt_side, dirt_bottom;

//maps
PImage map;

float rotx = PI/4, roty = PI/4;
int blockSize = 10;
//pallate 
color black = #000000;
color white = #FFFFFF;
void setup() {
  size(800, 600, P3D);
  qblock = loadImage("block.png");
  dirt_top    = loadImage("dirt_top.png");
  dirt_side   = loadImage("dirt_side.jpg");
  dirt_bottom = loadImage("dirt_bottom.jpg");
  textureMode(NORMAL);
}

void draw() {
  background(255);

  drawMap();
  drawGround();

  texturedBox(dirt_top, dirt_side, dirt_bottom, x, height/2+200, z, 50);
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
  vertex( -1, -1, -1, 0, 0);
  vertex(  1, -1, -1, 1, 0);
  vertex(  1, 1, -1, 1, 1);
  vertex( -1, 1, -1, 0, 1);

  // Top Face -Y
  vertex( -1, -1, -1, 0, 0);
  vertex(  1, -1, -1, 1, 0);
  vertex(  1, -1, 1, 1, 1);
  vertex( -1, -1, 1, 0, 1);

  //bottom face +Y
  vertex(-1, 1, -1, 0, 0);
  vertex(  1, 1, -1, 1, 0);
  vertex(  1, 1, 1, 1, 1);
  vertex( -1, 1, 1, 0, 1);

  //side face -X
  vertex( 1, -1, -1, 0, 0);
  vertex( 1, 1, -1, 1, 0);
  vertex( 1, 1, 1, 1, 1);
  vertex( 1, -1, 1, 0, 1);

  //side face +X
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, 1, -1, 1, 0);
  vertex(-1, 1, 1, 1, 1);
  vertex(-1, -1, 1, 0, 1);

  endShape();

  popMatrix();
}


void drawMap() {
  pushMatrix();

  rotateX(rotx);
  rotateY(roty);

  int mapX = 0, mapY= 0;
  int worldX = 0, worldY = height/2, worldZ = 0;

  while (mapY < map.height) {
    color pixel =  map.get(mapX, mapY);
    if (pixel == black) {
      worldX = mapX*blockSize;
      worldY = mapY*blockSize;
      texturedBox(worldX, worldY, worldZ, blockSize);
    }

    mapX++;
    if (mapX > map.width) {
      mapX = 0;
      mapY++;
    }
    popMatrix();
  }
}

void drawGround() {
}
void mouseDragged() {
  rotx = rotx + (pmouseY - mouseY) *0.01; 
  roty= roty + (pmouseX - mouseX) * 0.01;
}
