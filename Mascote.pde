void setup(){

  AbelhaPLY ab = new AbelhaPLY();
  
  //ab.gerarCabeca();
  ab.gerarOlhos();
  PlyReader ply = new PlyReader(ab.olho1Pontos,ab.olho1Faces);
  //print(ab.corpoFaces);
  ply.exportArq("cabeca.ply",true);
  exit();
}
