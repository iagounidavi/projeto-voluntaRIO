import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/projetos_provider.dart';

class ListaProjetosScreen extends StatelessWidget {
  const ListaProjetosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProjetosProvider>(context);
    final projetos = provider.projetos;
    final isAluno = provider.isAluno;
    final cor = provider.corPrincipal;

    return Column(
      children: [
        // PAINEL DE STATUS (Diferencial)
        Container(
          padding: const EdgeInsets.all(20),
          color: cor.withOpacity(0.1),
          child: Row(
            children: [
              Icon(isAluno ? Icons.emoji_events : Icons.analytics, size: 40, color: cor),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(isAluno ? "Horas Complementares" : "Impacto Social", 
                    style: TextStyle(fontWeight: FontWeight.bold, color: cor, fontSize: 16)),
                  Text(isAluno ? "15h / 60h Cumpridas" : "3 Projetos Ativos | 45 Voluntários",
                    style: const TextStyle(fontSize: 14)),
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: projetos.length,
            itemBuilder: (ctx, i) {
              final proj = projetos[i];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(
                        proj.imagemUrl,
                        height: 140, 
                        width: double.infinity, 
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      title: Text(proj.titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("${proj.eixo}\n${proj.local} • ${proj.data}"),
                      trailing: isAluno 
                        ? IconButton(
                            icon: Icon(proj.inscrito ? Icons.check_circle : Icons.add_circle_outline, color: proj.inscrito ? Colors.green : Colors.grey, size: 30),
                            onPressed: () => provider.toggleInscricao(proj.id),
                          )
                        : IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {}, // Edição mockada
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}