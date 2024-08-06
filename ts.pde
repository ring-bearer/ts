//prvi primjer: parni palindromi
//simulacija rada NTO je na prve dvije trake,
//s tim da se prva traka samo cita
//(ne mijenjamo ulaznu rijec)

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


//treci primjer: rijeci oblika 0^n1^n
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
boolean odbijeno;
//prati jesu li sve grane odbijene
boolean gotovo;
//prati je li trenutna grana odbijena
String[] dio={};
//pocetni dio trenutne adrese s kojim radimo
String[] readT3={};
//pomoc pri citanju adresa s 3. trake
String[] empty={};
//uvijek samo prazan niz stringova
int adrLength=1;
//duljina trenutne adrese na 4. traci


//sljedece varijable promjeniti
//ovisno o zeljenom primjeru

//broj mogucih prijelaza
int b=z.length; //ili d.length, e.length
//ulazna rijec
String[] input={"a","a","a"};
//TS i njegove trake
//mijenjati dolje u setupu
machine stroj;
tape first,second,third,fourth;


void setup() {
  //za pracenje adresa na 3. i 4. traci
  String[] address={"X","#"};
  for(int i=0;i<b;i++){
    String j=Integer.toString(i);
    address=append(address,j);
  }
  
  //inicijalizacija traka
  //prve dvije promjeniti ovisno o primjeru
  //umjesto al staviti al2,
  //umjesto zetaTape1, deltaTape1 ili epsilonTape1
  //umjesto deltaTape2, epsilonTape2
  first=new tape(30,al,zetaTape1);
  second=new tape(150,al,deltaTape2);
  
  //ove trake ostaju iste
  third=new tape(270,address,null);
  fourth=new tape(390,address,null);
  tape[] tapes={first,second,third,fourth};
  stroj=new machine(tapes,z); 
  //ili d, e umjesto z
  
  //crtanje pocetne pozicije TS
  stroj.start();
  
  //izgled ekrana
  size(1000, 640);
  background(200);
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
    //ulazna rijec na prvu traku
    stroj.writeAll(input,1,first);
  }
  if(korak==2){
    //provjera je li pocetno stanje i zavrsno
    if(stroj.state=="t")
      println("Prihvaćam riječ");
    else if(stroj.state=="f")
      println("Odbijam riječ");
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
    odbijeno=true;
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
  if(korak==14){
    //varijabla l prati je li provjera gotova
    //za sve pocetne grane
    
    String charI=Integer.toString(l);
    String[] chars={charI};
    //provjera za iducu pocetnu granu
    if(!kraj(chars)){
      //ako neka grana nije odbijena,
      //vracamo se na pocetak glavne petlje
      odbijeno=false;
      korak=4;
      l=0;
      return;
    }
    l++;
    if(l==b){ 
      //provjera je gotova
      if(odbijeno){
        println("Odbijam riječ");
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
