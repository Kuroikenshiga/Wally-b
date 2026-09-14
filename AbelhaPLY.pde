class AbelhaPLY{
  
  ArrayList<PVector> asa1Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> asa1Faces = new ArrayList();
  
  
  ArrayList<PVector> asa2Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> asa2Faces = new ArrayList();
  
  ArrayList<PVector> corpoPontos = new ArrayList();
  ArrayList<ArrayList<Integer>> corpoFaces = new ArrayList();
  
  
  ArrayList<PVector> olho1Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> olho1Faces = new ArrayList();
  
   
  ArrayList<PVector> olho2Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> olho2Faces = new ArrayList();
 
 
   
  ArrayList<PVector> cabecaPontos = new ArrayList();
  ArrayList<ArrayList<Integer>> cabecaFaces = new ArrayList();
 
   
  ArrayList<PVector> ferraoPontos = new ArrayList();
  ArrayList<ArrayList<Integer>> ferraoFaces = new ArrayList();
  
   
  ArrayList<PVector> narizPontos = new ArrayList();
  ArrayList<ArrayList<Integer>> narizFaces = new ArrayList();
 
   
  ArrayList<PVector> antena1Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> antena1Faces = new ArrayList();

  ArrayList<PVector> antena2Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> antena2Faces = new ArrayList();

  ArrayList<PVector> perna1Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> perna1Faces = new ArrayList();
  ArrayList<PVector> perna2Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> perna2Faces = new ArrayList();
  ArrayList<PVector> perna3Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> perna3Faces = new ArrayList();
  ArrayList<PVector> perna4Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> perna4Faces = new ArrayList();
  
  private Utilitarios u = new Utilitarios();
  
  void gerarAsas(){
      asa1Pontos = u.gerarElipse(30,10,20,0);
      asa2Pontos = u.gerarElipse(30,10,20,0);
      
      asa1Faces.add(new ArrayList());
      asa1Faces.get(asa1Faces.size()-1).add(0);
      
      asa2Faces.add(new ArrayList());
      asa2Faces.get(asa2Faces.size()-1).add(0);
      
      for(int i = 1;i < asa1Pontos.size();i++){
        asa1Faces.get(asa1Faces.size()-1).add(i);
        asa2Faces.get(asa2Faces.size()-1).add(i);
      }
  
  }
  void gerarCorpo(){
    ArrayList r[] = u.gerarEsfera(4);
    corpoPontos = (ArrayList<PVector>)r[0];
    u.scale(corpoPontos,new PVector(150,100,100));
    corpoFaces = (ArrayList<ArrayList<Integer>>)r[1];
    
  }
  void gerarOlhos(){
    ArrayList r[] = u.gerarEsfera(4);
    olho1Pontos = (ArrayList<PVector>)r[0];
    olho1Faces = (ArrayList<ArrayList<Integer>>)r[1];
    
    olho2Pontos = (ArrayList<PVector>)r[0];
    olho2Faces = (ArrayList<ArrayList<Integer>>)r[1];
  }
  void gerarCabeca(){
    ArrayList r[] = u.gerarEsfera(4);
    corpoPontos = (ArrayList<PVector>)r[0];
    corpoFaces = (ArrayList<ArrayList<Integer>>)r[1];
    
  }
  void gerarNariz(){
    ArrayList r[] = u.gerarEsfera(4);
    narizPontos = (ArrayList<PVector>)r[0];
    narizFaces = (ArrayList<ArrayList<Integer>>)r[1];
  }
  void gerarFerrao(){
      ArrayList r[] = u.gerarCone(10,25);
      ferraoPontos = (ArrayList<PVector>)r[0];
      ferraoFaces = (ArrayList<ArrayList<Integer>>)r[1];
  }
  
  void gerarPernas(){
  // gera a forma base uma vez
  ArrayList r[] = u.gerarPerna(15, 50, 3);

  // perna 1: frente-esquerda
  perna1Pontos = clonarPontos((ArrayList<PVector>)r[0]);
  perna1Faces = (ArrayList<ArrayList<Integer>>)r[1];
  u.rotacao(perna1Pontos, 'y', radians(90), new PVector(0,0,0));
  u.translacao(perna1Pontos, -80, 40, -50);

  // perna 2: frente-direita
  perna2Pontos = clonarPontos((ArrayList<PVector>)r[0]);
  perna2Faces = (ArrayList<ArrayList<Integer>>)r[1];
  u.rotacao(perna2Pontos, 'y', radians(90), new PVector(0,0,0));
  u.translacao(perna2Pontos, -80, -40, -50);

  // perna 3: trás-esquerda
  perna3Pontos = clonarPontos((ArrayList<PVector>)r[0]);
  perna3Faces = (ArrayList<ArrayList<Integer>>)r[1];
  u.rotacao(perna3Pontos, 'y', radians(90), new PVector(0,0,0));
  u.translacao(perna3Pontos, 60, 40, -50);

  // perna 4: trás-direita
  perna4Pontos = clonarPontos((ArrayList<PVector>)r[0]);
  perna4Faces = (ArrayList<ArrayList<Integer>>)r[1];
  u.rotacao(perna4Pontos, 'y', radians(90), new PVector(0,0,0));
  u.translacao(perna4Pontos, 60, -40, -50);
}

ArrayList<PVector> clonarPontos(ArrayList<PVector> original){
  ArrayList<PVector> copia = new ArrayList();
  for (PVector p : original) {
    copia.add(p.copy());
  }
  return copia;
}
}
