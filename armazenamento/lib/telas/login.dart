import 'package:flutter/material.dart';

import '../classes/utils.dart';
import '../classes/navegacao.dart';
import '../classes/tipotexto.dart';
import '../telas/cadastro.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool rememberUser = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedUser();
  }

  Future<void> _loadRememberedUser() async {
    final username = await Utils.loadRememberedUser();
    setState(() {
      if (username != null) {
        _usernameController.text = username;
        rememberUser = true;
      }
    });
  }

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    Utils.logar(context, username, password,
        rememberUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/imagens/1208127.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bem vindo de volta, soldado.\nPela glória do Imperador',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Campo para usuário
                  SizedBox(
                    width: 300,
                    child: TextFieldCustomizado(
                      controller: _usernameController,
                      hintText: 'Digite seu usuário',
                      tipo: TipoTextField.letrasNumeros,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Campo para senha
                  SizedBox(
                    width: 300,
                    child: TextFieldCustomizado(
                      controller: _passwordController,
                      hintText: 'Digite sua senha',
                      tipo: TipoTextField.letrasNumeros,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: rememberUser,
                        onChanged: (value) {
                          setState(() {
                            rememberUser = value ?? false;
                          });
                        },
                      ),
                      const Text(
                        'Lembrar o login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Botão ENTRAR
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8C6E3F),
                        shape: const RoundedRectangleBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'ENTRAR',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Botão CADASTRAR
                  SizedBox(
                    width: 300,
                    child: Navegacao(
                      context: context,
                      tipo: TipoNavegacao.pushReplacement,
                      textoBotao: 'CADASTRAR',
                      paginaDestino: const Cadastro(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
