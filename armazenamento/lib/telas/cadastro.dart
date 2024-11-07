import 'package:armazenamento/telas/login.dart';
import 'package:flutter/material.dart';
import '../classes/navegacao.dart';
import '../classes/tipotexto.dart';
import '../classes/utils.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _cadastrar() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final email = _emailController.text.trim();

    Utils.processarCadastro(
        context, username, password, confirmPassword, email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/imagens/10092851098035.jpg'),
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
                    'O nascimento de um novo membro para servir o Imperador',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Campo Nome de Usuário
                  SizedBox(
                    width: 300,
                    child: TextFieldCustomizado(
                      controller: _usernameController,
                      hintText: 'Nome de usuário',
                      tipo: TipoTextField.letrasNumeros,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Campo Senha
                  SizedBox(
                    width: 300,
                    child: TextFieldCustomizado(
                      controller: _passwordController,
                      hintText: 'Senha',
                      tipo: TipoTextField.letrasNumeros,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Campo Confirmar Senha
                  SizedBox(
                    width: 300,
                    child: TextFieldCustomizado(
                      controller: _confirmPasswordController,
                      hintText: 'Confirmar senha',
                      tipo: TipoTextField.letrasNumeros,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Campo Email
                  SizedBox(
                    width: 300,
                    child: TextFieldCustomizado(
                      controller: _emailController,
                      hintText: 'Email',
                      tipo: TipoTextField.letrasNumeros,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Botão de Cadastrar
                  SizedBox(
                    width: 300,
                    child: Navegacao(
                      context: context,
                      tipo: TipoNavegacao.pushReplacement,
                      textoBotao: 'CANCELAR',
                      paginaDestino: const Login(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: _cadastrar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8C6E3F),
                        shape: const RoundedRectangleBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'CADASTRAR',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
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
