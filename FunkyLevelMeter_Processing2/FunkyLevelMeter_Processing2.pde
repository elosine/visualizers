import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress sc;


PFont liGothicMed20, liGothicMed14;
int rotateSpdX = 2;
int rotateSpdY = 3;
int rotateSpdZ = 2;
color mainShellClr = color(100, 100, 100, 70);
color mainSpriteClr = color(0, 255, 0);
color mainSpriteStrokeWt = 1;
int vtxsMainSize = 333;
Float [] vtxsMain;
float mainSpriteAmpMin = 0.0;
float mainSpriteAmpMax = 1.0;
float azi= -HALF_PI;
int rx = 0;
int ry = 0;
int rz = 0;
int x = width/2;
int y = height/2;
float r = 100.0;
String label = "";

void setup() {
  size(500, 500, P3D);
  osc = new OscP5(this, 12321);
  sc = new NetAddress("127.0.0.1", 57120);
  osc.plug(this, "aniSpriteMain", "/amp1");
  liGothicMed20 = loadFont("LiGothicMed-20.vlw");
  liGothicMed14 = loadFont("LiGothicMed-14.vlw");
  vtxsMain = new Float [vtxsMainSize];
  aniSpriteMain(-7.0);
  x = width/2;
  y = height/2;
}

void draw() {
  background(50, 58, 72);
  //Get Amp
  osc.send("/getamp", new Object[]{}, sc);
  //draw shell
  pushMatrix();
  //scale(1, 1, 0.1);
  translate(x, y);
  noFill();    
  stroke(mainShellClr);
  strokeWeight(1);
  if ( (frameCount%rotateSpdX)==0 ) rx=(rx+1)%360;
  rotateX(radians(rx));
  if ( (frameCount%rotateSpdY)==0 ) ry=(ry+1)%360;
  rotateY(radians(ry));
  if ( (frameCount%rotateSpdZ)==0 ) rz=(rz+1)%360;
  rotateY(radians(rz));

  sphere(r);
  //write channel number
  textFont(liGothicMed20); 
  fill(255);
  text(label, (cos(-HALF_PI) * (r)), (sin(-HALF_PI) * (r)));
  text(label, (cos(0) * (r)), (sin(0) * (r))); 
  text(label, (cos(HALF_PI) * (r+14)), (sin(HALF_PI) * (r+14)));
  text(label, (cos(PI) * (r+14)), (sin(PI) * (r+14)));
  text(label, 0, 0, r+5);
  text(label, 0, 0, -r-5); 
  popMatrix();

  //draw sound sprite
  pushMatrix();
  // scale(1, 1, 0.1);
  translate(x, y, -r/2);
  rotateY(PI*0.3);
  rotateZ(PI*0.72);
  stroke(mainSpriteClr);
  strokeWeight(mainSpriteStrokeWt);
  noFill();
  beginShape();
  for (int i=0; i<vtxsMain.length/3; i=i+3) {
    if (vtxsMain[i] !=null && vtxsMain[i+1] !=null && vtxsMain[i+2] !=null) {
      vertex(vtxsMain[i], vtxsMain[i+1], vtxsMain[i+2]);
    }
  }
  endShape(CLOSE);
  popMatrix();
}


//CLASS METHOD (): aniSpriteMain /////////////////////////
void aniSpriteMain(float ampRaw) {
  float ampMapped = map(ampRaw, mainSpriteAmpMin, mainSpriteAmpMax, 0.0, r);
  for (int i=0; i<vtxsMain.length; i++) {
    vtxsMain[i] = constrain(ampMapped, 0.0, r) * random(0.1, 1.4);
  }
}  // end method

