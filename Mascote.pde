 AbelhaPLY ab = new AbelhaPLY();
 Utilitarios u = new Utilitarios();
 void setup() {
  size(800,800,P3D);
  
  ab.gerarCorpo();
  PlyReader ply = new PlyReader(ab.corpoPontos, ab.corpoFaces);
  print(ab.corpoPontos.size() + " - " + ab.corCorpo.size());
  ply.exportArq("AbelhaCompletaColorida.ply", true,ab.corCorpo);
  
  for(int i = 0;i < ab.conjuntoDeComponentesPontos.size();i++){
    new PlyReader(ab.conjuntoDeComponentesPontos.get(i), ab.conjuntoDeComponentesFaces.get(i)).exportArq("AbelhaParte-"+ab.nomesComponentes.get(i)+".ply", true);
  }
  print("\n"+ab.conjuntoDeComponentesPontos.size()+" - "+ab.stringsRGB.size());
  //println(ab.stringsRGB);
  //exit();
}
final float limit = 1f;
float inc = 0.9f,incRot = 0;
//Tolerância para a comparação de pontos flutuantes
float epsilon = 0.001;
boolean dir = true,dirScale = true,pauseScale = false,dirRot = true,firstTime = true;
float pausedRotate = 90;

void draw(){
  background(46,46,46);
  translate(width/2,height/2);
  //rotateX(map(mouseY,0,height,PI,-PI));
  //rotateY(map(mouseX,0,width,-PI,PI));
  
  
  pushMatrix();//Inicio corpo
    rotateY(radians(pausedRotate));
    if(Math.abs(inc - limit) < epsilon || Math.abs(inc - 0.3f) < epsilon){
      
      dirScale = !pauseScale?!dirScale:dirScale;
      
      pauseScale = true;
      if(incRot <= 180f){
        
        rotateY(radians(incRot));
        incRot += 5;
      }
      else{
        incRot = 0;
        if(dirRot)pausedRotate = 270f;
        else pausedRotate = 90f;
        pauseScale = false;
        dirRot = !dirRot;
      }
    }
    inc += (pauseScale?0:(dirScale?0.01f:-0.01f));
    int index = ab.nomesComponentes.indexOf("Corpo");
    scale(inc);
    desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
    
    pushMatrix();//Inicio ferrao
      index = ab.nomesComponentes.indexOf("Ferrao");
      desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
    popMatrix();//Fim ferrao
    
    pushMatrix();//Inicio cabeca
      index = ab.nomesComponentes.indexOf("Cabeca");
      desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
      
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Palpebra1");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
      popMatrix();
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Olho1");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
        pushMatrix();
          index = ab.nomesComponentes.indexOf("Iris1");
          desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
        popMatrix();
      popMatrix();
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Palpebra2");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
      popMatrix();
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Olho2");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
        pushMatrix();
          index = ab.nomesComponentes.indexOf("Iris2");
          desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
        popMatrix();
      popMatrix();
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Nariz");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
      popMatrix();
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Boca");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
      popMatrix();
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Antena1");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
      popMatrix();
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Antena2");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
      popMatrix();
      
    popMatrix();//Fim cabeca
    
    pushMatrix();
        index = ab.nomesComponentes.indexOf("Perna1");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
        //println("\n"+ab.stringsRGB.get(index));
    popMatrix();
    pushMatrix();
        index = ab.nomesComponentes.indexOf("Perna2");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
    popMatrix();
    pushMatrix();
        index = ab.nomesComponentes.indexOf("Perna3");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
    popMatrix();
    pushMatrix();
        index = ab.nomesComponentes.indexOf("Perna4");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
    popMatrix();
    
    
    dir = !dir;
    
    pushMatrix();
        index = ab.nomesComponentes.indexOf("Asa1");
        u.rotacao(ab.conjuntoDeComponentesPontos.get(index),'x',radians(dir?30f:-30f),ab.conjuntoDeComponentesPontos.get(index).get(0));
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
        
    popMatrix();
    
    pushMatrix();
        index = ab.nomesComponentes.indexOf("Asa2");
        u.rotacao(ab.conjuntoDeComponentesPontos.get(index),'x',radians(dir?-30f:30f),ab.conjuntoDeComponentesPontos.get(index).get(0));
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),ab.stringsRGB.get(index));
    popMatrix();
  popMatrix();//Fim corpo
  //exit();
}
void desenharParte(ArrayList<PVector> pontos, ArrayList<ArrayList<Integer>>faces, String rgb){
  
  for(ArrayList<Integer>f:faces){
    beginShape();
    noStroke();
    
    if(rgb == null) rgb = "0 0 0";
    
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
    
    for(Integer i:f){
      vertex(-pontos.get(i).x, -pontos.get(i).y, -pontos.get(i).z);
    }
    
    endShape();
  }
}
