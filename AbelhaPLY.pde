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
 
}
