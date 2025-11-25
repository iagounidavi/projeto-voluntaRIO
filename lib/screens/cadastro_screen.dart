import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/projetos_provider.dart';
import '../models/projeto.dart';
import '../utils/imagens_seguras.dart'; // Importante!

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descController = TextEditingController();
  final _dataController = TextEditingController();
  final _localController = TextEditingController();
  
  String _categoriaSelecionada = 'IV. Sustentabilidade';
  double _horasSelecionadas = 10;
  
  // NOVA VARIÁVEL: Armazena a imagem escolhida
  String _imagemSelecionada = ImagensSeguras.listaUrls[0]; 

  final List<String> _categorias = [
    'I. Cultura, História e Arte',
    'II. Desenvolvimento Regional',
    'III. Cidadania',
    'IV. Sustentabilidade',
    'VII. Educação Continuada',
  ];

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final random = Random();
    
    final novoProjeto = Projeto(
      id: DateTime.now().toString(),
      titulo: _tituloController.text,
      descricao: _descController.text,
      data: _dataController.text,
      local: _localController.text,
      eixo: _categoriaSelecionada,
      horas: _horasSelecionadas.toInt(),
      imagemUrl: _imagemSelecionada, // Usa a imagem escolhida
      lat: random.nextDouble(), // Posição aleatória no mapa
      lng: random.nextDouble(),
    );

    Provider.of<ProjetosProvider>(context, listen: false).adicionarProjeto(novoProjeto);
    Navigator.of(context).pop(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Demanda')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // SEÇÃO DE IMAGEM (NOVIDADE)
            const Text("Escolha a Capa do Projeto:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ImagensSeguras.listaUrls.length,
                itemBuilder: (ctx, i) {
                  final url = ImagensSeguras.listaUrls[i];
                  final isSelected = _imagemSelecionada == url;
                  
                  return GestureDetector(
                    onTap: () => setState(() => _imagemSelecionada = url),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        border: isSelected ? Border.all(color: Colors.teal, width: 3) : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Stack(
                          children: [
                            Image.asset(url, width: 100, height: 100, fit: BoxFit.cover),
                            if (isSelected)
                              Container(
                                width: 100, height: 100,
                                color: Colors.black26,
                                child: const Icon(Icons.check_circle, color: Colors.white),
                              )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Campos de Texto normais...
            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título', border: OutlineInputBorder()),
              validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Descrição', border: OutlineInputBorder()),
              maxLines: 2,
              validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: TextFormField(controller: _dataController, decoration: const InputDecoration(labelText: 'Data', border: OutlineInputBorder()))),
                const SizedBox(width: 10),
                Expanded(child: TextFormField(controller: _localController, decoration: const InputDecoration(labelText: 'Local', border: OutlineInputBorder()))),
              ],
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              value: _categoriaSelecionada,
              isExpanded: true,
              items: _categorias.map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 12)))).toList(),
              onChanged: (v) => setState(() => _categoriaSelecionada = v.toString()),
              decoration: const InputDecoration(labelText: 'Eixo', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white, padding: const EdgeInsets.all(15)),
              child: const Text('PUBLICAR PROJETO'),
            ),
          ],
        ),
      ),
    );
  }
}