import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/projetos_provider.dart';
import '../utils/imagens_seguras.dart';

class MapaScreen extends StatelessWidget {
  const MapaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projetos = Provider.of<ProjetosProvider>(context).projetos;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Fundo do Mapa (LOCAL)
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ColorFiltered(
              // CORREÇÃO: Usando withValues(alpha: ...) em vez de withOpacity
              colorFilter: ColorFilter.mode(Colors.white.withValues(alpha: 0.2), BlendMode.lighten),
              child: Image.asset(
                ImagensSeguras.mapaBackground, 
                fit: BoxFit.cover,
                // Se der erro (arquivo não existe), mostra um aviso feio para você saber
                errorBuilder: (ctx, err, stack) => Container(
                  color: Colors.grey, 
                  child: const Center(child: Text("ERRO: Adicione 'mapa.jpg' na pasta assets/images", textAlign: TextAlign.center))
                ),
              ),
            ),
          ),
          
          Positioned(
            top: 40, left: 20, right: 20,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: const [
                    Icon(Icons.map, color: Color(0xFF004D40)), // Verde UNIDAVI
                    SizedBox(width: 10),
                    Text("Projetos em Rio do Sul", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),

          ...projetos.map((proj) {
            return Positioned(
              // Lógica para espalhar os pinos na tela sem sair das bordas
              top: MediaQuery.of(context).size.height * (0.2 + (proj.lat * 0.6)),
              left: MediaQuery.of(context).size.width * (0.1 + (proj.lng * 0.8)),
              child: GestureDetector(
                onTap: () {
                   showModalBottomSheet(
                    context: context,
                    builder: (_) => Container(
                      height: 200,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(proj.titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 5),
                          Row(children: [
                            const Icon(Icons.location_on, size: 14, color: Colors.grey),
                            Text(proj.local, style: const TextStyle(color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          Text("${proj.horas} horas complementares", style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF004D40), foregroundColor: Colors.white),
                              child: const Text("Ver Detalhes"),
                            ),
                          )
                        ],
                      ),
                    ),
                   );
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white, 
                        borderRadius: BorderRadius.circular(4), 
                        border: Border.all(color: const Color(0xFF004D40))
                      ),
                      child: Text(proj.titulo, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                    const Icon(Icons.location_on, color: Color(0xFFC62828), size: 45),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}