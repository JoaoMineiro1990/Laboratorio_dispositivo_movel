import 'package:flutter/material.dart';
import 'package:app_movel/Componentes/botao.dart';
import 'package:app_movel/Componentes/alerta.dart';
import 'package:app_movel/Componentes/campoescrever.dart';
import 'package:app_movel/Componentes/cabecalho.dart';
import 'package:app_movel/requisicoes/Conexao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_movel/Telas/Aplicacao.dart';
import 'package:app_movel/requisicoes/UserReq.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  late UserReq _userReq;

  @override
  void initState() {
    super.initState();
    Conexao.getConnection().then((conexao) {
      _userReq = UserReq(conexao);
    });
  }

  bool camposPreenchidos() {
    return _nomeController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _senhaController.text.isNotEmpty &&
        _confirmaSenhaController.text.isNotEmpty;
  }

  bool verificarSenha() {
    return _senhaController.text == _confirmaSenhaController.text;
  }

  Future<void> _cadastrarUsuario() async {
    if (!camposPreenchidos()) {
      Alerta(
        titulo: "Campos Obrigatórios",
        conteudo: "Por favor, preencha todos os campos.",
      ).show(context);
      return;
    }

    if (!verificarSenha()) {
      Alerta(
        titulo: "Erro",
        conteudo: "As senhas não coincidem.",
      ).show(context);
      return;
    }

    try {
      final resultado = await _userReq.inserirUsuario(
        _nomeController.text,
        _emailController.text,
        _senhaController.text,
      );

      if (resultado.contains("sucesso")) {
        
        final idResult = await _userReq.getIdByEmail(_emailController.text);
        final userId = idResult;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("user_id", userId);
        print("ID do usuário salvo: $userId");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Aplicacao()),
        );
      } else {
        Alerta(
          titulo: "Erro ao Cadastrar",
          conteudo: resultado,
        ).show(context);
      }
    } catch (e) {
      Alerta(
        titulo: "Erro",
        conteudo: "Erro ao cadastrar usuário: $e",
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 240, 240),
      appBar: Cabecalho(titulo: 'Cadastro'),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                CampoEscrever(
                  hintText: 'Digite seu nome',
                  prefixIcon: Icons.person,
                  controller: _nomeController,
                ),
                const SizedBox(height: 15),

                CampoEscrever(
                  hintText: 'Digite seu número',
                  prefixIcon: Icons.phone,
                ),
                const SizedBox(height: 15),

                CampoEscrever(
                  hintText: 'Digite seu email',
                  prefixIcon: Icons.email,
                  controller: _emailController,
                ),
                const SizedBox(height: 15),

                CampoEscrever(
                  hintText: 'Digite sua senha',
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  controller: _senhaController,
                ),
                const SizedBox(height: 15),

                CampoEscrever(
                  hintText: 'Confirme sua senha',
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  controller: _confirmaSenhaController,
                ),
                const SizedBox(height: 20),

                Botao(
                  texto: 'REGISTRAR',
                  tipoNavegacao: 'none', 
                  beforeNavigate: () {
                    _cadastrarUsuario();
                    return false;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
