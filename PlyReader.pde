import java.util.*;
class PlyReader {

  public ArrayList<PVector> pontos;
  public ArrayList<ArrayList<Integer>> faces;
  private int scale = 1;
  private String[] linhas;
  //Não esquece de tirar as cores não usadas !!!!!!!
  public final color[] colorFaces = {
    color(230, 80, 80), // 0. Vermelho
    color( 80, 230, 80), // 1. Verde
    color( 80, 80, 230), // 2. Azul
    color(230, 230, 80), // 3. Amarelo
    color(230, 80, 230), // 4. Magenta
    color( 80, 230, 230), // 5. Ciano
    color(255, 150, 50), // 6. Laranja
    color(140, 70, 180), // 7. Roxo / Púrpura
    color(150, 230, 50), // 8. Verde Limão
    color(255, 150, 180), // 9. Rosa Claro
    color(139, 69, 19), // 10. Marrom / Sela
    color( 40, 60, 120), // 11. Azul Marinho
    color(128, 128, 30), // 12. Verde Oliva
    color(255, 200, 150), // 13. Pêssego
    color(128, 20, 20), // 14. Vinho / Bordô
    color(150, 255, 200), // 15. Verde Menta
    color(135, 206, 235), // 16. Azul Celeste
    color(255, 215, 0), // 17. Dourado
    color(255, 127, 80), // 18. Coral
    color( 75, 30, 130), // 19. Índigo
    color(180, 180, 180), // 20. Cinza Claro
    color( 90, 90, 90), // 21. Cinza Escuro
    color(250, 128, 114), // 22. Salmão
    color( 20, 150, 150), // 23. Turquesa Escuro
    color(200, 160, 50)   // 24. Mostarda
  };
  public PlyReader(String urlPLY, int scale) {
    this.pontos = new ArrayList<PVector>();
    this.faces = new ArrayList();
    if (scale > 1) {
      this.scale = scale;
    }
    this.carregarPLY(urlPLY);
  }
  public PlyReader(ArrayList<PVector> pontos, ArrayList<ArrayList<Integer>> faces) {
    this.pontos = pontos;
    this.faces = faces;
  }


  void carregarPLY(String nome) {
    this.linhas = loadStrings(nome);
    int numVertices = 0, numFaces = 0;
    int i = 0;

    while (true) {
      String linha = linhas[i];
      if (linha.startsWith("element vertex")) {
        numVertices = int(split(linha, ' ')[2]);
      }
      if (linha.startsWith("element face")) {
        numFaces = int(split(linha, ' ')[2]);
      }
      i++;
      if (linha.startsWith("end_header")) break;
    }

    for (int v = 0; v < numVertices; v++) {
      String[] partes = split(linhas[i + v], ' ');
      float x = this.scale*float(partes[0]);
      float y = this.scale*float(partes[1]);
      float z = this.scale*float(partes[2]);
      pontos.add(new PVector(x, y, z));
      if (v == numVertices-1) {
        i = i + v + 1;
      }
    }
    int vertInFaces = int(split(linhas[i], ' ')[0]);
    for (int f = 0; f < numFaces; f++) {
      String sParts[] = split(linhas[f + i], ' ');
      ArrayList<Integer> fv = new ArrayList();
      int fvIndice = 0;
      for (int k = 1; k < sParts.length; k++) {
        fv.add(int(sParts[k]));
        fvIndice++;
      }
      faces.add(fv);
    }
  }
  void rotX(int graus) {
    float rad = graus*PI/180;
    for (PVector p : this.pontos) {
      float y = p.y, z = p.z;
      p.y = y*cos(rad) - z*sin(rad);
      p.z = y*sin(rad) + z*cos(rad);
    }
  }
  void rotY(int graus) {
    float rad = graus*PI/180;
    for (PVector p : this.pontos) {
      float x = p.x, z = p.z;
      p.x = x*cos(rad) - z*sin(rad);
      p.z = -x*sin(rad) + z*cos(rad);
    }
  }
  void rotZ(int graus) {
    float rad = graus*PI/180;
    for (PVector p : this.pontos) {
      float x = p.x, y = p.y;
      p.x = x*cos(rad) - y*sin(rad);
      p.y = x*sin(rad) + y*cos(rad);
    }
  }
  void exportArq(String name, boolean originalScale) {


    //String exportArq[] = new String[linhas.length];
    PrintWriter saida = createWriter("exports/"+name);

    saida.println("ply\nformat ascii 1.0\nelement vertex "+pontos.size()
    +"\nproperty float x\nproperty float y\nproperty float z\nelement face "+faces.size()
    +"\nproperty list uchar int vertex_index\nend_header");

    for (PVector p : this.pontos) {
      saida.println(String.format("%f %f %f", p.x/(originalScale?this.scale:1), p.y/(originalScale?this.scale:1), p.z/(originalScale?this.scale:1)).replace(",", "."));
      saida.flush();
    }
    for (ArrayList<Integer> f : this.faces) {
      String s = ""+f.size()+" ";
      for (int j : f) {
        s += ""+j+" ";
      }
      saida.println(s);
      saida.flush();
    }

    saida.close();
  }
  void exportArq(String name, boolean originalScale,ArrayList<String>RGBcolors) {


    //String exportArq[] = new String[linhas.length];
    PrintWriter saida = createWriter("exports/"+name);

    saida.println("ply\nformat ascii 1.0\nelement vertex "+pontos.size()
    +"\nproperty float x\nproperty float y\nproperty float z\nproperty uchar red\nproperty uchar green\nproperty uchar blue\nelement face "+faces.size()
    +"\nproperty list uchar int vertex_index\nend_header");
    int i = 0;
    for (PVector p : this.pontos) {
      saida.println(String.format("%f %f %f %s", p.x/(originalScale?this.scale:1), p.y/(originalScale?this.scale:1), p.z/(originalScale?this.scale:1),RGBcolors.get(i)).replace(",", "."));
      saida.flush();
      i++;
    }
    for (ArrayList<Integer> f : this.faces) {
      String s = ""+f.size()+" ";
      for (int j : f) {
        s += ""+j+" ";
      }
      saida.println(s);
      saida.flush();
    }

    saida.close();
  }
}
