import 'package:app_movel/Componentes/Cabecalho.dart';
import 'package:app_movel/Componentes/Botao.dart';
import 'package:app_movel/Componentes/CampoEscrever.dart';
import 'package:app_movel/requisicoes/Conexao.dart';
import 'package:app_movel/requisicoes/UserReq.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EdicaoUsuario extends StatefulWidget {
  const EdicaoUsuario({super.key});

  @override
  State<EdicaoUsuario> createState() => _EdicaoUsuarioState();
}

class _EdicaoUsuarioState extends State<EdicaoUsuario> {
  late UserReq _userReq;
  String userId = "";
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDadosUsuario();
  }

  Future<void> _carregarDadosUsuario() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getString("user_id") ?? "";

      if (userId.isEmpty) {
        throw Exception("ID do usuário não encontrado.");
      }

      final conexao = await Conexao.getConnection();
      _userReq = UserReq(conexao);
      final dados = await _userReq.getUserById(userId);

      setState(() {
        _nomeController.text = dados['name'] ?? "";
        _emailController.text = dados['email'] ?? "";
        _senhaController.text = dados['password'] ?? "";
        _isLoading = false;
      });
    } catch (e) {
      print("Erro ao carregar usuário: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao carregar dados do usuário.")),
      );
    }
  }

  Future<void> _atualizarUsuario() async {
    final confirmacao = await _mostrarDialogoConfirmacao();
    if (!confirmacao) return;

    try {
      final resultado = await _userReq.updateUser(
        userId,
        _nomeController.text,
        _emailController.text,
        _senhaController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultado)),
      );

      if (resultado.contains("sucesso")) {
        Navigator.pop(context);
      }
    } catch (e) {
      print("Erro ao atualizar usuário: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao atualizar usuário.")),
      );
    }
    _carregarDadosUsuario();
  }

  Future<bool> _mostrarDialogoConfirmacao() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Confirmação"),
              content: const Text(
                  "Você tem certeza que deseja atualizar esse usuário?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Confirmar"),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cabecalho(titulo: 'Editar Usuário'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CampoEscrever(
                    hintText: "Nome",
                    prefixIcon: Icons.person,
                    controller: _nomeController,
                  ),
                  const SizedBox(height: 10),
                  CampoEscrever(
                    hintText: "E-mail",
                    prefixIcon: Icons.email,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 10),
                  CampoEscrever(
                    hintText: "Senha",
                    prefixIcon: Icons.lock,
                    controller: _senhaController,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Botao(
                        texto: 'CANCELAR',
                        tipoNavegacao: 'pop',
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _atualizarUsuario,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                        ),
                        child: const Text(
                          "SALVAR",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
