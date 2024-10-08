//odabir primjera:
//1 - parni palindromi
//2 - neparni palindromi
//3 - rijeci oblika 0^n1^n
int primjer=3;
//unos ulazne riječi kao niza stringova
String[] input={"0","1"};




//prvi primjer: parni palindromi
//simulacija rada NTO je na prve dvije trake,
//s tim da se prva traka samo cita
//(ne mijenjamo ulaznu riječ)

//abeceda
String[] al={"a","b"};
//fja prijelaza za prvu traku
String[][] deltaTape1={
{"0","a","1","a","2"},
{"0","b","1","b","2"},
{"1","a","2","a","1"},
{"1","b","3","b","1"},
{"0","a","4","a","1"},
{"0","b","5","b","1"},
{"1"," ","t"," ","1"},
};
//za drugu traku
String[][] deltaTape2={
{"0"," ","1"," ","0"},
{"2","a","1"," ","0"},
{"3","b","1"," ","0"},
{"1"," ","t"," ","1"},
{"4"," ","0","a","1"},
{"5"," ","0","b","1"}
};
//za cijeli NTO
//adresa ce biti niz integera
//koji predstavljaju indekse 
//elemenata(=prijelaza) u ovom nizu
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

//drugi primjer: neparni palindromi,
//uz al i deltaTape2
//razlika je u stvari samo u dva prijelaza
String[][] zetaTape1={
{"0","a","1","a","1"},
{"0","b","1","b","1"},
{"1","a","2","a","1"},
{"1","b","3","b","1"},
{"0","a","4","a","1"},
{"0","b","5","b","1"},
{"1"," ","t"," ","1"},
};
String[][][] z={
 {zetaTape1[0],deltaTape2[0]},
 {zetaTape1[1],deltaTape2[0]},
 {zetaTape1[2],null},
 {zetaTape1[3],null},
 {null,deltaTape2[1]},
 {null,deltaTape2[2]},
 {zetaTape1[6],deltaTape2[3]},
 {zetaTape1[4],null},
 {zetaTape1[5],null},
 {null,deltaTape2[4]},
 {null,deltaTape2[5]},
};


//treci primjer: riječi oblika 0^n1^n
String[] al2={"0","1"};
String[][] epsilonTape1={
{"0","0","0","0","1"},
{"0","0","1","0","1"},
{"1","1","1","1","1"},
{"1"," ","t"," ","1"},
};
String[][] epsilonTape2={
{"0"," ","0","0","1"},
{"0"," ","1","0","2"},
{"1","0","1"," ","0"},
{"1"," ","t"," ","1"},
};
String[][][] e={
 {epsilonTape1[0],epsilonTape2[0]},
 {epsilonTape1[1],epsilonTape2[1]},
 {epsilonTape1[2],epsilonTape2[2]},
 {epsilonTape1[3],epsilonTape2[3]},
};



//pomocne varijable

boolean lastPressed=false;
//prati jesmo li pokrenuli/pauzirali racunanje
int korak=1;
//prati tijek programa
int l=0;
//pomoc u koraku 14

String[] adresa;
//tu spremamo trenutnu adresu sa 4. trake
boolean kontrola;
//prati jesu li sve grane odbijene
boolean gotovo;
//prati je li trenutna grana odbijena
String[] empty={};
//uvijek samo prazan niz stringova
String[] dio=empty;
//pocetni dio trenutne adrese s kojim radimo
String[] readT3=empty;
//pomoc pri citanju adresa s 3. trake
int adrLength=1;
//duljina trenutne adrese na 4. traci

//broj mogucih prijelaza
int b;
//odabrana abeceda za primjer
String[] alphabet;
//odabrana delta funkcija za primjer
String[][][] deltaFunction;

//TS i njegove trake
machine stroj;
tape first,second,third,fourth;


void setup() {
  //inicijalizacija ovisno o primjeru
  if(primjer==1){
    alphabet=al;
    deltaFunction=d;
  }
  else if(primjer==2){
    alphabet=al;
    deltaFunction=z;
  }
  else{
    alphabet=al2;
    deltaFunction=e;
  }
  b=deltaFunction.length;
  
  //za pracenje adresa na 3. i 4. traci
  //ovo je isto za svaki primjer
  String[] address={"X","#"};
  for(int i=0;i<b;i++){
    String j=Integer.toString(i);
    address=append(address,j);
  }
  
  //inicijalizacija traka
  first=new tape(30,alphabet,deltaFunction[0]);
  second=new tape(150,alphabet,deltaFunction[1]);
  third=new tape(270,address,null);
  fourth=new tape(390,address,null);
  
  tape[] tapes={first,second,third,fourth};
  stroj=new machine(tapes,deltaFunction);
  
  //crtanje pocetne pozicije TS
  stroj.start();
  
  //izgled ekrana
  size(1000, 720);
  background(200);
  
  //ispis varijabli
  textSize(20);
  textAlign(LEFT);
  text("Varijable:",30,520);
  writeText();
}

//ispis varijabli
void writeText(){
  noStroke();
  fill(200);
  rect(30,525,600,100);
  //kvadrat pokriva prethodni ispis
  fill(0);
  textSize(20);
  textAlign(LEFT);
  text("korak="+korak,30,550);
  text("kontrola="+kontrola,30,580);
  text("gotovo="+gotovo,30,610);
  
  
  text("adrLength="+adrLength,220,550);
  if(dio.equals(empty))
    text("adresa=null",220,580);
  else{
    //radimo string od niza stringova
    //za ljepsi/laksi ispis
    int i;
    String s="";
    text("adresa={",220,580);
    for(i=0;i<adresa.length;i++){
      s=s+adresa[i];
      if(i!=adresa.length-1) s=s+",";
    }
    text(s+"}",292,580);
  }
  
  if(dio.equals(empty))
    text("dio=null",220,610);
  else{
    int i;
    String s="";
    text("dio={",220,610);
    for(i=0;i<dio.length;i++){
      s=s+dio[i];
      if(i!=dio.length-1) s=s+",";
    }
    text(s+"}",263,610);
  }
  
  if(!lastPressed){
    if(stroj.state=="t"){
      text("Prihvaćam riječ!",30,650);
      stroj.returnAllToStart();
    }
    if(stroj.state=="f"){
      text("Odbijam riječ!",30,650);
      stroj.returnAllToStart();
    }
  }
}

//draw funkcija se neprestano ponovno izvrsava,
//brzinom zadanom sa frameRate=
//broj slika po sekundi (default=60)
void draw() {
  //iznova crta stroj
  stroj.update();
  
  if(lastPressed){
    kod(); //program iz dokaza
  }
  
  writeText(); //ispis stanja varijabli
}

//fja koja se poziva kod pritiska tipke
void keyPressed(){
  if(keyCode==ENTER){
    lastPressed=true;
    //pokretanje programa u kod()
  }
  if(keyCode==TAB){
    lastPressed=false;
    //pauziranje programa
  }
  //promjena brzine programa
  if(key=='1'){
    frameRate(1);
  }
  if(key=='3'){
    frameRate(30);
  }
  if(key=='5'){
    frameRate(50);
  }
  if(key=='6'){
    frameRate(60);
  }
  //micanje po trecoj traci
  //program se pritom pauzira
  if(keyCode==RIGHT){
    lastPressed=false;
    stroj.read(1,third);
  }
  if(keyCode==LEFT){
    lastPressed=false;
    stroj.read(-1,third);
  }
}

//program koji prati pseudokod u seminaru
//varijabla korak sluzi kako bi se promjene
//traka u kodu postupno crtale na ekran,
//umjesto sve odjednom/prebrzo
void kod(){
  if(korak==1){
    //ulazna riječ na prvu traku
    stroj.writeAll(input,1,first);
  }
  if(korak==2){
    //provjera je li pocetno stanje i zavrsno
    if(stroj.state=="t"){
      println("Prihvaćam riječ");
    }
    else if(stroj.state=="f"){
      println("Odbijam riječ");
    }
    else
      println("Nastavljam s radom");
  }
  if(korak==3){
    //pocetna adresa 0 na 4. traku
    String[] inp={"0"};
    stroj.writeAll(inp,1,fourth);
    stroj.returnAllToStart();
  }
  if(korak==4){
    //spremamo sadrzaj 4. trake u varijablu adresa
    //ovim korakom pocinje glavna petlja programa
    adresa=stroj.readAll(fourth);
  }
  if(korak==5){
    kontrola=true;
    gotovo=false;
    dio=empty;
  }
  if(korak==6){
    //resetiramo traku gdje se simulira NTO,
    //ostale vratimo na pocetak
    stroj.returnAllToStart();
    second.start();
  }
  if(korak==7){
    //ovaj i iduci korak su petlja:
    //provjeravamo za svaki pocetni dio adrese
    //je li vec odbijen
    if(gotovo){
      //ako je odbijen preskacemo rad s tom adresom
      korak=12;
      return;
    }
    if(java.util.Arrays.equals(dio,adresa)){
      //ako je pocetni dio isti kao adresa,
      //a gotovo=false,
      //znaci da nije jos odbijena,
      //nastavljamo s radom
      korak+=2;
    }
    else korak++;
    stroj.getDio();
  }
  if(korak==8){
    //trazimo dio na trecoj traci
    int find=findAddress(dio);
    if(find==1){
      //na traci je i odbijen
      gotovo=true;
    }
    korak--;
    //vracamo se u prethodni korak
    //gdje nalazimo sljedeci dio
    //i provjeravamo za njega, ako je potrebno
    return;
  }
  if(korak==9){
    stroj.returnToStart(fourth);
  }
  if(korak==10){
    //ovaj korak je takodjer petlja
    //citamo po jedan znak s 4. trake
    //i obavljamo prijelaz, ako je moguc
    //jasno, ako nije, ta se grana odbija
    String temp=stroj.read(1,fourth);
    if(!temp.equals(" ")){
      int intTemp=Integer.parseInt(temp);
      if(stroj.check(intTemp)){ 
        stroj.work(intTemp);
      }
      else{
        //prijelaz nije moguc
        //nastavljamo s iducim korakom
        stroj.state="f";
        korak++;
      }
      return;
    }
  }
  if(korak==11){
    //zapisujemo adresu na trecu traku
    stroj.goToEnd(third);
    for(int i=0;i<adresa.length;i++)
      stroj.write(adresa[i],1,third);
    if(stroj.state=="f")
      //oznaka da je adresa odbijena
      stroj.write("X",1,third);
    stroj.write("#",1,third); //delimiter
  }
  if(korak==12){
    if(stroj.state=="t"){
      println("Prihvaćam riječ");
      lastPressed=false; //program završava
      return;
    }
  }
  if(korak==13){
    //zapisujemo pocetni dio do kojeg smo dosli
    //i racunamo mu sljedecu adresu
    //efekt ovoga je da npr za adresu 2000,
    //ako smo vidjeli da je odbijen vec dio 2,
    //ne provjeravamo i svu drugu djecu od 2
    stroj.returnToStart(fourth);
    stroj.writeAll(dio,1,fourth);
    int tempAdrLength=adrLength;
    sljedeca();
    dio=empty;
    stroj.goToEnd(fourth);
    for(int i=fourth.head;i<adrLength;i++){
      stroj.write("0",1,fourth);
      //dodajemo nule na kraj kako bi ostali
      //na istoj dubini stabla
    }
    if(tempAdrLength==adrLength){
      //nije se povecala duljina adrese
      //idemo na pocetak glavne petlje
      korak=4;
      return;
    }
  }
  //pri svakom povecavanju duljine adrese,
  //provjeravamo jesmo li sve grane odbili
  //to se moze raditi i cesce (nakon svake adrese),
  //ali znatno usporava program
  //opcenito ovo je najdugotrajniji dio,
  //a zato sto je fja kraj() rekurzivna i izvan
  //glavnog programa, na ekranu se ne vidi
  //kretanje 3. trakom pri njenom radu
  //rad se moze pratiti preko ispisa u konzoli
  if(korak==14){
    //varijabla l prati je li provjera gotova
    //za sve pocetne grane
    
    String charI=Integer.toString(l);
    String[] chars={charI};
    //provjera za iducu pocetnu granu
    if(!kraj(chars)){
      //ako neka grana nije odbijena,
      //vracamo se na pocetak glavne petlje
      kontrola=false;
      korak=4;
      l=0;
      return;
    }
    l++;
    if(l==b){ 
      //provjera je gotova
      if(kontrola){
        println("Odbijam riječ");
        stroj.state="f";
        lastPressed=false;
      }
      //ako nije odbijeno opet idemo nazad
      //na pocetak glavne petlje
      korak=4;
      l=0;
      return;
    }
    return;
  }
  korak++;
  return;
}

//racuna adresu poslije one na 4. traci
//i zapisuje ju na 4. traku
void sljedeca(){
    int intTemp;
    int headTemp=1;
    String charTemp;
    
    while(true){
      charTemp=" ";
      while(charTemp==" "){
        headTemp=fourth.head;
        charTemp=stroj.read(-1,fourth);
        //citamo prvi neprazni znak zdesna
      }
      intTemp=Integer.parseInt(charTemp);
      if(headTemp!=0) stroj.read(1,fourth);
      //ako nismo prije citanja bili na pocetku,
      //micemo se udesno
      //sad smo na istom mjestu kao prije citanja
      
      //ako je procitani znak manji od b-1,
      //samo ga povecamo za 1 i vracamo
      if(intTemp<b-1){
        intTemp++;
        charTemp=Integer.toString(intTemp);
        stroj.write(charTemp,-1,fourth);
        return;
      }
      //inace mijenjamo znak u 0
      else{
        charTemp=Integer.toString(0);
        if(fourth.head>=1)
          stroj.write(charTemp,-1,fourth);
        //ako smo na pocetku trake,
        //sve znakove smo promjenili u 0,
        //pa treba jos dodati 0 na kraj
        //npr 999 -> 0000 za b=10
        else{
          stroj.write(charTemp,-1,fourth);
          fourth.goToEnd();
          stroj.write("0",1,fourth);
          adrLength++;
          return;
        }
      }
   }
}

//provjera je li cvor na danoj adresi odbijen
boolean kraj(String[] adresa){
  boolean help=false;
  
  stroj.returnToStart(third);
  int find=findAddress(adresa);
  
  //za ispis u konzoli
  int k;
  String s="{";
  for(k=0;k<adresa.length;k++){
    s=s+adresa[k];
    if(k!=adresa.length-1) s=s+",";
  }
  s+="}";
  println("Provjera kraja za adresu "+s);
  
  if(find==1) return true; //adresa je vec odbijena
  if(find==0){ //jos nije odbijena
    for(int i=0;i<b;i++){
      //provjera jesu li sva djeca cvora odbijena
      //tad ce i sam cvor biti odbijen
      String charI=Integer.toString(i);
      String[] novaAdresa=append(adresa,charI);
      help=kraj(novaAdresa);
      if(!help){
        //dijete jos nije odbijeno - nije ni sam cvor
        break;
      }
    }
  }
  return help;
}

//trazi danu adresu na trecoj traci
//vraca 2 ako ju ne nađe,
//1 ako ju nađe i vec je odbijena,
//0 ako ju nađe i nije odbijena
int findAddress(String[] adresa){
  int help=0;
  while(true){
    String temp=stroj.read(1,third);
    if(help==0){
      if(temp==" "){
        //cim smo dosli do praznog znaka,
        //znaci da smo na kraju trake
        //bez da smo nasli adresu
        return 2;
      }
      readT3=append(readT3,temp); //pamtimo dosad procitano
      
      //procitano je zasad jednako pocetku adrese
      if(readT3[readT3.length-1].equals(adresa[readT3.length-1])){
        
        if(java.util.Arrays.equals(adresa,readT3)){
          //nasli smo trazenu adresu
          temp=stroj.read(1,third);
          readT3=empty;
          if(temp=="X"){
            return 1; //odbijena adresa
          }
          else{
            return 0; //nije jos odbijena
          }
        }
      }
      //odbijen je vec neki cvor predak nase adrese
      else if(readT3[readT3.length-1].equals("X")){
        readT3=empty;
        return 1;
      }
      
      //procitano nije jednako pocetku nase adrese
      //odlazimo do sljedece adrese na traci
      else{
        help=1;
      }
    }
    if(help==1){
        //pomak do prvog # nakon kojeg je iduca adresa
        while(!temp.equals("#")){
          temp=stroj.read(1,third);
        }
        readT3=empty;
        help=0;
    }
  }
}
