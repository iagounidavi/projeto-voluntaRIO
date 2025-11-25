import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gestão da Extensão"),
          backgroundColor: const Color(0xFF1565C0),
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.bar_chart), text: "Impacto"),
              Tab(icon: Icon(Icons.people), text: "Voluntários"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _AbaRelatorios(),
            _AbaVoluntarios(),
          ],
        ),
      ),
    );
  }
}

// --- ABA 1: RELATÓRIOS ---
class _AbaRelatorios extends StatelessWidget {
  const _AbaRelatorios();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("Indicadores de 2025", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 20),
        
        // Cards de Estatísticas
        Row(
          children: [
            _buildStatCard("Vidas Impactadas", "1.250", Colors.orange),
            const SizedBox(width: 10),
            _buildStatCard("Horas Totais", "480h", Colors.green),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildStatCard("Projetos Ativos", "5", Colors.blue),
            const SizedBox(width: 10),
            _buildStatCard("Parceiros", "12", Colors.purple),
          ],
        ),

        const SizedBox(height: 30),
        const Text("Meta de ODS (Objetivos Sustentáveis)", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        
        // Barras de Progresso Simuladas
        _buildProgressBar("ODS 4 - Educação de Qualidade", 0.8),
        _buildProgressBar("ODS 11 - Cidades Sustentáveis", 0.6),
        _buildProgressBar("ODS 3 - Saúde e Bem-Estar", 0.9),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withOpacity(0.5))),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
            Text(title, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(String label, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 5),
          LinearProgressIndicator(value: value, color: const Color(0xFF1565C0), backgroundColor: Colors.grey[200], minHeight: 10),
        ],
      ),
    );
  }
}

// --- ABA 2: VOLUNTÁRIOS ---
class _AbaVoluntarios extends StatelessWidget {
  const _AbaVoluntarios();

  @override
  Widget build(BuildContext context) {
    final alunos = [
      {"nome": "Ana Silva", "curso": "Direito", "status": "Em Campo"},
      {"nome": "João Souza", "curso": "Eng. Civil", "status": "Disponível"},
      {"nome": "Marcos Paulo", "curso": "Sistemas", "status": "Em Campo"},
      {"nome": "Júlia Ribeiro", "curso": "Medicina", "status": "Disponível"},
      {"nome": "Carlos Bauner", "curso": "Psicologia", "status": "Pendente"},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: alunos.length,
      itemBuilder: (ctx, i) {
        final a = alunos[i];
        final isCampo = a['status'] == "Em Campo";
        
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isCampo ? Colors.green : Colors.grey,
              child: const Icon(Icons.person, color: Colors.white),
            ),
            title: Text(a['nome']!),
            subtitle: Text(a['curso']!),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isCampo ? Colors.green[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(a['status']!, style: TextStyle(fontSize: 12, color: isCampo ? Colors.green[800] : Colors.black)),
            ),
          ),
        );
      },
    );
  }
}