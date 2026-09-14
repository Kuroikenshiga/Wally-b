void setup(){

  AbelhaPLY ab = new AbelhaPLY();
  
  ab.gerarAsas();
  ab.gerarCorpo();
  ab.gerarFerrao();
  ab.gerarPernas();
  new PlyReader(ab.perna1Pontos, ab.perna1Faces).exportArq("perna1.ply", true);
  new PlyReader(ab.perna2Pontos, ab.perna2Faces).exportArq("perna2.ply", true);
  new PlyReader(ab.perna3Pontos, ab.perna3Faces).exportArq("perna3.ply", true);
  new PlyReader(ab.perna4Pontos, ab.perna4Faces).exportArq("perna4.ply", true);
  PlyReader ply = new PlyReader(ab.ferraoPontos,ab.ferraoFaces);
  //print(ab.corpoFaces);
  ply.exportArq("ferrao.ply",true);

}
