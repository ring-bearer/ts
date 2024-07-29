//is it checking for each dio is it done
//also gets stuck at 000??


//char none=Character.MIN_VALUE;

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

String[] al={"a","b"};
String[][] deltaTape1={
{"0","a","1","a","1"},
{"0","b","1","b","1"},
{"1","a","2","a","1"},
{"1","b","3","b","1"},
{"0","a","4","a","1"},
{"0","b","5","b","1"},
};
String[][] deltaTape2={
{"0"," ","1"," ","2"},
{"2","a","1"," ","0"},
{"3","b","1"," ","0"},
{"1"," ","-1"," ","1"},
{"4"," ","0","a","1"},
{"5"," ","0","b","1"}
};
String[][][] d={
 {deltaTape1[0],deltaTape2[0]},
 {deltaTape1[1],deltaTape2[0]},
 {deltaTape1[2],null},
 {deltaTape1[3],null},
 {null,deltaTape2[1]},
 {null,deltaTape2[2]},
 {null,deltaTape2[3]},
 {deltaTape1[4],null},
 {deltaTape1[5],null},
 {null,deltaTape2[4]},
 {null,deltaTape2[5]},
};

int b=2;
machine stroj;
tm first,second,third,fourth;



String[] input={"a","b","b","a"};
String[] adresa;
boolean odbijeno;
boolean gotovo=false;

int time=1000;
int lastTime,lastTimeKod;
boolean lastPressed=false;
boolean lastMousePressed=false;
int l=0;
int korak=1;
int state=0;
String[] tempRead={};
String[] dio={};
String[] readT3={};
String[] empty={};
String temp;
boolean help=true;

void setup() {
String[] address={"X","#"};
  for(int i=0;i<11;i++){
    String j=Integer.toString(i);
    address=append(address,j);
  }
  println(address);
  
println(b);
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
    kod();
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
  if(keyCode==ENTER){
    lastPressed=true;
    kod();
  }
  if(keyCode==TAB){
    lastPressed=false;
  }
  if(keyCode==LEFT){
    korak-=2;
    kod();
  }
  if(keyCode==RIGHT){
    kod();
  }
  if(key=='a'){
    time=500;
  }
  if(key=='s'){
    time=1000; 
  }
}

void kod(){
  if(korak==1){
    stroj.input(input,first);
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
     
      stroj.write("0",1,fourth);
    
      //char[] adr={'1','#','2','#','1','1','#'};
      //stroj.input(adr,third);
    }
    if(korak==4){
      adresa=stroj.readAll(fourth);
      if(l!=0 || adresa==null){
        return;
      }
      println("adresa=");
      println(adresa);
      println("l je " + l);
    }
  if(korak==5){
    odbijeno=true;
    println("odbijeno=" + odbijeno);
    gotovo=false;
  }
  if(korak==6){
    if(!stroj.returnAllToStart()) return;
    /*if (!stroj.returnToStart(first)) return;
    if (!stroj.returnToStart(second)) return;
    if (!stroj.returnToStart(third)) return;
    if (!stroj.returnToStart(fourth)) return;*/
  }
  if(korak==7){
    if(gotovo){
      third.goToEnd();
      dio=empty;
      korak=12;
      return;
    }
    int getDio=stroj.getDio(adresa);
    if (getDio==0){
      korak++;
      return;
    }
    else{
      dio=empty;
      third.goToEnd();
      /*if(gotovo){
         korak=12;
      }
      else{*/
        korak+=2;
      //}
    }
  }
  if(korak==8){
    println("help je " + help);
    temp=stroj.read(1,third);
    if(help){
      if(temp==" "){
        println("temp je nista");
        stroj.read(-1,third);
        korak--;
        return;
      }
      readT3=append(readT3,temp);
      println("readt3 je ");
      println(readT3);
      if(readT3[readT3.length-1].equals(dio[readT3.length-1])){
        help=true;
        if(java.util.Arrays.equals(dio,readT3)){
          help=false;
          temp=stroj.read(1,third);
          if(temp=="X"){
            gotovo=true;
            korak--;
            return;
          }
          else{
            println(gotovo);
          }
        }
      }
      else{
        help=false;
      }
      //return;
    }
    if(!help){
        if(!temp.equals("#")){
          println("nije #");
        }
        else{
          println("je #");
          readT3=empty;
          help=true;
        }
    }
    korak--;
  }
  if(korak==9){
    if (!stroj.returnToStart(fourth)) return;
  }
  if(korak==10){
    temp=stroj.read(1,fourth);
    if(!temp.equals(" ")){
      int intTemp=Integer.parseInt(temp);
      println(intTemp);
      if(stroj.check(intTemp)){ 
        stroj.work(intTemp);
      }
      else{
        stroj.state=-2;
        korak++;
      }
      return;
    }
  }
  if(korak==11){
    println("adresa je ");
    println(adresa);
    for(int i=0;i<adresa.length;i++)
      stroj.write(adresa[i],1,third);
    if(stroj.state==-2)
      stroj.write("X",1,third);
    stroj.write("#",1,third);
  }
  if(korak==12){
    if(stroj.state==-1){
      println("accept");
      exit();
    }
  }
  if(korak==13){
    int intTemp;
    String charTemp;
    if(fourth.head!=0){
      temp=stroj.read(-1,fourth);
      if(temp==" ") return;      
      intTemp=Integer.parseInt(temp);
      stroj.read(1,fourth);
    }
    else{
      temp=stroj.read(-1,fourth);
      if(temp==" ") return;      
      intTemp=Integer.parseInt(temp);
    }
    if(intTemp<b-1){
      println("manji od b");
      intTemp++;
      charTemp=Integer.toString(intTemp);
      stroj.write(charTemp,-1,fourth);
      tempRead=empty;
      korak=4;
      return;
    }
    else{
      println("veci od b");
      charTemp=Integer.toString(0);
      println(charTemp);
      stroj.write(charTemp,-1,fourth);
      if(fourth.head==0){
        fourth.goToEnd();
        stroj.write("0",1,fourth);
        korak=4;
        tempRead=empty;
        return;
      }
      return;
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
