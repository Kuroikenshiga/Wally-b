void setup() {

  AbelhaPLY ab = new AbelhaPLY();
  ab.gerarCorpo();
  PlyReader ply = new PlyReader(ab.corpoPontos, ab.corpoFaces);
  print(ab.corpoPontos.size() + " - " + ab.corCorpo.size());
  ply.exportArq("AbelhaCompletaColorida.ply", true,ab.corCorpo);
  
  for(int i = 0;i < ab.conjuntoDeComponentesPontos.size();i++){
    new PlyReader(ab.conjuntoDeComponentesPontos.get(i), ab.conjuntoDeComponentesFaces.get(i)).exportArq("AbelhaParte"+(i+1)+".ply", true);
  }
  
  exit();
}
