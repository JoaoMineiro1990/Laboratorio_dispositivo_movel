import 'package:app_movel/Telas/EdicaoUsuario.dart';
import 'package:app_movel/requisicoes/Conexao.dart';
import 'package:app_movel/requisicoes/UserReq.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_movel/Componentes/botao.dart';

class PerfilUsuario extends StatefulWidget {
  const PerfilUsuario({super.key});

  @override
  State<PerfilUsuario> createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  late UserReq _userReq;
  String userId = "";
  String nome = "";
  String email = "";

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
        nome = dados['name'] ?? "Nome não disponível";
        email = dados['email'] ?? "Email não disponível";
        _isLoading = false;
      });
    } catch (e) {
      print("Erro ao carregar dados do usuário: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  _buildInfoField(label: "NOME", value: nome),
                  const SizedBox(height: 10),
                  _buildInfoField(label: "EMAIL", value: email),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Botao(
                        texto: 'EDITAR',
                        tipoNavegacao: 'push',
                        destino: EdicaoUsuario(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoField({required String label, required String value}) {
    _carregarDadosUsuario();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.orange[100],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            value,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
