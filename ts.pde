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
{'0','a','4','a','1'},
{'0','a','1','a','1'},
{'0','b','5','b','1'},
{'0','b','1','b','1'},
{'1','a','2','a','1'},
{'1','b','3','b','1'}
};
char[][] deltaTape2={
{'0',' ','1',' ','2'},
{'1',' ','t',' ','1'},
{'2','a','1',' ','0'},
{'3','b','1',' ','0'},
{'4',' ','0','a','1'},
{'5',' ','0','b','1'}
};
char[][][] d={
 {deltaTape1[1],deltaTape2[0]},
 {deltaTape1[3],deltaTape2[0]},
 {deltaTape1[0],null},
 {deltaTape1[2],null},
 {deltaTape1[4],null},
 {deltaTape1[5],null},
 {null,deltaTape2[1]},
 {null,deltaTape2[2]},
 {null,deltaTape2[3]},
 {null,deltaTape2[4]},
 {null,deltaTape2[5]},
};

int b=d.length;
machine stroj;
tm first,second,third,fourth;


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

String input="abba";
char[] adresa;
boolean odbijeno;
boolean gotovo=false;

int time=1000;
int lastTime,lastTimeKod;
boolean lastPressed=false;
boolean lastMousePressed=false;
//tm stroj2=new tm(130,al,delta);
int l=0;
int korak=1;
int state=0;
char[] tempRead={};
char[] dio={};
char[] readT3={};
char[] empty={};
char temp;
boolean help=true;

void setup() {
char[] address={'X','#'};
  for(int i=0;i<10;i++){
    char j=Integer.toString(i).charAt(0);
    address=append(address,j);
  }
  address=append(address,'A');
  println(address);
  
  first=new tm(30,al,deltaTape1);
  second=new tm(150,al,deltaTape2);
  third=new tm(270,address,null);
  fourth=new tm(390,address,null);
  tm[] tapes={first,second,third,fourth};
  stroj=new machine(tapes,d);
  frameRate(1);
  size(640, 640);
  background(200);
  stroj.start();
  //stroj2.start();
  lastTime=millis();
  lastTimeKod=millis();
}

void draw() {
  stroj.update();
  
  if(lastPressed){
    keyPressed();
  }
 /* if ((keyPressed && !lastPressed)|| key==ENTER)
      press();
  lastPressed = keyPressed;
  if (mousePressed){
    mousePressed=false;
    lastMousePressed=true;
  }
  if (lastMousePressed){
    kod();
  }*/
}

void keyPressed(){
  lastPressed=true;
  if(keyCode==RIGHT){
    kod();
  }
  if(keyCode==LEFT){
    korak-=2;
    kod();
  }
}

void kod(){
  if(korak==1){
    char[] inp=input.toCharArray();
    stroj.input(inp,first);
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
     
      stroj.write('0',1,fourth);
    
      //char[] adr={'1','#','2','#','1','1','#'};
      //stroj.input(adr,third);
    }
    if(korak==4){
      adresa=stroj.readAll(fourth);
      if(adresa==null || l<fourth.content.length){
          return;
      }
      println("adresa=");
      println(adresa);
    }
  if(korak==5){
    odbijeno=true;
    println("odbijeno=" + odbijeno);
  }
  if(korak==6){
    if (!stroj.returnToStart(fourth)) return;
    if (!stroj.returnToStart(third)) return;
  }
  if(korak==7){
    int getDio=stroj.getDio(adresa);
    if (getDio==0){
      korak++;
      return;
    }
    else{
      dio=empty;
      if(gotovo){
        korak=11;
      }
      else{
        korak+=2;
      }
    }
  }
  if(korak==8){  
    if(help){
      temp=stroj.read(1,third);
      if(temp==' '){
        korak++;
        return;
      }
      readT3=append(readT3,temp);
      println(readT3);
      if(readT3[readT3.length-1]==dio[readT3.length-1]){
        help=true;
        if(java.util.Arrays.equals(dio,readT3)){
          help=false;
          temp=stroj.read(1,third);
          if(temp=='X'){
            gotovo=true;
            korak--;
            return;
          }
          else{
            korak--;
            println(gotovo);
          }
        }
      }
      else{
        help=false;
      }
      return;
    }
    else{
        if(temp!='#'){
          temp=stroj.read(1,third);
        }
        else{
          readT3=empty;
          help=true;
          println(readT3);
        }
    }
    korak--;
  }
  if(korak==9){
    println(korak);
    if (!stroj.returnToStart(fourth)) return;
  }
  if(korak==10){
    temp=stroj.read(1,fourth);
    if(temp!=' '){
      int intTemp=temp-'0';
      println(intTemp);
      if(stroj.check(intTemp)) stroj.work(intTemp);
      return;
    }
  }
  if(korak==11){
    for(int i=0;i<adresa.length;i++)
      stroj.write(adresa[i],1,third);
    if(stroj.state=='f')
      stroj.write('X',1,third);
    stroj.write('#',1,third);
  }
  if(korak==12){
    if(stroj.state=='t'){
      println("accept");
      exit();
    }
  }
  if(korak==13){
    temp=stroj.read(-1,fourth);
    if(temp==' ') return;      
    int intTemp=temp-'0';
    char charTemp;
    if(fourth.head!=0) stroj.read(1,fourth);
    if(intTemp<b){
      intTemp++;
      charTemp=Integer.toString(intTemp).charAt(0);
      stroj.write(charTemp,-1,fourth);
      println(fourth.content);
      tempRead=empty;
      korak=4;
      return;
    }
    else{
      charTemp=Integer.toString(0).charAt(0);
      stroj.write(charTemp,-1,fourth);
      if(fourth.head==0){
        fourth.goToEnd();
        stroj.write('0',1,fourth);
        korak=4;
        tempRead=empty;
        return;
      }
    }
  }
  
    //lastPressed=false;
  korak++;
  return;
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
