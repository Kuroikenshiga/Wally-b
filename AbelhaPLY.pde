class AbelhaPLY {

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

  ArrayList<PVector> bocaPontos = new ArrayList();
  ArrayList<ArrayList<Integer>> bocaFaces = new ArrayList();

  ArrayList<PVector> palpebra1Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> palpebra1Faces = new ArrayList();

  ArrayList<PVector> palpebra2Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> palpebra2Faces = new ArrayList();

  ArrayList<PVector> perna1Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> perna1Faces = new ArrayList();

  ArrayList<PVector> perna2Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> perna2Faces = new ArrayList();

  ArrayList<PVector> perna3Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> perna3Faces = new ArrayList();

  ArrayList<PVector> perna4Pontos = new ArrayList();
  ArrayList<ArrayList<Integer>> perna4Faces = new ArrayList();

  private Utilitarios u = new Utilitarios();

  void gerarAsas() {
    asa1Pontos = u.gerarElipse(30, 10, 20, 0);
    asa2Pontos = u.gerarElipse(30, 10, 20, 0);

    asa1Faces.add(new ArrayList());
    asa1Faces.get(asa1Faces.size()-1).add(0);

    asa2Faces.add(new ArrayList());
    asa2Faces.get(asa2Faces.size()-1).add(0);

    for (int i = 1; i < asa1Pontos.size(); i++) {
      asa1Faces.get(asa1Faces.size()-1).add(i);
      asa2Faces.get(asa2Faces.size()-1).add(asa1Pontos.size()-1 - i);
    }
  }

  void gerarCorpo() {
    ArrayList r[] = u.gerarEsfera(4);
    corpoPontos = (ArrayList<PVector>)r[0];
    u.scale(corpoPontos, new PVector(150, 120, 120));
    corpoFaces = (ArrayList<ArrayList<Integer>>)r[1];

    gerarAsas();

    int offset = corpoPontos.size();

    for (int i = 0; i < this.asa1Faces.size(); i++) {
      for (int j = 0; j < this.asa1Faces.get(i).size(); j++) {
        this.asa1Faces.get(i).set(j, this.asa1Faces.get(i).get(j)+offset);
      }
    }

    u.rotacao(asa1Pontos, 'y', radians(45), new PVector(0, 0, 0));
    u.rotacao(asa1Pontos, 'x', radians(-45), new PVector(0, 0, 0));
    u.translacao(asa1Pontos, -0, 25, -20);
    u.scale(asa1Pontos, new PVector(7, 7, 7));
    corpoPontos.addAll(asa1Pontos);
    corpoFaces.addAll(asa1Faces);

    //Segunda asa

    offset = corpoPontos.size();

    for (int i = 0; i < this.asa2Faces.size(); i++) {
      for (int j = 0; j < this.asa2Faces.get(i).size(); j++) {
        this.asa2Faces.get(i).set(j, this.asa2Faces.get(i).get(j)+offset);
      }
    }

    for (int i = 0; i< this.asa1Pontos.size(); i++) {
      this.asa2Pontos.set(i, PVector.mult(this.asa1Pontos.get(i), -1));
      this.asa2Pontos.get(i).y *= -1;
      this.asa2Pontos.get(i).x *= -1;
    }
    corpoPontos.addAll(asa2Pontos);
    corpoFaces.addAll(asa2Faces);

    gerarFerrao(20, 300);
    offset = corpoPontos.size();

    for (int i = 0; i < this.ferraoFaces.size(); i++) {
      for (int j = 0; j < this.ferraoFaces.get(i).size(); j++) {
        this.ferraoFaces.get(i).set(j, this.ferraoFaces.get(i).get(j)+offset);
      }
    }
    u.rotacao(ferraoPontos, 'y', radians(-90), new PVector());
    u.translacao(ferraoPontos, -130, -30, 0);

    corpoPontos.addAll(ferraoPontos);
    corpoFaces.addAll(ferraoFaces);

    gerarCabeca();
    offset = corpoPontos.size();

    for (int i = 0; i < this.cabecaFaces.size(); i++) {
      for (int j = 0; j < this.cabecaFaces.get(i).size(); j++) {
        this.cabecaFaces.get(i).set(j, this.cabecaFaces.get(i).get(j)+offset);
      }
    }
    corpoPontos.addAll(cabecaPontos);
    corpoFaces.addAll(cabecaFaces);
    u.scale(cabecaPontos, new PVector(70, 70, 70));
    u.rotacao(cabecaPontos, 'y', radians(90), new PVector());
    u.translacao(cabecaPontos, 170, -40, 0);

    gerarPernas();
    offset = corpoPontos.size();

    for (int i = 0; i < this.perna1Faces.size(); i++) {
      for (int j = 0; j < this.perna1Faces.get(i).size(); j++) {
        this.perna1Faces.get(i).set(j, this.perna1Faces.get(i).get(j)+offset);
      }
    }
    u.scale(perna1Pontos, new PVector(0.5, -0.5, 0.5));
    u.rotacao(perna1Pontos,'z',radians(45),new PVector());
    u.translacao(perna1Pontos,60,-130,-35);
    corpoPontos.addAll(perna1Pontos);
    corpoFaces.addAll(perna1Faces);
    
    //perna 2
    offset = corpoPontos.size();
    for (int i = 0; i < this.perna2Faces.size(); i++) {
      for (int j = 0; j < this.perna2Faces.get(i).size(); j++) {
        this.perna2Faces.get(i).set(j, this.perna2Faces.get(i).get(j)+offset);
      }
    }
    u.scale(perna2Pontos, new PVector(0.5, -0.5, 0.5));
    u.rotacao(perna2Pontos,'z',radians(45),new PVector());
    u.translacao(perna2Pontos,60,-130,35);
    corpoPontos.addAll(perna2Pontos);
    corpoFaces.addAll(perna2Faces);
    
    //perna 3
    offset = corpoPontos.size();
    for (int i = 0; i < this.perna3Faces.size(); i++) {
      for (int j = 0; j < this.perna3Faces.get(i).size(); j++) {
        this.perna3Faces.get(i).set(j, this.perna3Faces.get(i).get(j)+offset);
      }
    }
    u.scale(perna3Pontos, new PVector(0.5, -0.5, 0.5));
    u.rotacao(perna3Pontos,'z',radians(-30),new PVector());
    u.translacao(perna3Pontos,-10,-130,35);
    corpoPontos.addAll(perna3Pontos);
    corpoFaces.addAll(perna3Faces);
    
     //perna 4
    offset = corpoPontos.size();
    for (int i = 0; i < this.perna4Faces.size(); i++) {
      for (int j = 0; j < this.perna4Faces.get(i).size(); j++) {
        this.perna4Faces.get(i).set(j, this.perna4Faces.get(i).get(j)+offset);
      }
    }
    u.scale(perna4Pontos, new PVector(0.5, -0.5, 0.5));
    u.rotacao(perna4Pontos,'z',radians(-30),new PVector());
    u.translacao(perna4Pontos,-10,-130,-35);
    corpoPontos.addAll(perna4Pontos);
    corpoFaces.addAll(perna4Faces);
  }
  void gerarOlhos() {
    ArrayList r[] = u.gerarEsfera(4);
    this.olho1Pontos = (ArrayList<PVector>)r[0];
    this.olho1Faces = (ArrayList<ArrayList<Integer>>)r[1];

    u.scale(this.olho1Pontos, new PVector(0.4f, 0.4f, 0.4f));

    r = u.gerarEsfera(4);
    olho2Pontos = (ArrayList<PVector>)r[0];
    olho2Faces = (ArrayList<ArrayList<Integer>>)r[1];
    u.scale(this.olho2Pontos, new PVector(0.4f, 0.4f, 0.4f));

    gerarPalpebra();

    u.scale(palpebra1Pontos, new PVector(0.42f, 0.42f, 0.45f));

    int offset = this.olho1Pontos.size();
    this.olho1Pontos.addAll(this.palpebra1Pontos);

    for (int i = 0; i < this.palpebra1Faces.size(); i++) {
      for (int j = 0; j < this.palpebra1Faces.get(i).size(); j++) {
        this.palpebra1Faces.get(i).set(j, this.palpebra1Faces.get(i).get(j)+offset);
      }
    }
    u.rotacao(palpebra1Pontos, 'x', radians(-130), new PVector());
    this.olho1Faces.addAll(this.palpebra1Faces);
    r = u.gerarEsfera(4);

    ArrayList<PVector> iris1P = (ArrayList<PVector>)r[0];
    u.scale(iris1P, new PVector(0.2f, 0.2f, 0.2f));
    offset = olho1Pontos.size();
    this.olho1Pontos.addAll(iris1P);
    u.translacao(iris1P, 0, 0, 0.25);
    ArrayList<ArrayList<Integer>> iris1F = (ArrayList<ArrayList<Integer>>)r[1];
    for (int i = 0; i < iris1F.size(); i++) {
      for (int j = 0; j < iris1F.get(i).size(); j++) {
        iris1F.get(i).set(j, iris1F.get(i).get(j)+offset);
      }
    }
    this.olho1Faces.addAll(iris1F);
    //Segunda palpebra
    u.scale(palpebra2Pontos, new PVector(0.42f, 0.42f, 0.45f));

    offset = this.olho2Pontos.size();
    this.olho2Pontos.addAll(this.palpebra2Pontos);

    for (int i = 0; i < this.palpebra2Faces.size(); i++) {
      for (int j = 0; j < this.palpebra2Faces.get(i).size(); j++) {
        this.palpebra2Faces.get(i).set(j, this.palpebra2Faces.get(i).get(j)+offset);
      }
    }
    u.rotacao(palpebra2Pontos, 'x', radians(-130), new PVector());
    this.olho2Faces.addAll(this.palpebra2Faces);

    r = u.gerarEsfera(4);

    iris1P = (ArrayList<PVector>)r[0];
    u.scale(iris1P, new PVector(0.2f, 0.2f, 0.2f));
    offset = olho2Pontos.size();
    this.olho2Pontos.addAll(iris1P);
    u.translacao(iris1P, 0, 0, 0.25);
    iris1F = (ArrayList<ArrayList<Integer>>)r[1];
    for (int i = 0; i < iris1F.size(); i++) {
      for (int j = 0; j < iris1F.get(i).size(); j++) {
        iris1F.get(i).set(j, iris1F.get(i).get(j)+offset);
      }
    }
    this.olho2Faces.addAll(iris1F);
  }
  void gerarCabeca() {
    ArrayList r[] = u.gerarEsfera(4);
    this.cabecaPontos = (ArrayList<PVector>)r[0];
    this.cabecaFaces = (ArrayList<ArrayList<Integer>>)r[1];

    //olho direito
    int offset = this.cabecaPontos.size();
    gerarOlhos();

    for (int i = 0; i < this.olho1Faces.size(); i++) {

      for (int j = 0; j < this.olho1Faces.get(i).size(); j++) {
        this.olho1Faces.get(i).set(j, this.olho1Faces.get(i).get(j)+offset);
      }
    }

    this.cabecaPontos.addAll(this.olho1Pontos);
    this.cabecaFaces.addAll(this.olho1Faces);

    //olho esquerdo
    offset = this.cabecaPontos.size();
    for (int i = 0; i < this.olho2Faces.size(); i++) {

      for (int j = 0; j < this.olho2Faces.get(i).size(); j++) {
        this.olho2Faces.get(i).set(j, this.olho2Faces.get(i).get(j)+offset);
      }
    }
    this.cabecaPontos.addAll(this.olho2Pontos);
    this.cabecaFaces.addAll(this.olho2Faces);

    gerarNariz();
    //Nariz
    offset = this.cabecaPontos.size();
    for (int i = 0; i < this.narizFaces.size(); i++) {

      for (int j = 0; j < this.narizFaces.get(i).size(); j++) {
        this.narizFaces.get(i).set(j, this.narizFaces.get(i).get(j)+offset);
      }
    }
    this.cabecaPontos.addAll(this.narizPontos);
    this.cabecaFaces.addAll(this.narizFaces);

    u.translacao(this.olho1Pontos, 0.3f, 0.2f, 0.8f);
    u.translacao(this.olho2Pontos, -0.3f, 0.2f, 0.8f);
    u.translacao(this.narizPontos, -0f, -0.38f, 1.07f);
    gerarBoca();

    u.projecaoRadial(this.bocaPontos, 1, 0.006, 0.0, -0.6);


    offset = this.cabecaPontos.size();
    for (int i = 0; i < this.bocaFaces.size(); i++) {

      for (int j = 0; j < this.bocaFaces.get(i).size(); j++) {
        this.bocaFaces.get(i).set(j, this.bocaFaces.get(i).get(j)+offset);
      }
    }

    cabecaPontos.addAll(this.bocaPontos);
    cabecaFaces.addAll(this.bocaFaces);

    gerarAntenas(0.08, 0.5);
    u.translacao(antena1Pontos, 0, 0, 1.6);
    u.rotacao(antena1Pontos, 'z', radians(-90), new PVector());
    u.rotacao(antena1Pontos, 'x', radians(-40), new PVector());
    u.rotacao(antena1Pontos, 'y', radians(-30), new PVector());
    offset = this.cabecaPontos.size();
    for (int i = 0; i < this.antena1Faces.size(); i++) {

      for (int j = 0; j < this.antena1Faces.get(i).size(); j++) {
        this.antena1Faces.get(i).set(j, this.antena1Faces.get(i).get(j)+offset);
      }
    }

    cabecaPontos.addAll(this.antena1Pontos);
    cabecaFaces.addAll(this.antena1Faces);
    u.rotacao(antena2Pontos, 'z', radians(-45), new PVector(0, 0, 0));
    u.translacao(antena2Pontos, 0.5, 0.09, 1.8);
    //u.rotacao(antena2Pontos, 'z', radians(20), new PVector(0,0,0));
    u.rotacao(antena2Pontos, 'x', radians(-40), new PVector());
    //u.rotacao(antena2Pontos, 'y', radians(10), new PVector());

    offset = this.cabecaPontos.size();
    for (int i = 0; i < this.antena2Faces.size(); i++) {

      for (int j = 0; j < this.antena2Faces.get(i).size(); j++) {
        this.antena2Faces.get(i).set(j, this.antena2Faces.get(i).get(j)+offset);
      }
    }

    cabecaPontos.addAll(this.antena2Pontos);
    cabecaFaces.addAll(this.antena2Faces);
  }
  void gerarNariz() {
    ArrayList r[] = u.gerarEsfera(4);
    narizPontos = (ArrayList<PVector>)r[0];
    narizFaces = (ArrayList<ArrayList<Integer>>)r[1];
    u.scale(this.narizPontos, new PVector(0.4f, 0.4f, 0.4f));
  }
  void gerarFerrao(float raio, float z) {
    ArrayList r[] = u.gerarCone(raio, z);
    ferraoPontos = (ArrayList<PVector>)r[0];
    ferraoFaces = (ArrayList<ArrayList<Integer>>)r[1];
  }
  void gerarBoca() {
    // 1. Curva do Lábio Inferior (Curva mais funda)
    PVector[] labioInferior = {
      new PVector(-100, 0), // P0: Canto esquerdo
      new PVector(-50, 120), // P1: Controle 1 (puxa para baixo)
      new PVector(50, 120), // P2: Controle 2 (puxa para baixo)
      new PVector(100, 0)     // P3: Canto direito
    };

    // 2. Curva do Lábio Superior (Curva mais rasa de retorno)
    PVector[] labioSuperior = {
      new PVector(100, 0), // P3: Canto direito (ponto de partida do retorno)
      new PVector(30, 20), // P4: Controle 1 do retorno
      new PVector(-30, 20), // P5: Controle 2 do retorno
      new PVector(-100, 0)    // P0: Canto esquerdo (fecha no ponto inicial)
    };
    this.bocaPontos = u.curvaDeBezier(labioSuperior, 100);
    this.bocaPontos.addAll(u.curvaDeBezier(labioInferior, 100));
    ArrayList<Integer> face = new ArrayList();
    for (int i = 0; i < this.bocaPontos.size(); i++) {
      face.add(i);
    }
    this.bocaFaces.add(face);
    //u.reflexao(this.bocaPontos, new PVector(1, -1, 1), new PVector(0, 0, 0));
  }

  void gerarPalpebra() {

    ArrayList[]r = u.gerarElipsoide(1f, 1f, 40, true);

    this.palpebra1Pontos = (ArrayList<PVector>)r[0];
    this.palpebra1Faces = (ArrayList<ArrayList<Integer>>)r[1];

    r = u.gerarElipsoide(1f, 1f, 40, true);

    this.palpebra2Pontos = (ArrayList<PVector>)r[0];
    this.palpebra2Faces = (ArrayList<ArrayList<Integer>>)r[1];
  }

  void gerarAntenas(float raio, float z) {
    ArrayList[]r = u.gerarCilindro(raio*0.6, z*1.2);
    this.antena1Pontos = (ArrayList<PVector>)r[0];
    this.antena1Faces = (ArrayList<ArrayList<Integer>>)r[1];

    r = u.gerarEsfera(4);
    ArrayList<PVector> eP = (ArrayList<PVector>)r[0];
    ArrayList<ArrayList<Integer>> eF = (ArrayList<ArrayList<Integer>>)r[1];
    u.scale(eP, new PVector(raio, raio, raio));
    int offset = this.antena1Pontos.size();
    for (int i = 0; i < eF.size(); i++) {

      for (int j = 0; j < eF.get(i).size(); j++) {
        eF.get(i).set(j, eF.get(i).get(j)+offset);
      }
    }
    this.antena1Pontos.addAll(eP);
    this.antena1Faces.addAll(eF);
    u.translacao(eP, 0, 0, z*1.2);

    r = u.gerarCilindro(raio*0.6, z+z*1.6f);
    ArrayList<PVector>antena1PontosB = (ArrayList<PVector>)r[0];
    ArrayList<ArrayList<Integer>>antena1FacesB = (ArrayList<ArrayList<Integer>>)r[1];
    u.rotacao(antena1Pontos, 'y', radians(20), new PVector());
    u.translacao(antena1Pontos, -0.005, 0, 0.03);
    offset = this.antena1Pontos.size();
    this.antena1Pontos.addAll(antena1PontosB);
    for (int i = 0; i < antena1FacesB.size(); i++) {

      for (int j = 0; j < antena1FacesB.get(i).size(); j++) {
        antena1FacesB.get(i).set(j, antena1FacesB.get(i).get(j)+offset);
      }
    }
    this.antena1Faces.addAll(antena1FacesB);
    u.translacao(antena1PontosB, 0, 0, -1*(z+z*1.5f));
    //Antena 2


    r = u.gerarCilindro(raio*0.6, z*1.2);
    this.antena2Pontos = (ArrayList<PVector>)r[0];
    this.antena2Faces = (ArrayList<ArrayList<Integer>>)r[1];

    r = u.gerarEsfera(4);
    eP = (ArrayList<PVector>)r[0];
    eF = (ArrayList<ArrayList<Integer>>)r[1];
    u.scale(eP, new PVector(raio, raio, raio));
    offset = this.antena2Pontos.size();
    for (int i = 0; i < eF.size(); i++) {

      for (int j = 0; j < eF.get(i).size(); j++) {
        eF.get(i).set(j, eF.get(i).get(j)+offset);
      }
    }
    this.antena2Pontos.addAll(eP);
    this.antena2Faces.addAll(eF);
    u.translacao(eP, 0, 0, z*1.2);

    r = u.gerarCilindro(raio*0.6, z+z*1.6f);
    antena1PontosB = (ArrayList<PVector>)r[0];
    antena1FacesB = (ArrayList<ArrayList<Integer>>)r[1];
    u.rotacao(antena2Pontos, 'y', radians(20), new PVector());
    u.translacao(antena1Pontos, -0.005, 0, 0.03);
    offset = this.antena2Pontos.size();
    this.antena2Pontos.addAll(antena1PontosB);
    for (int i = 0; i < antena1FacesB.size(); i++) {

      for (int j = 0; j < antena1FacesB.get(i).size(); j++) {
        antena1FacesB.get(i).set(j, antena1FacesB.get(i).get(j)+offset);
      }
    }
    this.antena2Faces.addAll(antena1FacesB);
    u.translacao(antena1PontosB, 0, 0, -1*(z+z*1.5f));
  }

  void gerarPernas() {
    PVector[] pts = new PVector[]{
       new PVector(-15, 30),
  new PVector(0,   0),    // topo (ponta)
  new PVector(22,  30),
  new PVector(42,  65),
  new PVector(52,  100),  // bojo máximo
  new PVector(50,  130),  // era (46,135) → mantém raio mais alto, mais perto do bojo
  new PVector(35,  158),  // era (25,165) → mais largo e mais perto da base
  new PVector(0,   180),  // base (arredondada)
  new PVector(-35, 158),
     
    };
    ArrayList<PVector> pontos = u.CatmullRomSpline(pts);
    perna1Pontos = u.gerarSolido(pontos,30);
    u.scale(perna1Pontos,new PVector(1,1.2,1));
    perna1Faces = u.gerarFacesF(12,606);
    
    pontos = u.CatmullRomSpline(pts);
    perna2Pontos = u.gerarSolido(pontos,30);
    u.scale(perna2Pontos,new PVector(1,1.2,1));
    perna2Faces = u.gerarFacesF(12,606);
    
    pontos = u.CatmullRomSpline(pts);
    perna3Pontos = u.gerarSolido(pontos,30);
    u.scale(perna3Pontos,new PVector(1,1.2,1));
    perna3Faces = u.gerarFacesF(12,606);
    
    pontos = u.CatmullRomSpline(pts);
    perna4Pontos = u.gerarSolido(pontos,30);
    u.scale(perna4Pontos,new PVector(1,1.2,1));
    perna4Faces = u.gerarFacesF(12,606);
  }
}
