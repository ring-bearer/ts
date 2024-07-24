//char none=Character.MIN_VALUE;

char[] al={'a','b'};
char[][] delta={
{0,'a',7,'a',2},
{0,'b',7,'b',2},
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
{7,'a',1,' ',1},
{7,'b',4,' ',1},
{7,' ','t',' ',1},
};


char[][] deltaTape1={
{0,'a',4,'a',1},
{0,'a',1,'a',1},
{0,'b',5,'b',1},
{0,'b',1,'b',1},
{1,'a',2,'a',1},
{1,'b',3,'b',1}
};
char[][] deltaTape2={
{0,' ',1,' ',2},
{1,' ','t',' ',1},
{2,'a',1,' ',0},
{3,'b',1,' ',0},
{4,' ',0,'a',1},
{5,' ',0,'b',1}
};
int b=2;
char[] address={'1','2'};

tm first=new tm(30,al,deltaTape1);
tm second=new tm(150,al,deltaTape2);
tm third=new tm(270,address,null);
tm fourth=new tm(390,address,null);

tm[] tapes={first,second,third,fourth};
machine stroj=new machine(tapes);

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

String input="012";

long time=1000;
int lastTime,lastTimeKod;
boolean lastPressed=false;
boolean lastMousePressed=false;
//tm stroj2=new tm(130,al,delta);
int l=0;
int korak=1;
int state=0;
char[] tempRead={};

void setup() {
  size(640, 640);
  background(200);
  stroj.start();
  //stroj2.start();
  lastTime=millis();
  lastTimeKod=millis();
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
    kod();
  }
}

void kod(){
  if(millis()-lastTimeKod<time) return;
  
  if(korak==1){
    char[] inp=input.toCharArray();
    stroj.input(inp);
  }
  if(korak==2){
    if(stroj.state==-1)
      println("accept");
    else if(stroj.state==-2)
      println("reject");
    else
      println("nastavljam s radom");
  }
  if(korak==3){
    stroj.write('1',1,fourth);
  }
  if(korak==4){
    char[] adresa=stroj.readAll(fourth);
    if(adresa==null || l==0){
        lastTimeKod=millis();
        return;
    }
    String s=new String(adresa);
    println("adresa=" + s);
    lastMousePressed=false;
  }
  lastTimeKod=millis();
  korak++;
  /*if(millis()-lastTime>time){
    stroj.write('c',1);
    lastTime=millis();
    lastMousePressed=false;
  }*/
}

void press() {
   /*if (keyCode==RIGHT) {
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
  }*/
}
