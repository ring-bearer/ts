long time=1000;
int lastTime;
boolean lastPressed=false;
tm stroj=new tm(30);
//tm stroj2=new tm(130);
int l=0;


void setup() {
  size(640, 640);
  background(200);
  stroj.start();
  //stroj2.start();
  stroj.input("gombi");
  lastTime=millis();
}

void draw() {
  if ((keyPressed && !lastPressed)|| key==ENTER)
      press();
  lastPressed = keyPressed;
}

void press() {
  if (keyCode==RIGHT) {
    stroj.read(1);
  }
  else if (keyCode==LEFT) {
    stroj.read(-1);
  }
  else if(key==ENTER){
   char r;
      if(millis()-lastTime>time){
        r=stroj.read(1);
        lastTime=millis();
        l++;
        if(l==stroj.content.length()) {
          key=RIGHT;
          l=0;
        }
      }
  }
  else if(key=='0'){
    stroj.start();
  }
  else if(key==BACKSPACE){
    stroj.write(' ',-1);
  }
  else{
    stroj.write(key,1);
  }
}
