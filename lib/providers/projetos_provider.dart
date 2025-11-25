import 'package:flutter/material.dart';
import '../models/projeto.dart';
import '../utils/imagens_seguras.dart';

class ProjetosProvider with ChangeNotifier {
  bool isAluno = true;

  // Mudança de identidade visual
  Color get corPrincipal => isAluno ? const Color(0xFF004D40) : const Color(0xFF1565C0); // Verde UNIDAVI vs Azul Coordenação
  
  // Mudança de Texto: ONG -> Coordenação
  String get nomePerfil => isAluno ? "Acadêmico UNIDAVI" : "Coordenação de Extensão";

  final List<Projeto> _projetos = [
    // PROJETO 1
    Projeto(
      id: '1',
      titulo: "Mutirão Rio Itajaí-Açu",
      descricao: "Limpeza das margens e recuperação da mata ciliar no bairro Barragem.",
      data: "30/11 - 08:00",
      local: "Ponte dos Arcos - RSL",
      eixo: "IV. Sustentabilidade",
      horas: 10,
      imagemUrl: ImagensSeguras.opcoes['Sustentabilidade']!,
      lat: 0.35, lng: 0.45,
    ),
    // PROJETO 2
    Projeto(
      id: '2',
      titulo: "História Viva no Museu",
      descricao: "Catalogação do acervo fotográfico da antiga estação ferroviária.",
      data: "02/12 - 14:00",
      local: "Museu Histórico - Centro",
      eixo: "I. Cultura e Arte",
      horas: 20,
      imagemUrl: ImagensSeguras.opcoes['Cultura e Arte']!,
      lat: 0.52, lng: 0.41,
    ),
    // PROJETO 3
    Projeto(
      id: '3',
      titulo: "Inclusão Digital Senior",
      descricao: "Monitoria de informática para terceira idade.",
      data: "05/12 - 13:30",
      local: "Unidavi - Bloco G",
      eixo: "VII. Educação Continuada",
      horas: 5,
      imagemUrl: ImagensSeguras.opcoes['Tecnologia']!,
      lat: 0.60, lng: 0.65,
    ),
    // --- NOVOS PROJETOS RIO DO SUL ---
    Projeto(
      id: '4',
      titulo: "Apoio Defesa Civil RSL",
      descricao: "Cadastro de famílias em áreas de risco e organização de donativos preventivos.",
      data: "10/12 - 09:00",
      local: "Defesa Civil - Jardim América",
      eixo: "III. Cidadania",
      horas: 30, // Carga horária alta atrai alunos
      imagemUrl: ImagensSeguras.opcoes['Defesa Civil']!,
      lat: 0.25, lng: 0.70,
    ),
    Projeto(
      id: '5',
      titulo: "Feira do Livro do Alto Vale",
      descricao: "Apoio logístico e contação de histórias para escolas visitantes.",
      data: "15/12 - 10:00",
      local: "Parque Universitário Unidavi",
      eixo: "I. Cultura e Arte",
      horas: 12,
      imagemUrl: ImagensSeguras.opcoes['Cultura e Arte']!,
      lat: 0.55, lng: 0.55,
    ),
  ];

  List<Projeto> get projetos => [..._projetos];
  List<Projeto> get favoritos => _projetos.where((p) => p.favorito).toList();

  void setUsuario(bool aluno) {
    isAluno = aluno;
    notifyListeners();
  }

  void adicionarProjeto(Projeto p) {
    _projetos.add(p);
    notifyListeners();
  }

  void toggleFavorito(String id) {
    final index = _projetos.indexWhere((p) => p.id == id);
    if (index >= 0) {
      _projetos[index].favorito = !_projetos[index].favorito;
      notifyListeners();
    }
  }

  void toggleInscricao(String id) {
    final index = _projetos.indexWhere((p) => p.id == id);
    if (index >= 0) {
      _projetos[index].inscrito = !_projetos[index].inscrito;
      notifyListeners();
    }
  }
}