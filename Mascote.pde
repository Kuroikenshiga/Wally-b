void setup() {

  AbelhaPLY ab = new AbelhaPLY();
  ab.gerarCorpo();
  PlyReader ply = new PlyReader(ab.corpoPontos, ab.corpoFaces);
  ply.exportArq("Abelha.ply", true);
  exit();
}
