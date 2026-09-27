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
      asa2Faces.get(asa2Faces.size()-1).add(i);
    }
  }
  void gerarCorpo() {
    ArrayList r[] = u.gerarEsfera(4);
    corpoPontos = (ArrayList<PVector>)r[0];
    u.scale(corpoPontos, new PVector(150, 100, 100));
    corpoFaces = (ArrayList<ArrayList<Integer>>)r[1];
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
    u.projecaoRadial2Palbebra(this.palpebra1Pontos,0.4f,150);
    
    
    int offset = this.olho1Pontos.size();
    for(int i = 0;i < this.palpebra1Faces.size();i++){
      for(int j = 0;j < this.palpebra1Faces.get(0).size();j++){
        this.palpebra1Faces.get(0).set(j,this.palpebra1Faces.get(0).get(j)+offset);
      }
    }
    u.rotacao(this.palpebra1Pontos,'x',30,new PVector(0,0,0));
    this.olho1Pontos.addAll(this.palpebra1Pontos);
    this.olho1Faces.addAll(this.palpebra1Faces);
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
  }
  void gerarNariz() {
    ArrayList r[] = u.gerarEsfera(4);
    narizPontos = (ArrayList<PVector>)r[0];
    narizFaces = (ArrayList<ArrayList<Integer>>)r[1];
    u.scale(this.narizPontos, new PVector(0.4f, 0.4f, 0.4f));
  }
  void gerarFerrao() {
    ArrayList r[] = u.gerarCone(10, 25);
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
    ArrayList[]r = gerarElipsoide(1f,1f,40,true);
    this.palpebra1Pontos = u.curvaDeBezier(labioSuperior, 100);
    this.palpebra1Pontos.addAll(u.curvaDeBezier(labioInferior, 100));
    ArrayList<Integer> face = new ArrayList();
    for (int i = 0; i < this.palpebra1Pontos.size(); i++) {
      face.add(i);
    }
    this.palpebra1Faces.add(face);
    u.reflexao(this.palpebra1Pontos, new PVector(1, -1, 1), new PVector(0, 0, 0));

    this.palpebra2Pontos = u.curvaDeBezier(labioSuperior, 100);
    this.palpebra2Pontos.addAll(u.curvaDeBezier(labioInferior, 100));
    face = new ArrayList();
    for (int i = 0; i < this.palpebra2Pontos.size(); i++) {
      face.add(i);
    }
    this.palpebra2Faces.add(face);
    u.reflexao(this.palpebra2Pontos, new PVector(1, -1, 1), new PVector(0, 0, 0));
  }
}
