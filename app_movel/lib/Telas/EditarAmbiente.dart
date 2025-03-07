// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:app_movel/Componentes/Cabecalho.dart';
import 'package:app_movel/Componentes/Botao.dart';
import 'package:app_movel/Componentes/CampoEscrever.dart';
import 'package:app_movel/requisicoes/Conexao.dart';
import 'package:app_movel/requisicoes/GeladeiraReq.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditarAmbiente extends StatefulWidget {
  const EditarAmbiente({super.key});

  @override
  State<EditarAmbiente> createState() => _EditarAmbienteState();
}

class _EditarAmbienteState extends State<EditarAmbiente> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  late GeladeiraReq _geladeiraReq;
  String geladeiraId = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDadosIniciais();
  }

  Future<void> _carregarDadosIniciais() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      geladeiraId = prefs.getString("refrigerator_id") ?? "";

      if (geladeiraId.isEmpty) {
        throw Exception("ID da geladeira não encontrado.");
      }

      final conexao = await Conexao.getConnection();
      _geladeiraReq = GeladeiraReq(conexao);

      final dados = await _geladeiraReq.getGeladeiraPorId(geladeiraId);

      setState(() {
        nomeController.text = dados['name'] ?? "";
        descricaoController.text = dados['description'] ?? "";
        _isLoading = false;
      });
    } catch (e) {
      print("Erro ao carregar dados: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao carregar dados do ambiente.")),
      );
    }
  }

  Future<void> _salvarAlteracoes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString("user_id") ?? "";

      if (userId.isEmpty || geladeiraId.isEmpty) {
        throw Exception("Erro: ID do usuário ou geladeira não encontrado.");
      }

      final novoNome = nomeController.text;
      final novaDescricao = descricaoController.text;

      final resultado = await _geladeiraReq.atualizarGeladeira(
        geladeiraId,
        novoNome,
        novaDescricao,
        userId,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultado)),
      );

      if (resultado.contains("sucesso")) {
        Navigator.pop(context); 
      }
    } catch (e) {
      print("Erro ao salvar alterações: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao salvar alterações.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cabecalho(titulo: 'Editar Ambiente'),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator()) 
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.edit,
                                size: 80, color: Colors.orange),
                            const SizedBox(height: 10),
                            Text(
                              nomeController.text.isNotEmpty
                                  ? nomeController.text
                                  : "Ambiente",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CampoEscrever(
                    hintText: "Digite o nome do ambiente",
                    prefixIcon: Icons.home,
                    controller: nomeController,
                  ),
                  const SizedBox(height: 10),
                  CampoEscrever(
                    hintText: "Digite descricao do ambiente",
                    prefixIcon: Icons.location_on,
                    controller: descricaoController,
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
                        onPressed: _salvarAlteracoes,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                        ),
                        child: const Text(
                          "SALVAR ALTERAÇÕES",
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
