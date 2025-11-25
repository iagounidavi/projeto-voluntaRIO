import 'package:flutter/material.dart';

// --- TELA 1: MINHAS HORAS ---
class MinhasHorasScreen extends StatelessWidget {
  const MinhasHorasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Extrato de Horas"),
        backgroundColor: const Color(0xFF004D40), // Verde Unidavi
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // GRÁFICO DE PROGRESSO
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: 15 / 60, // 25% concluído
                    strokeWidth: 12,
                    backgroundColor: Colors.grey.shade300,
                    color: const Color(0xFF004D40),
                  ),
                ),
                const Column(
                  children: [
                    Text("15h", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
                    Text("de 60h", style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 40),
            
            // LISTA DE ATIVIDADES JÁ REALIZADAS
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Histórico de Atividades", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            _buildHistoryItem("Mutirão Rio Itajaí-Açu", "30/11/2024", "10h", true),
            _buildHistoryItem("Inclusão Digital Senior", "05/10/2024", "5h", true),
            _buildHistoryItem("Feira das Profissões", "12/09/2024", "4h", false), // Pendente
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String titulo, String data, String horas, bool validado) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(
          validado ? Icons.check_circle : Icons.access_time,
          color: validado ? Colors.green : Colors.orange,
        ),
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Data: $data • Status: ${validado ? 'Validado' : 'Em Análise'}"),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: validado ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(horas, style: TextStyle(fontWeight: FontWeight.bold, color: validado ? Colors.green : Colors.orange)),
        ),
      ),
    );
  }
}

// --- TELA 2: MEUS CERTIFICADOS ---
class MeusCertificadosScreen extends StatelessWidget {
  const MeusCertificadosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Certificados"),
        backgroundColor: const Color(0xFF004D40),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Certificados Disponíveis para Download",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 20),
          _buildCertificadoCard(context, "Certificado de Participação - Mutirão Ecológico", "Emitido em 01/12/2024"),
          _buildCertificadoCard(context, "Declaração de Monitoria - Inclusão Digital", "Emitido em 06/10/2024"),
        ],
      ),
    );
  }

  Widget _buildCertificadoCard(BuildContext context, String titulo, String sub) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: const Icon(Icons.verified, size: 40, color: Color(0xFF004D40)),
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(sub),
        trailing: IconButton(
          icon: const Icon(Icons.download_rounded, color: Colors.blue),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Download do PDF iniciado..."), backgroundColor: Colors.green),
            );
          },
        ),
      ),
    );
  }
}