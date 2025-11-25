class Projeto {
  final String id;
  final String titulo;
  final String descricao;
  final String data;
  final String local;
  final String eixo; 
  final int horas;
  final String imagemUrl;
  final double lat; 
  final double lng; 
  bool inscrito;
  bool favorito;

  Projeto({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.data,
    required this.local,
    required this.eixo,
    required this.horas,
    required this.imagemUrl,
    this.lat = 0.0,
    this.lng = 0.0,
    this.inscrito = false,
    this.favorito = false,
  });
}