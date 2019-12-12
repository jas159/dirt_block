class Snow {
  float x, y, z, vx,vy, vz, lives;
  int s;
  Snow() { 
    x = random(0,5000);
    y = -1500;
   z = random(0,5000);
   s = 10;
   vy = 3; 
   lives = 1;
  }

  void show() {
    pushMatrix();
    translate(x, y, z);
    fill(255);
    box(s);
    popMatrix();
    if ( y > height/2) {
     lives = 0; 
    }
  }

  void act() {

y += vy;
  }
  
}
