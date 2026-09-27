class Utilitarios { //<>//


  PVector calcularCentro(ArrayList<PVector> pts) {
    PVector centro = new PVector(0, 0, 0);
    for (PVector p : pts) {
      centro.add(p);
    }
    centro.div(pts.size());
    return centro;
  }

  void translacao(ArrayList<PVector> pts, float dx, float dy, float dz) {
    for (PVector p : pts) {
      p.x += dx;
      p.y += dy;
      p.z += dz;
    }
  }

  void scale(ArrayList<PVector>pts, PVector dims) {
    for (PVector p : pts) {
      p.x *= dims.x;
      p.y *= dims.y;
      p.z *= dims.z;
    }
  }

  void reflexao(ArrayList<PVector> pts, PVector ref, PVector centro) {
    for (PVector p : pts) {

      p.sub(centro);
      p.x *= ref.x;
      p.y *= ref.y;
      p.z *= ref.z;
      p.add(centro);
    }
  }
  void rotacao(ArrayList<PVector> pts, char eixo, float angulo, PVector centro) {
    float cosA = cos(angulo);
    float sinA = sin(angulo);

    for (PVector p : pts) {
      p.sub(centro);

      float x = p.x, y = p.y, z = p.z;

      switch (eixo) {
      case 'x':
        p.y = y * cosA - z * sinA;
        p.z = y * sinA + z * cosA;
        break;
      case 'y':
        p.x = x * cosA + z * sinA;
        p.z = -x * sinA + z * cosA;
        break;
      case 'z':
        p.x = x * cosA - y * sinA;
        p.y = x * sinA + y * cosA;
        break;
      }

      p.add(centro);
    }
  }

  ArrayList<PVector> gerarElipse(int resolucao, float raio, float raio2, float z) {
    float angulo = 360/resolucao;
    ArrayList<PVector> pontos = new ArrayList();
    if (raio == 0) {
      pontos.add(new PVector(0, 0, z));
      return pontos;
    }
    for (int i = 0; i < 360; i += angulo) {
      point(raio*cos(radians(i)), raio2*sin(radians(i)));
      pontos.add(new PVector(raio*cos(radians(i)), raio2*sin(radians(i)), z));
    }
    return pontos;
  }

  ArrayList<ArrayList<Integer>> gerarFacesPolos(int minIndex, int maxIndex) {
    ArrayList<ArrayList<Integer>> total = new ArrayList();
    for (int i = minIndex+1; i <= maxIndex; i++) {
      int index = (i == maxIndex?minIndex+1:i+1);
      ArrayList<Integer> face = new ArrayList();
      face.add(i);
      face.add(index);
      face.add(minIndex);
      total.add(face);
    }
    return total;
  }
  ArrayList<ArrayList<Integer>> gerarFaces(int minIndex, int maxIndex, int resolucaoV) {
    ArrayList<ArrayList<Integer>> total = new ArrayList();
    for (int i = minIndex; i <= maxIndex; i++) {
      int index = (i == maxIndex?minIndex:i+1);
      ArrayList<Integer> face = new ArrayList();
      face.add(i);
      face.add(index);
      face.add(index-resolucaoV);
      face.add(i-resolucaoV);
      total.add(face);
    }
    return total;
  }
  ArrayList[] gerarElipsoide(float raio, float raio2, int resolucao, boolean half) {

    float fatorDecrementoVertical = (raio/resolucao);
    float fatorDecrementoVertical2 = (raio2/resolucao);
    ArrayList<PVector> pontosT = new ArrayList();
    ArrayList<ArrayList<Integer>> faces = new ArrayList();
    float z = raio2;
    int contador = 0;
    for (float i = raio; i >= 0; i -= fatorDecrementoVertical) {
      pontosT.addAll(gerarElipse(resolucao, sqrt(raio*raio - i*i), sqrt(raio2*raio2 - z*z), i));
      if (contador == 1) {
        faces.addAll(gerarFacesPolos(0, pontosT.size()-1));
      }
      if (contador > 1) {
        faces.addAll(gerarFaces(pontosT.size()-resolucao, pontosT.size()-1, resolucao));
      }
      contador++;
      z -= fatorDecrementoVertical2;
    }

    if (half)return new ArrayList[]{pontosT, faces};

    int tamanho = pontosT.size();
    contador = 0;
    for (int i = 0; i < tamanho; i++) {
      PVector p = pontosT.get(i);
      pontosT.add(new PVector(p.x, p.y, -p.z));

      if ((pontosT.size()-1-tamanho)%resolucao == 0) {
        if (contador == 1) {
          faces.addAll(gerarFacesPolos(tamanho, pontosT.size()-1));
        }
        if (contador > 1) {
          faces.addAll(gerarFaces(pontosT.size() - resolucao, pontosT.size()-1, resolucao));
        }
        contador++;
      }
    }

    return new ArrayList[]{pontosT, faces};
  }

  ArrayList[] gerarEsfera(int subdivisoes) {
    ArrayList<PVector> pontos = new ArrayList();
    pontos.add(new PVector(1, 0, 0));
    pontos.add(new PVector(0, 1, 0));
    pontos.add(new PVector(0, 0, 1));

    ArrayList<ArrayList<Integer>> triangulos = new ArrayList();
    triangulos.add(new ArrayList());
    triangulos.get(triangulos.size()-1).add(0);
    triangulos.get(triangulos.size()-1).add(1);
    triangulos.get(triangulos.size()-1).add(2);

    for (int i = 1; i <= subdivisoes; i++) {
      int t = triangulos.size();
      for (int j = 0; j < t; j++) {
        if (triangulos.get(j).size() == 3) {
          triangulos.addAll(expandirTriangulo(pontos, triangulos.get(j), triangulos));
        }
      }
      if (i == 1 && triangulos.size() > 1) {
        triangulos.remove(0);
      }
    }

    // Mantém apenas os triângulos "folha" (faces válidas)
    ArrayList<ArrayList<Integer>> triangulosOctante = new ArrayList();
    for (ArrayList<Integer> tri : triangulos) {
      if (tri.size() == 3) triangulosOctante.add(tri);
    }

    // ---- Reflexão do octante para os outros 7, montando a esfera completa ----
    ArrayList<PVector> pontosEsfera = new ArrayList();
    ArrayList<ArrayList<Integer>> triangulosEsfera = new ArrayList();
    HashMap<String, Integer> mapaPontos = new HashMap();

    int[][] sinais = {
      { 1, 1, 1},
      {-1, 1, 1},
      { 1, -1, 1},
      { 1, 1, -1},
      {-1, -1, 1},
      {-1, 1, -1},
      { 1, -1, -1},
      {-1, -1, -1}
    };

    for (int[] s : sinais) {
      int negativos = 0;
      for (int v : s) if (v < 0) negativos++;
      boolean inverter = (negativos % 2 == 1);

      int[] mapaIndices = new int[pontos.size()];
      for (int i = 0; i < pontos.size(); i++) {
        PVector p = pontos.get(i);
        PVector pr = new PVector(s[0]*p.x, s[1]*p.y, s[2]*p.z);
        String chave = chavePonto(pr);
        Integer idx = mapaPontos.get(chave);
        if (idx == null) {
          idx = pontosEsfera.size();
          pontosEsfera.add(pr);
          mapaPontos.put(chave, idx);
        }
        mapaIndices[i] = idx;
      }

      for (ArrayList<Integer> tri : triangulosOctante) {
        int a = mapaIndices[tri.get(0)];
        int b = mapaIndices[tri.get(1)];
        int c = mapaIndices[tri.get(2)];
        ArrayList<Integer> novaFace = new ArrayList();
        if (inverter) {
          novaFace.add(a);
          novaFace.add(c);
          novaFace.add(b);
        } else {
          novaFace.add(a);
          novaFace.add(b);
          novaFace.add(c);
        }
        triangulosEsfera.add(novaFace);
      }
    }
    return new ArrayList[]{pontosEsfera, triangulosEsfera};
  }

  // gera uma chave textual arredondada para "soldar" pontos que coincidem
  // entre octantes vizinhos (evita vértices duplicados nas bordas)
  String chavePonto(PVector p) {
    float f = 100000;
    int x = round(p.x*f);
    int y = round(p.y*f);
    int z = round(p.z*f);
    return x+","+y+","+z;
  }

  ArrayList<ArrayList<Integer>> expandirTriangulo(ArrayList<PVector> pontos, ArrayList<Integer> triangulo, ArrayList<ArrayList<Integer>> triangulos) {
    ArrayList<ArrayList<Integer>> triangulosTotais = new ArrayList();

    for (int i = 0; i < triangulo.size(); i += 2) {
      int indice = (i == triangulo.size()-1 ? 0 : i+1);
      PVector Pm = new PVector(
        (pontos.get(triangulo.get(i)).x + pontos.get(triangulo.get(indice)).x)/2,
        (pontos.get(triangulo.get(i)).y + pontos.get(triangulo.get(indice)).y)/2,
        (pontos.get(triangulo.get(i)).z + pontos.get(triangulo.get(indice)).z)/2
        );
      float comprimento = sqrt(Pm.x*Pm.x + Pm.y*Pm.y + Pm.z*Pm.z);

      Pm.x = Pm.x/comprimento;
      Pm.y = Pm.y/comprimento;
      Pm.z = Pm.z/comprimento;
      pontos.add(Pm);
      triangulo.add(indice, pontos.size()-1);
    }

    for (int i = 1; i < triangulo.size(); i += 2) {
      ArrayList t = new ArrayList();
      int indice = (i == triangulo.size()-1 ? 0 : i+1);
      t.add(triangulo.get(i));
      t.add(triangulo.get(indice));
      t.add(triangulo.get(i-1));
      triangulosTotais.add(t);
    }
    ArrayList t = new ArrayList();
    t.add(triangulo.get(0));
    t.add(triangulo.get(2));
    t.add(triangulo.get(4));

    triangulosTotais.add(t);

    return triangulosTotais;
  }
  ArrayList[] gerarCone(float raio, float z) {
    ArrayList<PVector> pontos = gerarElipse(30, raio, raio, 0);
    float xc = 0;
    float yc = 0;
    ArrayList<ArrayList<Integer>> faces = new ArrayList();
    for (PVector p : pontos) {
      xc += p.x;
      yc += p.y;
    }
    pontos.add(new PVector(xc/pontos.size(), yc/pontos.size(), z));
    faces.add(new ArrayList());
    faces.get(faces.size()-1).add(0);
    for (int i = 1; i < pontos.size()-1; i++) {
      faces.get(faces.size()-1).add(i);
    }

    for (int i = 0; i < pontos.size()-1; i++) {
      int indice = i == pontos.size()-2?0:i+1;
      faces.add(new ArrayList());
      faces.get(faces.size()-1).add(i);
      faces.get(faces.size()-1).add(indice);
      faces.get(faces.size()-1).add(pontos.size()-1);
    }
    return new ArrayList[]{pontos, faces};
  }
  ArrayList<PVector> curvaDeBezier(PVector [] pontos, int quantidadePontos) {

    ArrayList<ArrayList<PVector>> retas = new ArrayList();
    for (int i = 1; i < pontos.length; i++) {
      retas.add(new ArrayList());
      for (float j = 0; j <= quantidadePontos; j++) {
        float t = j/quantidadePontos;
        PVector p = new PVector();
        p.x = (1-t)*pontos[i-1].x + t*pontos[i].x;
        p.y = (1-t)*pontos[i-1].y + t*pontos[i].y;
        p.z = (1-t)*pontos[i-1].z + t*pontos[i].z;
        retas.get(retas.size()-1).add(p);
      }
    }

    return interpolarPontos(retas);
  }
  ArrayList<PVector> interpolarPontos(ArrayList<ArrayList<PVector>> retas) {
    if (retas.size() == 1)return retas.get(0);

    ArrayList<ArrayList<PVector>> retasInterpoladas = new ArrayList();

    for (int i = 1; i < retas.size(); i++) {
      retasInterpoladas.add(new ArrayList());
      int qtdPnts = retas.get(0).size();
      for (int j = 0; j < qtdPnts; j++) {
        float t = (float)j/qtdPnts;
        PVector p = new PVector();
        p.x = (1-t)*retas.get(i-1).get(j).x + t*retas.get(i).get(j).x;
        p.y = (1-t)*retas.get(i-1).get(j).y + t*retas.get(i).get(j).y;
        p.z = (1-t)*retas.get(i-1).get(j).z + t*retas.get(i).get(j).z;

        retasInterpoladas.get(retasInterpoladas.size()-1).add(p);
      }
    }
    retas.clear();
    return interpolarPontos(retasInterpoladas);
  }
  void projecaoRadial(ArrayList<PVector>pontos, float R, float fatorAbertura, float offsetTheta, float offsetPhi) {
    for (PVector p2d : pontos) {

      float theta = (p2d.x * fatorAbertura) + offsetTheta;


      float phi = (-p2d.y * fatorAbertura) + offsetPhi;


      p2d.x = R * sin(theta) * cos(phi);
      p2d.y = R * sin(phi);
      p2d.z = R * cos(theta) * cos(phi);
    }
  }
  void projecaoRadial2(ArrayList<PVector>pontos, float R) {

    for (PVector p : pontos) {

      p.z = R*10;
      p.normalize();
      p.mult(R);
    }
  }

  ArrayList[] gerarCilindro(float raio, float z) {
    ArrayList<PVector> pontos = gerarElipse(30, raio, raio, 0);

    ArrayList<ArrayList<Integer>> faces = new ArrayList();
    ArrayList<PVector> aux = new ArrayList();
    for (PVector p : pontos) {
      aux.add(new PVector(p.x, p.y, z));
    }
    pontos.addAll(aux);
    faces.add(new ArrayList());
    for (int i = 0; i < pontos.size()/2; i++) {
      faces.get(faces.size()-1).add(i);
    }

    faces.add(new ArrayList());
    for (int i = pontos.size()/2; i < pontos.size(); i++) {
      faces.get(faces.size()-1).add(i);
    }

    for (int i = 0; i < pontos.size()/2; i++) {
      int indice = i == pontos.size()/2-1?0:i+1;
      faces.add(new ArrayList());
      faces.get(faces.size()-1).add(i);
      faces.get(faces.size()-1).add(indice);
      faces.get(faces.size()-1).add(pontos.size()/2 + indice);
      faces.get(faces.size()-1).add(pontos.size()/2 + i);
    }
    return new ArrayList[]{pontos, faces};
  }

  void projecaoRadial2Palbebra(ArrayList<PVector>pontos, float R, float factorAbertura) {

    for (PVector p : pontos) {

      p.z = R*factorAbertura;
      p.normalize();
      p.mult(R);
    }
  }
  ArrayList<Integer> criarFace(int a, int b, int c) {
    ArrayList<Integer> f = new ArrayList();
    f.add(a);
    f.add(b);
    f.add(c);
    return f;
  }

  ArrayList<ArrayList<Integer>> subdividirPerna(ArrayList<PVector> vert, ArrayList<ArrayList<Integer>> faces, float raio) {
    ArrayList<ArrayList<Integer>> novas = new ArrayList();
    for (ArrayList<Integer> face : faces) {
      PVector u1 = vert.get(face.get(0));
      PVector u2 = vert.get(face.get(1));
      PVector u3 = vert.get(face.get(2));

      PVector v4 = PVector.add(u1, u2).div(2).normalize().mult(raio);
      PVector v5 = PVector.add(u2, u3).div(2).normalize().mult(raio);
      PVector v6 = PVector.add(u3, u1).div(2).normalize().mult(raio);

      int u4 = vert.size();
      vert.add(v4);
      int u5 = vert.size();
      vert.add(v5);
      int u6 = vert.size();
      vert.add(v6);

      novas.add(criarFace(face.get(0), u4, u6));
      novas.add(criarFace(u4, face.get(1), u5));
      novas.add(criarFace(face.get(2), u6, u5));
      novas.add(criarFace(u4, u5, u6));
    }
    return novas;
  }
  ArrayList[] gerarPerna(float raio, float alturaCone, int iteracoes) {
    ArrayList<PVector> vert = new ArrayList();
    ArrayList<ArrayList<Integer>> faces = new ArrayList();

    vert.add(new PVector(raio, 0, 0));
    vert.add(new PVector(0, raio, 0));
    vert.add(new PVector(0, 0, raio));
    vert.add(new PVector(-raio, 0, 0));
    vert.add(new PVector(0, -raio, 0));

    faces.add(criarFace(0, 1, 2));
    faces.add(criarFace(1, 3, 2));
    faces.add(criarFace(3, 4, 2));
    faces.add(criarFace(4, 0, 2));

    for (int i = 0; i < iteracoes; i++) {
      faces = subdividirPerna(vert, faces, raio);
    }

    int apice = vert.size();
    vert.add(new PVector(0, 0, -alturaCone));

    ArrayList<Integer> anel = new ArrayList();
    for (int i = 0; i < vert.size(); i++) {
      if (abs(vert.get(i).z) < 0.0001) anel.add(i);
    }

    anel.sort((a, b) -> {
      float angA = atan2(vert.get(a).y, vert.get(a).x);
      float angB = atan2(vert.get(b).y, vert.get(b).x);
      return Float.compare(angA, angB);
    }
    );

    int n = anel.size();
    for (int i = 0; i < n; i++) {
      int atual = anel.get(i);
      int prox = anel.get((i + 1) % n);
      faces.add(criarFace(atual, apice, prox));
    }

    return new ArrayList[]{vert, faces};
  }

  ArrayList<PVector> CatmullRomSpline(PVector[] ptsC) {
    ArrayList<PVector> pontos = new ArrayList();
    int inic = 0, fim = 3;
    for (; fim < ptsC.length; fim++) {
      println("inic = "+inic+" fim = "+ fim);
      pontos.addAll(CatmullRomSplineSEG(ptsC, 100, inic));
      inic++;
    }

    return pontos;
  }
  ArrayList<PVector> CatmullRomSplineSEG(PVector[] ptsC, int qntPontos, int inic ) {
    ArrayList<PVector> pontos = new ArrayList();
    for (float i = 0; i <= qntPontos; i++) {
      float t = i/qntPontos;
      PVector p = new PVector();
      p.x = 0.5*(2*ptsC[inic+1].x + (-ptsC[inic].x + ptsC[inic+2].x)*t + (2*ptsC[inic].x - 5*ptsC[inic+1].x + 4 * ptsC[inic+2].x - ptsC[inic+3].x)*(t*t) + (-ptsC[inic].x + 3*ptsC[inic+1].x - 3*ptsC[inic+2].x + ptsC[inic+3].x)*(t*t*t));
      p.y = 0.5*(2*ptsC[inic+1].y + (-ptsC[inic].y + ptsC[inic+2].y)*t + (2*ptsC[inic].y - 5*ptsC[inic+1].y + 4 * ptsC[inic+2].y - ptsC[inic+3].y)*(t*t) + (-ptsC[inic].y + 3*ptsC[inic+1].y - 3*ptsC[inic+2].y + ptsC[inic+3].y)*(t*t*t));
      p.z = 0.5*(2*ptsC[inic+1].z + (-ptsC[inic].z + ptsC[inic+2].z)*t + (2*ptsC[inic].z - 5*ptsC[inic+1].z + 4 * ptsC[inic+2].z - ptsC[inic+3].z)*(t*t) + (-ptsC[inic].z + 3*ptsC[inic+1].z - 3*ptsC[inic+2].z + ptsC[inic+3].z)*(t*t*t));
      pontos.add(p);
    }

    return pontos;
  }
  ArrayList<PVector> gerarSolido(ArrayList<PVector> pts, float anguloInc) {
    ArrayList<PVector> pontos = new ArrayList();
    pontos.addAll(pts);
    for (float i = anguloInc; i < 360; i += anguloInc) {
      ArrayList<PVector> pn = new ArrayList();
      for (PVector p : pts) {
        pn.add(new PVector(p.x, p.y, p.z));
      }
      rotacao(pn, 'y', radians(i), new PVector(0, 0, 0));
      pontos.addAll(pn);
    }
    return pontos;
  }
  ArrayList<ArrayList<Integer>> gerarFacesF(int Qgrupos, int tamanhoGrupo) {
    ArrayList<ArrayList<Integer>> faces = new ArrayList();
    //int limit = 360 /30;
    for (int grps = 0; grps < Qgrupos; grps++) {
      int g = grps == Qgrupos-1?0:grps+1;
      for (int i = 0; i < tamanhoGrupo-1; i++) {
        faces.add(new ArrayList());
        faces.get(faces.size()-1).add((grps*tamanhoGrupo) + i);
        faces.get(faces.size()-1).add((grps*tamanhoGrupo) + i+1);

        faces.get(faces.size()-1).add(((g)*tamanhoGrupo) + i+1);

        faces.get(faces.size()-1).add(((g)*tamanhoGrupo) + i);
      }
    }
    return faces;
  }
}
