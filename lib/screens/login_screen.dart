import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/projetos_provider.dart';
import './registro_aluno_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAluno = true; 
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  void _login(BuildContext context) {
    if (_emailController.text.isEmpty || _passController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Preencha todos os campos")));
      return;
    }
    Provider.of<ProjetosProvider>(context, listen: false).setUsuario(_isAluno);
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    final corAtual = _isAluno ? const Color(0xFF004D40) : const Color(0xFF1565C0); 

    return Scaffold(
      backgroundColor: corAtual,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.volunteer_activism, size: 80, color: Colors.white),
              const SizedBox(height: 10),
              const Text("VoluntaRIO", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 40),
              
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("COORDENAÇÃO", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                          Switch(
                            value: _isAluno,
                            activeTrackColor: Colors.teal.shade200,
                            inactiveTrackColor: Colors.indigo.shade200,
                            thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
                              if (states.contains(WidgetState.selected)) {
                                return Colors.teal;
                              }
                              return Colors.indigo;
                            }),
                            onChanged: (val) => setState(() => _isAluno = val),
                          ),
                          const Text("ACADÊMICO", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'E-mail Unidavi', prefixIcon: Icon(Icons.email)),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _passController,
                        decoration: const InputDecoration(labelText: 'Senha', prefixIcon: Icon(Icons.lock)),
                        obscureText: true,
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => _login(context),
                          style: ElevatedButton.styleFrom(backgroundColor: corAtual, foregroundColor: Colors.white),
                          child: Text(_isAluno ? "LOGIN DO ACADÊMICO" : "LOGIN EXTENSÃO"),
                        ),
                      ),
                      if (_isAluno) ...[
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) => const RegistroAlunoScreen()));
                          },
                          child: const Text("Não tem conta? Cadastre-se"),
                        )
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}