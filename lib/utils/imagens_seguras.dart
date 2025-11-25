class ImagensSeguras {
  static const String mapaBackground = "assets/images/mapa.png";

  static const Map<String, String> opcoes = {
    'Sustentabilidade': 'assets/images/sustentabilidade.png',
    'Cultura e Arte': 'assets/images/cultura.png',
    'Educação': 'assets/images/tecnologia.png',
    'Saúde/Idosos': 'assets/images/cidadania.png',
    'Tecnologia': 'assets/images/tecnologia.png',
    'Defesa Civil': 'assets/images/defesa.png',
  };

  static List<String> get listaUrls => opcoes.values.toList();
  
  static String getCategoria(String path) {
    return opcoes.keys.firstWhere((k) => opcoes[k] == path, orElse: () => 'Geral');
  }
}