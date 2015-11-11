import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress sc;
float amp1 = 0.0;
float d =20.0;
float e = 5.0;


void setup() {
  size(500, 500);
  osc = new OscP5(this, 12321);
  sc = new NetAddress("127.0.0.1", 57120);
  osc.plug(this, "ampin", "/amp1");
}

void draw() {
  background(0);
 stroke(255, 0, 255);
 fill(0,255,0);
 ellipse(width/2, height/2, d, e);
}

void ampin(float aamp) {
 d = map(aamp, 0.0, 1.0, 20.0, width);
 e = map(aamp, 0.0, 1.0, 50.0, 200);
 
}