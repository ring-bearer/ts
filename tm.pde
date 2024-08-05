//klasa koja predstavlja Turingov stroj
class machine{
  tape[] tapes; //popis svih traka
  String state; //trenutno stanje
  String[][][] delta; //funkcija prijelaza
  
  //konstruktor
  machine(tape[] tapes, String[][][] delta){
    this.tapes=tapes;
    this.delta=delta;
  }
  
  //funkcija za dobivanje pocetnog dijela adrese
  //npr od "123", to su "1", "12" i "123"
  //dio s kojim se trenutno radi pamti se
  //u globalnoj varijabli dio
  void getDio(){
    //adresa je zapisana na cevrtoj traci
    String c=fourth.read(1);
    if(c.equals(" ")) return;
    dio=append(dio,c);
  }
  
  //fja koja za danu adresu prijelaza
  //provjerava moze li stroj izvrsiti prijelaz
  boolean check(int adr){
    String[][] confs=delta[adr];
    
    //provjera za svaku traku zasebno
    for(int i=0;i<confs.length;i++){
      if(confs[i]==null) continue;
      if(!tapes[i].check(confs[i])) return false;
    }
    
    return true;
  }
  
  //za svaku traku obavlja prijelaz oblika
  //(trenutnoStanje,procitaniZnak,iduceStanje,zapisaniZnak,smjer)
  //na danoj adresi
  //jasno, trenutnoStanje je jednako kod svake trake,
  //kao i iduceStanje
  void work(int adr){  
    String[][] confs=delta[adr];
    int confsHelp;
    for(int i=0;i<confs.length;i++){
      //za null se uzima da je prijelaz oblika
      //(trenutnoStanje,-,iduceStanje,-,-)
      if(confs[i]==null){
        continue;
      }
      tapes[i].state=confs[i][2]; //iduce stanje
      state=confs[i][2];
      confsHelp=Integer.parseInt(confs[i][4]);
      tapes[i].write(confs[i][3],confsHelp);
    }
    
    //potrebno za "null" trake
    for(int i=0;i<confs.length;i++){
      tapes[i].state=state;
    }
  }
  
  //fje koje pozivaju svoj ekvivalent u klasi tape
  //za danu traku, ili za sve njih
  
  void start(){
    state="0";
    for(int i=0;i<tapes.length;i++){
      tapes[i].start();
    }
  }
  
  void input(tape tape){
    tape.input();
  }
  
  void update(){
    for(int i=0;i<tapes.length;i++){
      tapes[i].update();
    }
  }
  
  String read(int dir, tape tape){
    String r=tape.read(dir);
    return r;
  }
  
  String[] readAll(tape tape){
    String r[]=tape.readAll();
    return r;
  }
  
  void write(String c, int dir, tape tape){
    tape.write(c,dir);
  }
  
  void writeAll(String c[], int dir, tape tape){
    tape.writeAll(c,dir);
  }
  
  void empty(tape tape){
    tape.empty();
  }
  
  void returnToStart(tape tape){
    tape.returnToStart();
  }
  
  void returnAllToStart(){
    for(int i=0;i<tapes.length;i++){
      tapes[i].returnToStart();
    }
    state="0";
    return;
  }
  
  void goToEnd(tape tape){
    tape.goToEnd();
  }
}

//klasa koja predstavlja jednu traku
class tape{
  //varijable za crtanje trake
  int x=30,y; //koordinate gornjeg lijevog vrha trake
  int h=60; //visina trake
  int tilew=50; //sirina jednog mjesta na traci
  
  int head=0; //pozicija glave
  String state="0"; //trenutno stanje
  String[] alphabet; //koristena abeceda
  String[][] delta; //funkcija prijelaza
  String[] content={}; //sadrzaj trake do zadnjeg nepraznog mjesta
  
  //konstruktor
  tape(int y, String[] alph, String[][] delta){
    this.y=y;
    alphabet=alph;
    this.delta=delta;
  }
  
  //fja za crtanje trake na pocetku rada
  void start(){
    head=0;
    state="0";
    content=empty;
    update();
  }
  
  //crta traku
  void drawTape(){
    fill(200);
    noStroke();
    //traka
    rect(0,y,width,h+30);
    fill(255);
    stroke(0);
    //mjesta na traci
    for(int i=0;i+x<=width;i+=tilew){
      rect(x+i,y,tilew,h);
    }
  }
  
  //crta bijeli trokut koji predstavlja glavu
  void drawHead(int pos){
    fill(255);
    triangle(x+5+tilew*pos, y+h+20, x+tilew-5+tilew*pos, y+h+20, x+tilew/2+tilew*pos, y+h+5);
    //argumenti za triangle su koordinate tri vrha
  }
  
  //ispisuje sadrzaj na traku
  void input(){
    fill(0);
    textSize(45);
    textAlign(CENTER);
    for(int i=0;i<content.length;i++){
      text(content[i],x+i*tilew+tilew/2,y+h-10);
    }
  }    
  
  //crta sve za traku
  void update(){
    drawTape();
    drawHead(head);
    input();
    return;
  }

  //funkcija za citanje proizvoljnog znaka
  String read(int dir){
      String r;
      //citamo znak na koji pokazuje glava
      if(head>=content.length) r=" ";
      else r=content[head];
      
      //update pozicije glave nakon citanja
      if(dir==1){
        head++;
      }
      else if (dir<=0){
        head--;
        if(head<0) head=0;
      }
      
      //za prikaz trake
      //ako se ode desno od kraja prozora
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
  
  /*
  //funkcija za citanje danog znaka
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
      
      update();
      return r;
    }
    else{
      return null;
    }
  }
  */
  
  //cita cijeli sadrzaj trake
  //(do zadnjeg nepraznog znaka)
  String[] readAll(){
     if(head>0){
       returnToStart();
     }
     String[] tempRead={};
     String c;
     for(int i=0;i<content.length;i++){
       c=read(1);
       tempRead=append(tempRead,c);
     }
     return tempRead;
  }
  
  //funkcija za pisanje danog znaka
  void write(String c, int dir){
    //dodajemo prazne znakove, ako je potrebno,
    //izmedju trenutnog sadrzaja i novog znaka
    if(head>=content.length){
       for(int i=content.length;i<=head;i++){
         content=append(content," ");
       }
    }
    //novi znak pisemo na poziciju glave
    content[head]=c;
    
    //update pozicije glave nakon pisanja
      if(dir==1){
        head++;
      }
      else if (dir<=0){
        head--;
        if(head<0) head=0;
      }
      
    //za prikaz trake
    //ako se ode desno od kraja prozora
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
  
  //mijenja cijeli sadrzaj trake na str
  void writeAll(String[] str, int dir){
    empty();
    for(int i=0;i<str.length;i++){
      write(str[i],dir);
    }
  }
  
  
  //fja koja za dani prijelaz conf oblika 
  //(trenutnoStanje,procitaniZnak,iduceStanje,zapisaniZnak,smjer)
  //provjerava moze li ga traka izvrsiti
  boolean check(String[] conf){
    //ako nije u stanju trenutnoStanje, ne moze
    if(!state.equals(conf[0])){
      return false;
    }
    
    String t=read(1);
    read(-1);
    //ako nije procitao procitaniZnak, ne moze
    if(!t.equals(conf[1])){
      return false;
    }
    
    //inace moze
    return true;
  }

/*
  //koristeno za potpunu simulaciju rada DTO
  String work(){
    if(state.equals("t") || state.equals("f")) return state;
    
    boolean change=false;
    for(int i=0;i<delta.length;i++){
      String reading;
      if(head>=content.length) reading=" ";
      else reading=content[head];
      if(delta[i][0]==state && delta[i][1].equals(reading)){
        state=delta[i][2];
        write(delta[i][3],Integer.parseInt(delta[i][4]));
        change=true;
        break;
      }
    }
    
    if(!change)
      state="f";
    
    return state;
  }
  */
  
  
  //jednostavne pomocne funkcije
  
  int length(){
    return content.length;
  }
  
  void empty(){
    content=empty;
    update();
  }
  
  void returnToStart(){
    while(head!=0){
      read(-1);
    }
    state="0";
    return;
  }
  
  void goToEnd(){
    while(head<content.length){
      read(1);
    }
    while(head>content.length){
      read(-1);
    }
    return;
  }
}
