void setup() {

  AbelhaPLY ab = new AbelhaPLY();
  ab.gerarCorpo();
  PlyReader ply = new PlyReader(ab.corpoPontos, ab.corpoFaces);
  print(ab.corpoPontos.size() + " - " + ab.corCorpo.size());
  ply.exportArq("Abelha.ply", true,ab.corCorpo);
  //ply.exportArq("Abelha.ply", true);
  exit();
}
