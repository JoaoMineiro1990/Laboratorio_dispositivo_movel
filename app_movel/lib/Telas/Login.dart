import 'package:app_movel/Telas/Aplicacao.dart';

import 'package:app_movel/Telas/Cadastro.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool check() {
    if (_emailLogin == "joao" && _senhaLogin == "12345") {
      return true;
    }
    return false;
  }

// Variáveis do login
  String _emailLogin = '';
  String _senhaLogin = '';
  String _nameLogin = '';
  bool _lembrarLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 240, 240),
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
        elevation: 0,
        title: const Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.inventory, color: Colors.brown),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'StockPocket',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(), // Adicionando um espaço à direita
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30), // Ajuste de espaço superior
                // Sign In text
                const Text(
                  'Loggin',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Email Field
                TextField(
                  onChanged: (value) {
                    _emailLogin = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, color: Colors.brown),
                    hintText: 'Digite seu email',
                    filled: true,
                    fillColor: Colors.orange[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Password Field
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    _senhaLogin = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.brown),
                    hintText: 'Digite sua senha',
                    filled: true,
                    fillColor: Colors.orange[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixText: 'Esqueceu a senha?',
                    suffixStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                // Remember login checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _lembrarLogin,
                      onChanged: (value) {
                        setState(() {
                          _lembrarLogin = value ?? false;
                        });
                      },
                      activeColor: Colors.brown,
                    ),
                    const Text('Lembrar o login',
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      bool validar = check();
                      if (validar) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Aplicacao(nomeDeUsuario: _nameLogin),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Dados inválidos"),
                              content:
                                  const Text("Usuário e/ou senha incorreto(a)"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Voltar"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      'ENTRAR',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Sign Up Text
                GestureDetector(
                    onTap: () {
                      // Handle sign up action
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Não tem uma conta? ',
                              style: TextStyle(color: Colors.black)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[100],
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Cadastro()),
                              ).then((result) {
                                if (result != null) {
                                  setState(() {
                                    _emailLogin = result['email'];
                                    _senhaLogin = result['senha'];
                                    _nameLogin = result['nome'];
                                  });
                                }
                              });
                            },
                            child: const Text(
                              'Cadastre-se',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
