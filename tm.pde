class machine{
  tm[] tapes;
  int state;
  
  machine(tm[] tapes){
    this.tapes=tapes;
  }
  
  void start(){
    state=0;
    for(int i=0;i<tapes.length;i++){
      tapes[i].start();
    }
  }
  
  void input(char[] s){
    tapes[0].input(s);
  }
  
  void write(char c, int dir, tm tape){
    tape.write(c,dir);
  }
  
  char[] readAll(tm tape){
    return tape.readAll();
  }
  
  int work(){
    for(int i=0;i<tapes.length;i++){
      
    }
    return state;
  }
}

class tm{
  int x=30,y;
  int h=60;
  int tilew=50;
  int head=0;
  int state=0;
  char[] alphabet;
  char[][] delta;
  char[] content={};
  
  tm(int y, char[] alph, char[][] delta){
    this.y=y;
    alphabet=alph;
    this.delta=delta;
  }
  
  int worknd(){
    if(millis()-lastTime<time) return state;
    if(state==-1 || state==-2) return state;
    
    boolean change=false;
    for(int i=0;i<delta.length;i++){
      char reading;
      if(head>=content.length) reading=' ';
      else reading=content[head];
      if(delta[i][0]==state && delta[i][1]==reading){
        if(delta[i][2]=='t') state=-1;
        else if (delta[i][2]=='f') state=-2;
        else state=delta[i][2];
        write(delta[i][3],delta[i][4]);
        change=true;
        break;
      }
    }
    
    if(!change)
      state=-2;
    
    lastTime=millis();
    return state;
  }
  
  int work(){
    if(millis()-lastTime<time) return state;
    if(state==-1 || state==-2) return state;
    
    boolean change=false;
    for(int i=0;i<delta.length;i++){
      char reading;
      if(head>=content.length) reading=' ';
      else reading=content[head];
      if(delta[i][0]==state && delta[i][1]==reading){
        if(delta[i][2]=='t') state=-1;
        else if (delta[i][2]=='f') state=-2;
        else state=delta[i][2];
        write(delta[i][3],delta[i][4]);
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
  
  void input(char[] s){
    content=s;
    fill(0);
    textSize(50);
    textAlign(CENTER);
    for(int i=0;i<s.length;i++){
      text(content[i],x+i*tilew+tilew/2,y+h-10);
    }
  }    

  char readChar(char c, int dir){
    char r;
    if(head>=content.length) r=' ';
    else r=content[head];
    if(r==c){
      if(dir==1){
      head++;
      }
      else if (dir<=0){
        head--;
        if(head<0) head=0;
      }
      
      update();
      return r;
    }
    else{
      return ' ';
    }
  }

  char read(int dir){
      char r;
      if(head>=content.length) r=' ';
      else r=content[head];
      
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
     
      update();
      return r;
  }
  
  void write(char c, int dir){
    if(head>=content.length){
       for(int i=content.length;i<=head;i++){
         content=append(content,' ');
       }
    }
    content[head]=c;
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
            
      update();
  }
  
  char[] readAll(){
    char[] r={};
    if(millis()-lastTime>time){
        if(l>=content.length){
          key=RIGHT;
          l=0;
          return r;
        }
        if(head>0){
          read(-1);
          lastTime=millis();
        }
        else{
          char c=read(1);
          r=append(tempRead,c);
          lastTime=millis();
          l++;
        }
      }
     return r;
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
  }
}
