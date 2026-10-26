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

void setup() {
  fundo = loadImage("E-UESC.png");
  fundo.resize(1280,720);
  size(1280, 720, P3D);
  curva = u.LemniscataBernoulli(300, 3, "xy",10);
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
float inc = 0.5f, incRot = 0,inclinacao = 0, limit = 30,dFeets = 0;
boolean dX;
//Tolerância para a comparação de pontos flutuantes
boolean dir = true;
int indice = 0,cont = 0;
void draw() {
  
  background(fundo);
  translate(width/2, height/2);
   
  //rotateX(map(mouseY,0,height,PI,-PI));
  //rotateY(map(mouseX,0,width,-PI,PI));
  //Tirar essa idiotice daqui depois
  //if(frameCount%1 == 0){
    if(indice == curva.size()-1)indice = 0;
    else indice++;
    dX = curva.get(indice).x > curva.get(indice+1 == curva.size()?0:indice+1).x ;
    
  //}
  
 
  pushMatrix();//Inicio corpo
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
  //exit();
}
void desenharParte(ArrayList<PVector> pontos, ArrayList<ArrayList<Integer>>faces, String rgb) {
  
  for (ArrayList<Integer>f : faces) {
    beginShape();
    noStroke();

    if (rgb == null) rgb = "0 0 0";

    if (rgb.equals("listrado")) {
      float posX = pontos.get(f.get(0)).x;

      if (sin(posX * 0.05) > 0) {
        fill(255, 255, 0);
      } else {
        fill(30, 30, 30);
      }
    } else {
      fill(u.stringRgbToInteger(rgb));
    }
    // -------------------------------

    for (Integer i : f) {
      vertex(-pontos.get(i).x, -pontos.get(i).y, -pontos.get(i).z);
    }

    endShape();
  }
}
