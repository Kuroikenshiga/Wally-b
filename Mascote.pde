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
  
  
}
final int limit = 10;
int inc = 0;
boolean dir = true;
void draw(){
  background(255,255,255);
  translate(width/2,height/2);
  rotateX(map(mouseY,0,height,PI,-PI));
  rotateY(map(mouseX,0,width,-PI,PI));
  pushMatrix();//Inicio corpo
    int index = ab.nomesComponentes.indexOf("Corpo");
    desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
    
    pushMatrix();//Inicio ferrao
      index = ab.nomesComponentes.indexOf("Ferrao");
      desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
    popMatrix();//Fim ferrao
    
    pushMatrix();//Inicio cabeca
      index = ab.nomesComponentes.indexOf("Cabeca");
      desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
      
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Palpebra1");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
      popMatrix();
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Olho1");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
      popMatrix();
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Palpebra2");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
      popMatrix();
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Olho2");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
      popMatrix();
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Nariz");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
      popMatrix();
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Boca");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
      popMatrix();
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Antena1");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
      popMatrix();
      pushMatrix();
        index = ab.nomesComponentes.indexOf("Antena2");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
      popMatrix();
      
    popMatrix();//Fim cabeca
    
    pushMatrix();
        index = ab.nomesComponentes.indexOf("Perna1");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
    popMatrix();
    pushMatrix();
        index = ab.nomesComponentes.indexOf("Perna2");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
    popMatrix();
    pushMatrix();
        index = ab.nomesComponentes.indexOf("Perna3");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
    popMatrix();
    pushMatrix();
        index = ab.nomesComponentes.indexOf("Perna4");
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
    popMatrix();
    
    
    dir = !dir;
    
    pushMatrix();
        index = ab.nomesComponentes.indexOf("Asa1");
        u.rotacao(ab.conjuntoDeComponentesPontos.get(index),'x',radians(dir?30f:-30f),ab.conjuntoDeComponentesPontos.get(index).get(0));
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
        
    popMatrix();
    
    pushMatrix();
        index = ab.nomesComponentes.indexOf("Asa2");
        u.rotacao(ab.conjuntoDeComponentesPontos.get(index),'x',radians(dir?-30f:30f),ab.conjuntoDeComponentesPontos.get(index).get(0));
        desenharParte(ab.conjuntoDeComponentesPontos.get(index),ab.conjuntoDeComponentesFaces.get(index),null);
    popMatrix();
  popMatrix();//Fim corpo
}
void desenharParte(ArrayList<PVector> pontos,ArrayList<ArrayList<Integer>>faces,ArrayList<String>colors){
  for(ArrayList<Integer>f:faces){
    beginShape();
    for(Integer i:f){
      //Lembrar de verificar o motivo de estar renderizando de cabeça para baixo!!
      //Solução temporária
      vertex(-pontos.get(i).x,-pontos.get(i).y,-pontos.get(i).z);
    }
    endShape();
  }
}
