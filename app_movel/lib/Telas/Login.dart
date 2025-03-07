// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:app_movel/Telas/Aplicacao.dart';
import 'package:app_movel/Telas/Cadastro.dart';
import 'package:flutter/material.dart';
import 'package:app_movel/Componentes/botao.dart';
import 'package:app_movel/Componentes/alerta.dart';
import 'package:app_movel/Componentes/campoescrever.dart';
import 'package:app_movel/Componentes/cabecalho.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_movel/requisicoes/Autenticacao.dart';
import 'package:app_movel/requisicoes/Conexao.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _lembrarLogin = false;

  late Autenticacao _autenticacao;

  @override
  void initState() {
    super.initState();
    _inicializarAutenticacao();
  }

  Future<void> _inicializarAutenticacao() async {
    try {
      final conexao =
          await Conexao.getConnection();
      setState(() {
        _autenticacao = Autenticacao(conexao);
      });
    } catch (e) {
      print("Erro ao inicializar conexão: $e");
    }
  }

  Future<void> _login() async {
    String email = _emailController.text;
    String senha = _senhaController.text;

    try {
      final resultado = await _autenticacao.autenticarUsuario(email, senha);

      if (resultado == "true") {
        final conexao = await Conexao.getConnection();
        final idResult = await conexao.query(
          "SELECT id FROM users WHERE email = @email",
          substitutionValues: {"email": email},
        );
        if (idResult.isNotEmpty) {
          final userId = idResult[0][0];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("user_id", userId);
          print("ID do usuário salvo: $userId");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Aplicacao()),
          );
        }
      } else {
        Alerta(
          titulo: "Erro de Login",
          conteudo: resultado,
        ).show(context);
      }
    } catch (e) {
      Alerta(
        titulo: "Erro",
        conteudo: "Erro ao autenticar: $e",
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 240, 240),
      appBar: Cabecalho(titulo: 'StockPocket'),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                CampoEscrever(
                  hintText: 'Digite seu email',
                  prefixIcon: Icons.email,
                  controller: _emailController,
                ),
                const SizedBox(height: 10),
                CampoEscrever(
                  hintText: 'Digite sua senha',
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  controller: _senhaController,
                ),
                const SizedBox(height: 10),
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
                    const Text(
                      'Lembrar o login',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Botao(
                  texto: 'ENTRAR',
                  tipoNavegacao: 'none',
                  beforeNavigate: () {
                    _login();
                    return false;
                  },
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Não tem uma conta? ',
                      style: TextStyle(color: Colors.black),
                    ),
                    Botao(
                      texto: 'Cadastre-se',
                      tipoNavegacao: 'push',
                      destino: Cadastro(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
