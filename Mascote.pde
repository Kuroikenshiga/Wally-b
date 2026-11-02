AbelhaPLY ab = new AbelhaPLY();
Utilitarios u = new Utilitarios();
ArrayList<PVector> curva = null;

int CORPO     = -1;
int FERRAO    = -1;
int CABECA    = -1;
int PALPEBRA1 = -1;
int OLHO1     = -1;
int IRIS1     = -1;
int PALPEBRA2 = -1;
int OLHO2     = -1;
int IRIS2     = -1;
int NARIZ     = -1;
int BOCA      = -1;
int ANTENA1   = -1;
int ANTENA2   = -1;
int PERNA1    = -1;
int PERNA2    = -1;
int PERNA3    = -1;
int PERNA4    = -1;
int ASA1      = -1;
int ASA2      = -1;
PImage fundo = null;
PImage toProfund = null;
void setup() {
  fundo = loadImage("E-UESC.JPG");
  toProfund = loadImage("GUARITA.png");
  fundo.resize(1280,720);
  size(1280, 720, P3D);
  curva = u.LemniscataBernoulli(200, 3, "xy",10);
  ab.gerarCorpo();
  PlyReader ply = new PlyReader(ab.corpoPontos, ab.corpoFaces);
  // print(ab.corpoPontos.size() + " - " + ab.corCorpo.size());
  ply.exportArq("AbelhaCompletaColorida.ply", true, ab.corCorpo);

  for (int i = 0; i < ab.conjuntoDeComponentesPontos.size(); i++) {
    new PlyReader(ab.conjuntoDeComponentesPontos.get(i), ab.conjuntoDeComponentesFaces.get(i)).exportArq("AbelhaParte-"+ab.nomesComponentes.get(i)+".ply", true);
  }
 
  CORPO     = ab.nomesComponentes.indexOf("Corpo");
  FERRAO    = ab.nomesComponentes.indexOf("Ferrao");
  CABECA    = ab.nomesComponentes.indexOf("Cabeca");
  PALPEBRA1 = ab.nomesComponentes.indexOf("Palpebra1");
  OLHO1     = ab.nomesComponentes.indexOf("Olho1");
  IRIS1     = ab.nomesComponentes.indexOf("Iris1");
  PALPEBRA2 = ab.nomesComponentes.indexOf("Palpebra2");
  OLHO2     = ab.nomesComponentes.indexOf("Olho2");
  IRIS2     = ab.nomesComponentes.indexOf("Iris2");
  NARIZ     = ab.nomesComponentes.indexOf("Nariz");
  BOCA      = ab.nomesComponentes.indexOf("Boca");
  ANTENA1   = ab.nomesComponentes.indexOf("Antena1");
  ANTENA2   = ab.nomesComponentes.indexOf("Antena2");
  PERNA1    = ab.nomesComponentes.indexOf("Perna1");
  PERNA2    = ab.nomesComponentes.indexOf("Perna2");
  PERNA3    = ab.nomesComponentes.indexOf("Perna3");
  PERNA4    = ab.nomesComponentes.indexOf("Perna4");
  ASA1      = ab.nomesComponentes.indexOf("Asa1");
  ASA2      = ab.nomesComponentes.indexOf("Asa2");
}
float inc = 0.5f, incRot = 0, limit = 30,scaleControl = 0,rot = 0,rot2 = 0,rot3 = 0;
PVector currentPos = new PVector();
boolean canChangeIndice = true,palpebraDir = true,asnfafhjsfhfajshfus = true;
//Tolerância para a comparação de pontos flutuantes
//indice 31
boolean dir = true,dirPalpebra = false;
int indice = 0,cont = 0,tolerance = 0,toLeft = 0,toUp = 0;
int mov = 1;

void draw() {
  
  background(fundo);
  //background(0);
  //image(fundo,0,0);

  translate(width/2, height/2);
    //rotateY(map(mouseX,0,width,-PI,PI));
    //rotateX(map(mouseY,0,width,PI,-PI));
   //println(screenX(mouseX,mouseY) + " - " + screenY(mouseX,mouseY));
    if(canChangeIndice){
      if(indice == curva.size()-1)indice = 0;
      else indice++;
    }
    if(indice == 11)tolerance++;
    if(tolerance == 2)canChangeIndice = false;
     //println(indice);
  if(canChangeIndice)movimentoLemniscata();
  else if(frameCount > 500 && frameCount < 660){
    pushMatrix();
      translate(-92,12,200);
      scale(0.67934f);
      u.drawTexRect(toProfund);
      
    popMatrix();
    movimentoGuaritaInteracao();
    
  }
  else if(frameCount > 660){
    movimentoCamInteracao();
  }
  else {
    
    movimentoInteracaoAmbiente();
    
  }
 //stopped();
//println(frameCount);
saveFrame("output/frame-####.png");
}

void movimentoCamInteracao(){
  if(rot3 >= 90 && asnfafhjsfhfajshfus){
    scaleControl = 0;
    asnfafhjsfhfajshfus = false;
  }
   pushMatrix();//Inicio corpo
  directionalLight(255, 248, 220, -0.3, 0.9, -0.4); 
  ambientLight(75, 105, 145);
  directionalLight(90, 100, 80, 0.0, -1.0, 0.0);
  directionalLight(240, 240, 255, 0.6, -0.2, 0.8);
   translate(curva.get(indice).x*10,curva.get(indice).y*10,curva.get(indice).z*10);
    translate(0,(sin(frameCount*0.5)*6),0);
    translate(-toLeft,toUp,0);
    scale(inc - scaleControl);
    rotateY(radians(90)+radians(rot) - radians(rot2) - radians(rot3));
     if(rot <= 135 && scaleControl > 0)scaleControl-=0.04f;
     if(scaleControl <= 0 && rot3 <= 45)rot3+=3;
     if(rot3 >= 45 && toLeft <= 700){
       toLeft+=60;
       
     }
     if(toLeft >= 700 && rot3 <= 90)rot3+=3;
     if(rot3 >= 90 && scaleControl < 5f && inc != 0)scaleControl += 0.05f;
     if(abs(inc - scaleControl) < 0.01){inc = 0;scaleControl = 0;}
     
    desenharParte(ab.conjuntoDeComponentesPontos.get(CORPO), ab.conjuntoDeComponentesFaces.get(CORPO), ab.stringsRGB.get(CORPO));
    
    pushMatrix();//Inicio ferrao
    //index = ab.nomesComponentes.indexOf("Ferrao");
    desenharParte(ab.conjuntoDeComponentesPontos.get(FERRAO), ab.conjuntoDeComponentesFaces.get(FERRAO), ab.stringsRGB.get(FERRAO));
    popMatrix();//Fim ferrao
  
    pushMatrix();//Inicio cabeca
    //index = ab.nomesComponentes.indexOf("Cabeca");
    desenharParte(ab.conjuntoDeComponentesPontos.get(CABECA), ab.conjuntoDeComponentesFaces.get(CABECA), ab.stringsRGB.get(CABECA));
  
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Palpebra1");
    
    desenharParte(ab.conjuntoDeComponentesPontos.get(PALPEBRA1), ab.conjuntoDeComponentesFaces.get(PALPEBRA1), ab.stringsRGB.get(PALPEBRA1));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Olho1");
    desenharParte(ab.conjuntoDeComponentesPontos.get(OLHO1), ab.conjuntoDeComponentesFaces.get(OLHO1), ab.stringsRGB.get(OLHO1));
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Iris1");
    desenharParte(ab.conjuntoDeComponentesPontos.get(IRIS1), ab.conjuntoDeComponentesFaces.get(IRIS1), null);
    popMatrix();
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Palpebra2");
      
      desenharParte(ab.conjuntoDeComponentesPontos.get(PALPEBRA2), ab.conjuntoDeComponentesFaces.get(PALPEBRA2), ab.stringsRGB.get(PALPEBRA2));
      
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Olho2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(OLHO2), ab.conjuntoDeComponentesFaces.get(OLHO2), ab.stringsRGB.get(OLHO2));
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Iris2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(IRIS2), ab.conjuntoDeComponentesFaces.get(IRIS2), null);
    popMatrix();
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Nariz");
    desenharParte(ab.conjuntoDeComponentesPontos.get(NARIZ), ab.conjuntoDeComponentesFaces.get(NARIZ), ab.stringsRGB.get(NARIZ));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Boca");
    desenharParte(ab.conjuntoDeComponentesPontos.get(BOCA), ab.conjuntoDeComponentesFaces.get(BOCA), null);
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Antena1");
    desenharParte(ab.conjuntoDeComponentesPontos.get(ANTENA1), ab.conjuntoDeComponentesFaces.get(ANTENA1), ab.stringsRGB.get(ANTENA1));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Antena2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(ANTENA2), ab.conjuntoDeComponentesFaces.get(ANTENA2), ab.stringsRGB.get(ANTENA2));
    popMatrix();
  
    popMatrix();//Fim cabeca
  
  
    //print(dX);
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna1");
    //rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA1), ab.conjuntoDeComponentesFaces.get(PERNA1), ab.stringsRGB.get(PERNA1));
    
    //println("\n"+ab.stringsRGB.get(index));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna2");
    //rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA2), ab.conjuntoDeComponentesFaces.get(PERNA2), ab.stringsRGB.get(PERNA2));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna3");
   // rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA3), ab.conjuntoDeComponentesFaces.get(PERNA3), ab.stringsRGB.get(PERNA3));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna4");
    //rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA4), ab.conjuntoDeComponentesFaces.get(PERNA4), ab.stringsRGB.get(PERNA4));
    popMatrix();
  
  
    dir = !dir;
  
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Asa1");
    u.rotacao(ab.conjuntoDeComponentesPontos.get(ASA1), 'x', radians(dir?30f:-30f), ab.conjuntoDeComponentesPontos.get(ASA1).get(0));
    desenharParte(ab.conjuntoDeComponentesPontos.get(ASA1), ab.conjuntoDeComponentesFaces.get(ASA1), ab.stringsRGB.get(ASA1));
  
    popMatrix();
  
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Asa2");
    u.rotacao(ab.conjuntoDeComponentesPontos.get(ASA2), 'x', radians(dir?-30f:30f), ab.conjuntoDeComponentesPontos.get(ASA2).get(0));
    desenharParte(ab.conjuntoDeComponentesPontos.get(ASA2), ab.conjuntoDeComponentesFaces.get(ASA2), ab.stringsRGB.get(ASA2));
    popMatrix();
  popMatrix();//Fim corpo
}

void movimentoGuaritaInteracao(){
  //print("asdasdada");
//  1145.0 - 766.0
 

  pushMatrix();//Inicio corpo
  directionalLight(255, 248, 220, -0.3, 0.9, -0.4); 
  ambientLight(75, 105, 145);
  directionalLight(90, 100, 80, 0.0, -1.0, 0.0);
  directionalLight(240, 240, 255, 0.6, -0.2, 0.8);
   translate(curva.get(indice).x*10,curva.get(indice).y*10,curva.get(indice).z*10);
    translate(0,(sin(frameCount*0.5)*6),0);
    translate(-toLeft,toUp,0);
    scale(inc - scaleControl);
    rotateY(radians(90)+radians(rot) - radians(rot2));
    if(toLeft > -100)toLeft -= 6;
    if(toLeft <= -100 && rot > 135)rot-=5;
   
    desenharParte(ab.conjuntoDeComponentesPontos.get(CORPO), ab.conjuntoDeComponentesFaces.get(CORPO), ab.stringsRGB.get(CORPO));
    
    pushMatrix();//Inicio ferrao
    //index = ab.nomesComponentes.indexOf("Ferrao");
    desenharParte(ab.conjuntoDeComponentesPontos.get(FERRAO), ab.conjuntoDeComponentesFaces.get(FERRAO), ab.stringsRGB.get(FERRAO));
    popMatrix();//Fim ferrao
  
    pushMatrix();//Inicio cabeca
    //index = ab.nomesComponentes.indexOf("Cabeca");
    desenharParte(ab.conjuntoDeComponentesPontos.get(CABECA), ab.conjuntoDeComponentesFaces.get(CABECA), ab.stringsRGB.get(CABECA));
  
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Palpebra1");
    
    desenharParte(ab.conjuntoDeComponentesPontos.get(PALPEBRA1), ab.conjuntoDeComponentesFaces.get(PALPEBRA1), ab.stringsRGB.get(PALPEBRA1));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Olho1");
    desenharParte(ab.conjuntoDeComponentesPontos.get(OLHO1), ab.conjuntoDeComponentesFaces.get(OLHO1), ab.stringsRGB.get(OLHO1));
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Iris1");
    desenharParte(ab.conjuntoDeComponentesPontos.get(IRIS1), ab.conjuntoDeComponentesFaces.get(IRIS1), null);
    popMatrix();
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Palpebra2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(PALPEBRA2), ab.conjuntoDeComponentesFaces.get(PALPEBRA2), ab.stringsRGB.get(PALPEBRA2));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Olho2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(OLHO2), ab.conjuntoDeComponentesFaces.get(OLHO2), ab.stringsRGB.get(OLHO2));
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Iris2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(IRIS2), ab.conjuntoDeComponentesFaces.get(IRIS2), null);
    popMatrix();
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Nariz");
    desenharParte(ab.conjuntoDeComponentesPontos.get(NARIZ), ab.conjuntoDeComponentesFaces.get(NARIZ), ab.stringsRGB.get(NARIZ));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Boca");
    desenharParte(ab.conjuntoDeComponentesPontos.get(BOCA), ab.conjuntoDeComponentesFaces.get(BOCA), null);
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Antena1");
    desenharParte(ab.conjuntoDeComponentesPontos.get(ANTENA1), ab.conjuntoDeComponentesFaces.get(ANTENA1), ab.stringsRGB.get(ANTENA1));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Antena2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(ANTENA2), ab.conjuntoDeComponentesFaces.get(ANTENA2), ab.stringsRGB.get(ANTENA2));
    popMatrix();
  
    popMatrix();//Fim cabeca
  
  
    //print(dX);
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna1");
    //rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA1), ab.conjuntoDeComponentesFaces.get(PERNA1), ab.stringsRGB.get(PERNA1));
    
    //println("\n"+ab.stringsRGB.get(index));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna2");
    //rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA2), ab.conjuntoDeComponentesFaces.get(PERNA2), ab.stringsRGB.get(PERNA2));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna3");
   // rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA3), ab.conjuntoDeComponentesFaces.get(PERNA3), ab.stringsRGB.get(PERNA3));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna4");
    //rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA4), ab.conjuntoDeComponentesFaces.get(PERNA4), ab.stringsRGB.get(PERNA4));
    popMatrix();
  
  
    dir = !dir;
  
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Asa1");
    u.rotacao(ab.conjuntoDeComponentesPontos.get(ASA1), 'x', radians(dir?30f:-30f), ab.conjuntoDeComponentesPontos.get(ASA1).get(0));
    desenharParte(ab.conjuntoDeComponentesPontos.get(ASA1), ab.conjuntoDeComponentesFaces.get(ASA1), ab.stringsRGB.get(ASA1));
  
    popMatrix();
  
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Asa2");
    u.rotacao(ab.conjuntoDeComponentesPontos.get(ASA2), 'x', radians(dir?-30f:30f), ab.conjuntoDeComponentesPontos.get(ASA2).get(0));
    desenharParte(ab.conjuntoDeComponentesPontos.get(ASA2), ab.conjuntoDeComponentesFaces.get(ASA2), ab.stringsRGB.get(ASA2));
    popMatrix();
  popMatrix();//Fim corpo
}

void movimentoInteracaoAmbiente(){
    //println(frameCount);
    //frame 264
   pushMatrix();//Inicio corpo
   directionalLight(255, 248, 220, -0.3, 0.9, -0.4); 
  ambientLight(75, 105, 145);
  directionalLight(90, 100, 80, 0.0, -1.0, 0.0);
  directionalLight(240, 240, 255, 0.6, -0.2, 0.8);
    translate(curva.get(indice).x*10,curva.get(indice).y*10,curva.get(indice).z*10);
    translate(0,(sin(frameCount*0.5)*12),0);
    translate(-toLeft,toUp,0);
    scale(inc - scaleControl);
    rotateY(radians(90)+radians(rot) - radians(rot2));
    if(frameCount >= 210 && rot < 90)rot += 3;
    if(rot > 30 && scaleControl < 0.25f)scaleControl += 0.01f;
    if(rot >= 60 && toLeft < 15){toLeft++;toUp++;}
    if(frameCount > 280 && toLeft < 120)toLeft += 4;
    //if(toLeft > 90 && toUp < 70)toUp += 4;
    if(toLeft > 40 && rot < 180)rot += 3;
    if(toLeft > 40 && scaleControl < 0.33f)scaleControl += 0.01f;
    if(frameCount > 350 && toLeft < 600)toLeft += 4;
    if(toLeft > 130 && rot < 270)rot+=3;
    if(toLeft > 130 && toUp > -55)toUp-=3;
    if(toLeft > 400 && rot2 < 180)rot2+=3;
   if(toLeft > 500 && scaleControl < 0.4f)scaleControl += 0.001f;
    /*
    if(rot >= limitRot && scaleControl < limitScale)scaleControl += 0.01;
    
    if(frameCount >= 485 && rot < limitRot + 90)rot += 3;
    if((frameCount >= 485) && toLeft < toLeftLimit)toLeft+=5;
    if((frameCount >= 485) && toLeft > 500 && rot2 < 60)rot2+=3;
    if(rot2 >= 60 && scaleControl < inc)scaleControl += 0.01;
    */
    //println(frameCount);
    desenharParte(ab.conjuntoDeComponentesPontos.get(CORPO), ab.conjuntoDeComponentesFaces.get(CORPO), ab.stringsRGB.get(CORPO));
    pushMatrix();//Inicio ferrao
    //index = ab.nomesComponentes.indexOf("Ferrao");
    desenharParte(ab.conjuntoDeComponentesPontos.get(FERRAO), ab.conjuntoDeComponentesFaces.get(FERRAO), ab.stringsRGB.get(FERRAO));
    popMatrix();//Fim ferrao
  
    pushMatrix();//Inicio cabeca
    //index = ab.nomesComponentes.indexOf("Cabeca");
    desenharParte(ab.conjuntoDeComponentesPontos.get(CABECA), ab.conjuntoDeComponentesFaces.get(CABECA), ab.stringsRGB.get(CABECA));
  
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Palpebra1");
    desenharParte(ab.conjuntoDeComponentesPontos.get(PALPEBRA1), ab.conjuntoDeComponentesFaces.get(PALPEBRA1), ab.stringsRGB.get(PALPEBRA1));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Olho1");
    desenharParte(ab.conjuntoDeComponentesPontos.get(OLHO1), ab.conjuntoDeComponentesFaces.get(OLHO1), ab.stringsRGB.get(OLHO1));
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Iris1");
    desenharParte(ab.conjuntoDeComponentesPontos.get(IRIS1), ab.conjuntoDeComponentesFaces.get(IRIS1), null);
    popMatrix();
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Palpebra2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(PALPEBRA2), ab.conjuntoDeComponentesFaces.get(PALPEBRA2), ab.stringsRGB.get(PALPEBRA2));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Olho2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(OLHO2), ab.conjuntoDeComponentesFaces.get(OLHO2), ab.stringsRGB.get(OLHO2));
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Iris2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(IRIS2), ab.conjuntoDeComponentesFaces.get(IRIS2), null);
    popMatrix();
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Nariz");
    desenharParte(ab.conjuntoDeComponentesPontos.get(NARIZ), ab.conjuntoDeComponentesFaces.get(NARIZ), ab.stringsRGB.get(NARIZ));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Boca");
    desenharParte(ab.conjuntoDeComponentesPontos.get(BOCA), ab.conjuntoDeComponentesFaces.get(BOCA), null);
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Antena1");
    desenharParte(ab.conjuntoDeComponentesPontos.get(ANTENA1), ab.conjuntoDeComponentesFaces.get(ANTENA1), ab.stringsRGB.get(ANTENA1));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Antena2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(ANTENA2), ab.conjuntoDeComponentesFaces.get(ANTENA2), ab.stringsRGB.get(ANTENA2));
    popMatrix();
  
    popMatrix();//Fim cabeca
  
  
    //print(dX);
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna1");
    //rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA1), ab.conjuntoDeComponentesFaces.get(PERNA1), ab.stringsRGB.get(PERNA1));
    
    //println("\n"+ab.stringsRGB.get(index));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna2");
    //rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA2), ab.conjuntoDeComponentesFaces.get(PERNA2), ab.stringsRGB.get(PERNA2));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna3");
   // rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA3), ab.conjuntoDeComponentesFaces.get(PERNA3), ab.stringsRGB.get(PERNA3));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna4");
    //rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA4), ab.conjuntoDeComponentesFaces.get(PERNA4), ab.stringsRGB.get(PERNA4));
    popMatrix();
  
  
    dir = !dir;
  
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Asa1");
    u.rotacao(ab.conjuntoDeComponentesPontos.get(ASA1), 'x', radians(dir?30f:-30f), ab.conjuntoDeComponentesPontos.get(ASA1).get(0));
    desenharParte(ab.conjuntoDeComponentesPontos.get(ASA1), ab.conjuntoDeComponentesFaces.get(ASA1), ab.stringsRGB.get(ASA1));
  
    popMatrix();
  
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Asa2");
    u.rotacao(ab.conjuntoDeComponentesPontos.get(ASA2), 'x', radians(dir?-30f:30f), ab.conjuntoDeComponentesPontos.get(ASA2).get(0));
    desenharParte(ab.conjuntoDeComponentesPontos.get(ASA2), ab.conjuntoDeComponentesFaces.get(ASA2), ab.stringsRGB.get(ASA2));
    popMatrix();
  popMatrix();//Fim corpo
}
void movimentoLemniscata(){
    pushMatrix();//Inicio corpo
    directionalLight(255, 248, 220, -0.3, 0.9, -0.4); 
  ambientLight(75, 105, 145);
  directionalLight(90, 100, 80, 0.0, -1.0, 0.0);
  directionalLight(240, 240, 255, 0.6, -0.2, 0.8);
   translate(curva.get(indice).x*10,curva.get(indice).y*10,curva.get(indice).z*10);
    //float dx = curva.get(indice+1 == curva.size()?0:indice+1).x - curva.get(indice).x;
    //float dz = curva.get(indice+1 == curva.size()?0:indice+1).z - curva.get(indice).z;
    
    //inclinacao = atan2(dx,dz);
    rotateY(radians(90));
    scale(inc,inc,inc);
    
    desenharParte(ab.conjuntoDeComponentesPontos.get(CORPO), ab.conjuntoDeComponentesFaces.get(CORPO), ab.stringsRGB.get(CORPO));
    
    pushMatrix();//Inicio ferrao
    //index = ab.nomesComponentes.indexOf("Ferrao");
    desenharParte(ab.conjuntoDeComponentesPontos.get(FERRAO), ab.conjuntoDeComponentesFaces.get(FERRAO), ab.stringsRGB.get(FERRAO));
    popMatrix();//Fim ferrao
  
    pushMatrix();//Inicio cabeca
    //index = ab.nomesComponentes.indexOf("Cabeca");
    desenharParte(ab.conjuntoDeComponentesPontos.get(CABECA), ab.conjuntoDeComponentesFaces.get(CABECA), ab.stringsRGB.get(CABECA));
  
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Palpebra1");
    
    desenharParte(ab.conjuntoDeComponentesPontos.get(PALPEBRA1), ab.conjuntoDeComponentesFaces.get(PALPEBRA1), ab.stringsRGB.get(PALPEBRA1));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Olho1");
    desenharParte(ab.conjuntoDeComponentesPontos.get(OLHO1), ab.conjuntoDeComponentesFaces.get(OLHO1), ab.stringsRGB.get(OLHO1));
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Iris1");
    desenharParte(ab.conjuntoDeComponentesPontos.get(IRIS1), ab.conjuntoDeComponentesFaces.get(IRIS1), null);
    popMatrix();
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Palpebra2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(PALPEBRA2), ab.conjuntoDeComponentesFaces.get(PALPEBRA2), ab.stringsRGB.get(PALPEBRA2));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Olho2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(OLHO2), ab.conjuntoDeComponentesFaces.get(OLHO2), ab.stringsRGB.get(OLHO2));
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Iris2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(IRIS2), ab.conjuntoDeComponentesFaces.get(IRIS2), null);
    popMatrix();
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Nariz");
    desenharParte(ab.conjuntoDeComponentesPontos.get(NARIZ), ab.conjuntoDeComponentesFaces.get(NARIZ), ab.stringsRGB.get(NARIZ));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Boca");
    desenharParte(ab.conjuntoDeComponentesPontos.get(BOCA), ab.conjuntoDeComponentesFaces.get(BOCA), null);
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Antena1");
    desenharParte(ab.conjuntoDeComponentesPontos.get(ANTENA1), ab.conjuntoDeComponentesFaces.get(ANTENA1), ab.stringsRGB.get(ANTENA1));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Antena2");
    desenharParte(ab.conjuntoDeComponentesPontos.get(ANTENA2), ab.conjuntoDeComponentesFaces.get(ANTENA2), ab.stringsRGB.get(ANTENA2));
    popMatrix();
  
    popMatrix();//Fim cabeca
  
  
    //print(dX);
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna1");
    //rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA1), ab.conjuntoDeComponentesFaces.get(PERNA1), ab.stringsRGB.get(PERNA1));
    
    //println("\n"+ab.stringsRGB.get(index));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna2");
    //rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA2), ab.conjuntoDeComponentesFaces.get(PERNA2), ab.stringsRGB.get(PERNA2));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna3");
   // rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA3), ab.conjuntoDeComponentesFaces.get(PERNA3), ab.stringsRGB.get(PERNA3));
    popMatrix();
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Perna4");
    //rotateX(radians(dFeets));
    desenharParte(ab.conjuntoDeComponentesPontos.get(PERNA4), ab.conjuntoDeComponentesFaces.get(PERNA4), ab.stringsRGB.get(PERNA4));
    popMatrix();
  
  
    dir = !dir;
  
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Asa1");
    u.rotacao(ab.conjuntoDeComponentesPontos.get(ASA1), 'x', radians(dir?30f:-30f), ab.conjuntoDeComponentesPontos.get(ASA1).get(0));
    desenharParte(ab.conjuntoDeComponentesPontos.get(ASA1), ab.conjuntoDeComponentesFaces.get(ASA1), ab.stringsRGB.get(ASA1));
  
    popMatrix();
  
    pushMatrix();
    //index = ab.nomesComponentes.indexOf("Asa2");
    u.rotacao(ab.conjuntoDeComponentesPontos.get(ASA2), 'x', radians(dir?-30f:30f), ab.conjuntoDeComponentesPontos.get(ASA2).get(0));
    desenharParte(ab.conjuntoDeComponentesPontos.get(ASA2), ab.conjuntoDeComponentesFaces.get(ASA2), ab.stringsRGB.get(ASA2));
    popMatrix();
  popMatrix();//Fim corpo
}
void desenharParte(ArrayList<PVector> pontos, ArrayList<ArrayList<Integer>>faces, String rgb) {
  
  for (ArrayList<Integer>f : faces) {
    beginShape();
    noStroke();

    if (rgb == null) rgb = "0 0 0";

    if (rgb.equals("listrado")) {
      
      float posZ = pontos.get(f.get(0)).x;

      float limitePolo = 120.0; 

      if (abs(posZ) > limitePolo) {
        
        fill(255, 255, 0); 
      } else {
        
        if (sin(posZ * 0.08) > 0) {
          fill(255, 255, 0);   
        } else {
          fill(30, 30, 30);    
        }
      }
    } else {
      fill(u.stringRgbToInteger(rgb));
    }

    for (Integer i : f) {
      vertex(-pontos.get(i).x, -pontos.get(i).y, -pontos.get(i).z);
    }

    endShape();
  }
}
