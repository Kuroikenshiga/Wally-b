void setup(){

  AbelhaPLY ab = new AbelhaPLY();
  
  ab.gerarAsas();
  ab.gerarCorpo();
  ab.gerarFerrao();
  PlyReader ply = new PlyReader(ab.ferraoPontos,ab.ferraoFaces);
  //print(ab.corpoFaces);
  ply.exportArq("ferrao.ply",true);

}
