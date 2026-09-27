void setup(){

  AbelhaPLY ab = new AbelhaPLY();
  
  //ab.gerarCabeca();
  //ab.gerarAntenas(0.08, 0.5);;
  ab.gerarCorpo();
  //ab.gerarPernas();
  
  PlyReader ply = new PlyReader(ab.corpoPontos,ab.corpoFaces);
  //print(ab.corpoFaces);
  ply.exportArq("cabeca.ply",true);
  exit();
}
