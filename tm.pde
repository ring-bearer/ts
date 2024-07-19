class tm{
  int x=30,y;
  int h=60;
  int tilew=50;
  int head=0;
  String content="";
  
  tm(int y){
    this.y=y;
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
    drawHead(head);
    input(content);
  }
  
  void input(String s){
    content=s;
    fill(0);
    textSize(50);
    textAlign(CENTER);
    for(int i=0;i<s.length();i++){
      text(content.charAt(i),x+i*tilew+tilew/2,y+h-10);
    }
  }    

  char readChar(char c, int dir){
    char r;
    if(head>=content.length()) r=' ';
    else r=content.charAt(head);
    if(r==c){
      if(dir>=0){
      head++;
      }
      else{
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
    if(head>=content.length()) r=' ';
    else r=content.charAt(head);
    
    if(dir>=0){
      head++;
    }
    else{
      head--;
      if(head<0) head=0;
    }
    
    if(head>10){
      if(dir>=0)
        x=x-tilew;
      else
        x=x+tilew;
    }
    else
      x=30;
    
    update();
    return r;
  }
  
  void write(char c, int dir){
    int len=content.length();
    String s1,s2;
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
    
    if(dir>=0){
      head++;
    }
    else{
      head--;
      if(head<0) head=0;
    }
    
    if(head>10){
      if(dir>=0)
        x=x-tilew;
      else
        x=x+tilew;
    }
    else
      x=30;
    
    update();
  }
  
  String readAll(){
    char r;
    if(millis()-lastTime>time){
      r=read(1);
      lastTime=millis();
    }
    return content;
  }
  
  void update(){
    drawTape();
    drawHead(head);
    input(content);
  }
}
