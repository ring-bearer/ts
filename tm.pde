class machine{
  tm[] tapes;
  int state;
  String[][][] delta;
  
  machine(tm[] tapes, String[][][] delta){
    this.tapes=tapes;
    this.delta=delta;
  }
  
  void update(){
    for(int i=0;i<tapes.length;i++){
      tapes[i].update();
    }
  }
  
  void start(){
    state=0;
    for(int i=0;i<tapes.length;i++){
      tapes[i].start();
    }
  }
  
  boolean returnAllToStart(){
    for(int i=0;i<tapes.length;i++){
      if(!tapes[i].returnToStart()) return false;
    }
    state=0;
    return true;
  }
  
  boolean returnToStart(tm tape){
    return tape.returnToStart();
  }
  
  void input(String[] s, tm tape){
    tape.input(s);
  }
  
  void write(String c, int dir, tm tape){
    tape.write(c,dir);
  }
  
  String read(int dir, tm tape){
    return tape.read(dir);
  }
  
  String[] readAll(tm tape){
    return tape.readAll();
  }
  
  int getDio(String[] adresa){
    String c=fourth.read(1);
      dio=append(dio,c);
      println("dio=");
      println(dio);
    
    if(java.util.Arrays.equals(dio,adresa)){
      println("dio i adr isti");
      return 1;
    }
    else{
      return 0;
    }
  }
  
  boolean check(int adr){
    
    String[][] confs=delta[adr];
    for(int i=0;i<confs.length;i++){
      if(confs[i]==null) continue;
      println(i + " u ");
      println(confs[i]);
      if(!tapes[i].check(confs[i])) return false;
    }
    
    return true;
  }
  
  void work(int adr){
    
    String[][] confs=delta[adr];
    int confsHelp;
    for(int i=0;i<confs.length;i++){
      if(confs[i]==null){
        continue;
      }
      confsHelp=Integer.parseInt(confs[i][2]);
      tapes[i].state=confsHelp;
      state=confsHelp;
      confsHelp=Integer.parseInt(confs[i][4]);
      tapes[i].write(confs[i][3],confsHelp);
      println("pis");
    }
    for(int i=0;i<confs.length;i++){
      tapes[i].state=state;
    }
  }
}

class tm{
  int x=30,y;
  int h=60;
  int tilew=50;
  int head=0;
  int state=0;
  String[] alphabet;
  String[][] delta;
  String[] content={};
  
  tm(int y, String[] alph, String[][] delta){
    this.y=y;
    alphabet=alph;
    this.delta=delta;
  }
  
  boolean check(String[] conf){
    String stateChar=Integer.toString(state);
    println("statechar je " + stateChar);
    if(!stateChar.equals(conf[0])){
      println("vracam");
      return false;
    }
    String t=read(1);
    read(-1);
    if(!t.equals(conf[1])){
      return false;
    }
    println(t);
    return true;
  }
  
  int work(){
    if(millis()-lastTime<time) return state;
    if(state==-1 || state==-2) return state;
    
    boolean change=false;
    for(int i=0;i<delta.length;i++){
      String reading;
      if(head>=content.length) reading=" ";
      else reading=content[head];
      if(delta[i][0]==Integer.toString(state) && delta[i][1].equals(reading)){
        state=Integer.parseInt(delta[i][2]);
        write(delta[i][3],Integer.parseInt(delta[i][4]));
        change=true;
        break;
      }
    }
    
    if(!change)
      state=-2;
    
    lastTime=millis();
    return state;
  }
  
  void drawHead(int pos){
    fill(255);
    triangle(x+5+tilew*pos, y+h+20, x+tilew-5+tilew*pos, y+h+20, x+tilew/2+tilew*pos, y+h+5);
  }
  
  void drawTape(){
    fill(200);
    noStroke();
    rect(0,y,width,h+30);
    fill(255);
    stroke(0);
    for(int i=0;i+x<=width;i+=tilew){
      rect(x+i,y,tilew,h);
    }
  }
  
  void start(){
    drawTape();
    head=0;
    state=0;
    drawHead(head);
    input(content);
  }
  
  void input(String[] s){
    content=s;
    fill(0);
    textSize(45);
    textAlign(CENTER);
    for(int i=0;i<s.length;i++){
      text(content[i],x+i*tilew+tilew/2,y+h-10);
    }
  }    

  String readChar(String c, int dir){
    String r;
    if(head>=content.length) r=" ";
    else r=content[head];
    if(r.equals(c)){
      if(dir==1){
      head++;
      }
      else if (dir<=0){
        head--;
        if(head<0) head=0;
      }
      
      redraw();
      return r;
    }
    else{
      return " ";
    }
  }

  String read(int dir){
      String r;
      if(head>=content.length) r=" ";
      else r=content[head];
      println("r je " + r);
      
      if(dir==1){
        head++;
      }
      else if (dir<=0){
        head--;
        if(head<0) head=0;
      }
      
      if(head>10){
        if(dir==1)
          x=x-tilew;
        else if (dir<=0)
          x=x+tilew;
      }
      else
        x=30;
     
      redraw();
      return r;
  }
  
  void write(String c, int dir){
    if(head>=content.length){
       for(int i=content.length;i<=head;i++){
         content=append(content," ");
       }
    }
    content[head]=c;
    println(content[head]);
     /* String s1,s2;
      if(head>len){
        s1=content;
        for(int i=len;i<head;i++){
          s1=s1+' ';
        }
        s2="";
      }
      else{
        s1=content.substring(0,head);
        if(head+1<=len)
          s2=content.substring(head+1);
        else
          s2="";
      }
      String novi=s1+c+s2;
      println(novi);
      for(int i=novi.length();i>=1;){
        println(i);
        if(novi.charAt(i-1)==' '){
          novi=novi.substring(0,i-1);
          i=novi.length();
        }
        else break;
      }
      content=novi;
      */
      if(dir==1){
        head++;
      }
      else if (dir<=0){
        head--;
        if(head<0) head=0;
      }
      
      if(head>10){
        if(dir==1)
          x=x-tilew;
        else if (dir<=0)
          x=x+tilew;
      }
      else
        x=30;
        
      println("head je " + head);
            
      redraw();
  }
  
  boolean goToEnd(){
    frameRate(2);
    if(head==content.length){
      frameRate(1);
      return true;
    }
    read(1);
    return false;
  }
  
  boolean returnToStart(){    
    frameRate(2);
    
    if(head==0){
      frameRate(1);
      state=0;
      return true;
    }
    
    read(-1);
    return false;
  }
  
  String[] readAll(){
     if(l>=content.length){
          key=RIGHT;
          l=0;
          println("tempread je ");
          println(tempRead);
          return tempRead;
        }
        if(head>0 && l==0){
          returnToStart();
          return null;
        }
        else{
              String c=read(1);
              println(c);
              tempRead=append(tempRead,c);
              l++;
     }
     return tempRead;
   /* r=read(l);
    if(r=='0') return " ";
    else l++;
      if(l==content.length()) {
        key=RIGHT;
        l=0;
      }*/
  }
  
  void update(){
    drawTape();
    drawHead(head);
    input(content);
    return;
  }
}
