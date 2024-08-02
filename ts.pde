//char none=Character.MIN_VALUE;

//a write f for multiple strs
//odradi do 0 10 i onda stane

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
{"0","a","1","a","2"},
{"0","b","1","b","2"},
{"1","a","2","a","1"},
{"1","b","3","b","1"},
{"0","a","4","a","1"},
{"0","b","5","b","1"},
{"1"," ","-1"," ","1"},
};
String[][] deltaTape2={
{"0"," ","1"," ","0"},
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
 {deltaTape1[6],deltaTape2[3]},
 {deltaTape1[4],null},
 {deltaTape1[5],null},
 {null,deltaTape2[4]},
 {null,deltaTape2[5]},
};

int b=d.length;
machine stroj;
tm first,second,third,fourth;



String[] input={"a","a"};
String[] adresa;
boolean odbijeno;
boolean gotovo=false;

//int time=1000;
//int lastTime,lastTimeKod;
boolean lastPressed=false;
//boolean lastMousePressed=false;
int l=0;
int korak=1;
int state=0;
String[] tempRead={};
String[] dio={};
String[] readT3={};
String[] empty={};
String temp;
int help=0;

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
  //lastTime=millis();
  //lastTimeKod=millis();
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
  }
  if(keyCode==TAB){
    lastPressed=false;
    frameRate(1);
  }
  if(key=='a'){
    frameRate(frameRate+10);
    println(frameRate);
  }
  if(key=='s'){
    frameRate(frameRate-4);
    println(frameRate);
  }
  if(keyCode==RIGHT){
    lastPressed=false;
    stroj.read(1,third);
  }
  if(keyCode==LEFT){
    lastPressed=false;
    stroj.read(-1,third);
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
      //String[] inp={"7","9","0","2","4","6"};
      String[] inp={"0"};
      stroj.input(inp,fourth);
      while(!stroj.returnAllToStart()){};
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
    while(!stroj.returnAllToStart()){};
    second.content=empty;
    /*if (!stroj.returnToStart(first)) return;
    if (!stroj.returnToStart(second)) return;
    if (!stroj.returnToStart(third)) return;
    if (!stroj.returnToStart(fourth)) return;*/
  }
  if(korak==7){
    if(gotovo){
      //if (!third.goToEnd()) return;
      //dio=empty;
      korak=12;
      println("gotovo! korak je ");
      println(korak);  
      return;
    }
    int getDio=stroj.getDio(adresa);
    if (getDio==0){
      korak++;
      return;
    }
    else{
      //dio=empty;
      /*if(gotovo){
         korak=12;
      }
      else{*/
        korak+=2;
      //}
    }
  }
  if(korak==8){
    int find=findAddress(adresa);
    if(find==2){
      stroj.read(-1,third);
      korak--;
      return;
    }
    else if(find==1){
      println("find je 1");
      gotovo=true;
      korak--;
      return;
    }
    else{
      println(gotovo);
      korak--;
    }
    korak--;
    
    /*
    println("help je " + help);
    temp=stroj.read(1,third);
    if(help==0){
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
        //help=1;
        if(java.util.Arrays.equals(dio,readT3)){
          help=2;
          temp=stroj.read(1,third);
          if(temp=="X"){
            gotovo=true;
            readT3=empty;
            korak--;
            help=0;
            return;
          }
          else{
            println(gotovo);
          }
        }
      }
      else{
        help=1;
      }
      //return;
    }
    if(help==1){
        if(!temp.equals("#")){
          println("nije #");
        }
        else{
          println("je #");
          readT3=empty;
          help=0;
        }
    }
    if(help==2){
        if(!temp.equals("#")){
          println("nije #");
        }
        else{
          println("je #");
          readT3=empty;
          help=0;
          korak--;
        }
    }
    korak--;*/
  }
  if(korak==9){
    while (!stroj.returnToStart(fourth)){};
    while (!third.goToEnd()){};
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
    
      //if (!stroj.returnToStart(third)) return;
  }
  if(korak==13){
    for(int i=0;i<b;i++){
      String charI=Integer.toString(i);
      String[] chars={charI};
      if(!kraj(chars)){
        odbijeno=false;
        break;
      }
    }
    if(odbijeno){
      println("reject");
      exit();
    }
   /* while(!fourth.goToEnd()){}
    println("tu");
    fourth.read(-1);
    println("procito");*/
  }
  if(korak==14){
    println("dio je ");
    println(dio);
    fourth.input(dio);
    fourth.head=fourth.content.length;
    fourth.update();
    println("proso");
    println(fourth.head);
    sljedeca(dio);
    dio=empty;
    return;
    /*
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
      if(fourth.head>=1)
        stroj.write(charTemp,-1,fourth);
      else{
        stroj.write(charTemp,-1,fourth);
        while (!fourth.goToEnd()){
        }
        stroj.write("0",1,fourth);
        korak=4;
        tempRead=empty;
        return;
      }
      return;
    }*/
  }
  
    //lastPressed=false;
  korak++;
  return;
}

void sljedeca(String[] adresa){
    int intTemp;
    int headTemp=1;
    String charTemp=" ";
    while(charTemp==" "){
      headTemp=fourth.head;
      charTemp=stroj.read(-1,fourth);
    }
    intTemp=Integer.parseInt(charTemp);
    if(headTemp!=0) stroj.read(1,fourth);
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
      if(fourth.head>=1)
        stroj.write(charTemp,-1,fourth);
      else{
        stroj.write(charTemp,-1,fourth);
        while (!fourth.goToEnd()){
        }
        stroj.write("0",1,fourth);
        korak=4;
        tempRead=empty;
        return;
      }
      return;
    }
}

boolean kraj(String[] adresa/*, int mjesto*/){
  boolean gotovo1=false;
  /*for(int i=0;i<mjesto;i++){
    stroj.read(1,third);
  }*/
  
  while (!stroj.returnToStart(third)){}
  int find=findAddress(adresa);
  if(find==1) return true;
  if(find==0){
    println("tu sam");
    //int novoMjesto=third.head;
    for(int i=0;i<b;i++){
      String charI=Integer.toString(i);
      String[] novaAdresa=append(adresa,charI);
      println(novaAdresa);
      gotovo1=kraj(novaAdresa/*,novoMjesto*/);
      if(gotovo1==false){
        println("FALSE");
        break;
      }
    }
  }
  return gotovo1;
}

int findAddress(String[] adresa){
  int help=0;
  println("help je " + help);
  while(true){
    temp=stroj.read(1,third);
    if(help==0){
      if(temp==" "){
        println("temp je nista");
        return 2;
      }
      readT3=append(readT3,temp);
      println("readt3 je ");
      println(readT3);
      if(readT3[readT3.length-1].equals(adresa[readT3.length-1])){
        if(java.util.Arrays.equals(adresa,readT3)){
          temp=stroj.read(1,third);
          readT3=empty;
          println("idek");
          if(temp=="X"){
            return 1;
          }
          else{
            println("vracam 0");
            return 0;
          }
        }
      }
      else if(readT3[readT3.length-1].equals("X")){
        readT3=empty;
        return 1;
      }
      else{
        help=1;
      }
    }
    if(help==1){
        while(!temp.equals("#")){
          println("nije #");    
          temp=stroj.read(1,third);
        }
        println("je #");
        readT3=empty;
        help=0;
    }
  }
}
