//content myb char[] inst string??

char[] al={'a','b'};
char[][] delta={
{0,'a',7,'a',2},
{0,'b',7,'b',2},
{7,'a',1,' ',1},
{7,'b',4,' ',1},
{7,' ','t',' ',1},
{1,'a',1,'a',1},
{1,'b',1,'b',1},
{1,' ',2,' ',0},
{2,'a',3,' ',0},
{3,'a',3,'a',0},
{3,'b',3,'b',0},
{3,' ',7,' ',1},
{4,'a',4,'a',1},
{4,'b',4,'b',1},
{4,' ',5,' ',0},
{5,'b',6,' ',0},
{6,'a',6,'a',0},
{6,'b',6,'b',0},
{6,' ',7,' ',1},
};

char[] al2={'0','1','2'};
char[][] delta2={
  {0,'0',1,'A',1},
  {0,'B',4,'B',1},
  {1,'B',1,'B',1},
  {1,'0',1,'0',1},
  {1,'1',2,'B',1},
  {2,'C',2,'C',1},
  {2,'1',2,'1',1},
  {2,'2',3,'C',0},
  {3,'1',3,'1',0},
  {3,'0',3,'0',0},
  {3,'B',3,'B',0},
  {3,'C',3,'C',0},
  {3,'A',0,'A',1},
  {4,'B',4,'B',1},
  {4,'C',4,'C',1},
  {4,' ','t',' ',1},
};

tm stroj=new tm(30,al2,delta2);

long time=1000;
int lastTime;
boolean lastPressed=false;
boolean lastMousePressed=false;
//tm stroj2=new tm(130,al,delta);
int l=0;
int korak=1;
int state=0;

void setup() {
  size(640, 640);
  background(200);
  stroj.start();
  //stroj2.start();
  stroj.input("abba");
  lastTime=millis();
}

void draw() {
  if ((keyPressed && !lastPressed)|| key==ENTER)
      press();
  lastPressed = keyPressed;
  if (mousePressed){
    mousePressed=false;
    lastMousePressed=true;
  }
  if (lastMousePressed){
    state=stroj.work();
    if(state==-1){
      fill(200);
      noStroke();
      rect(0,150,width,height);
      lastMousePressed=false;
      fill(0);
      text("accept",100,200);
      stroj.state=0;
    }
    if(state==-2){
      fill(200);
      noStroke();
      rect(0,150,width,height);
      lastMousePressed=false;
      fill(0);
      text("reject",100,200);
      stroj.state=0;
    }
  }
}

void kod(){
  //if(millis()-lastTime<time) return;
  
  /*if(korak==1){
    stroj.write('a',1);
  }
  if(korak==2){
    stroj.write('b',1);
  }
  if(korak==3){
    stroj.write('c',1);
    lastMousePressed=false;
  }
  lastTime=millis();
  korak++;
  /*if(millis()-lastTime>time){
    stroj.write('c',1);
    lastTime=millis();
    lastMousePressed=false;
  }*/
}

void press() {
  if (keyCode==RIGHT) {
    stroj.read(1);
  }
  else if (keyCode==LEFT) {
    stroj.read(-1);
  }
  else if(key==ENTER){
   stroj.readAll();
  }
  else if(key==TAB){
    stroj.start();
  }
  else if(key==BACKSPACE){
    stroj.write(' ',-1);
  }
  else{
    stroj.write(key,1);
  }
}
