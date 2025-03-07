import 'package:app_movel/Componentes/Cabecalho.dart';
import 'package:app_movel/Componentes/CampoEscrever.dart';
import 'package:app_movel/Telas/Aplicacao.dart';
import 'package:app_movel/requisicoes/Conexao.dart';
import 'package:app_movel/requisicoes/GeladeiraReq.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteGeladeira extends StatefulWidget {
  const DeleteGeladeira({super.key});

  @override
  State<DeleteGeladeira> createState() => _DeleteGeladeiraState();
}

class _DeleteGeladeiraState extends State<DeleteGeladeira> {
  List<Map<String, dynamic>> todasGeladeiras = [];
  final TextEditingController _nomeGeladeiraController =
      TextEditingController();
  String userId = "";
  late GeladeiraReq _geladeiraReq;

  @override
  void initState() {
    super.initState();
    _carregarGeladeiras();
  }

  Future<void> _carregarGeladeiras() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getString("user_id") ?? "";

      final conexao = await Conexao.getConnection();
      _geladeiraReq = GeladeiraReq(conexao);

      final geladeiras = await _geladeiraReq.getGeladeirasDoUsuario(userId);

      setState(() {
        todasGeladeiras = geladeiras;
      });
    } catch (e) {
      print("Erro ao carregar geladeiras: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao carregar geladeiras.")),
      );
    }
  }

  Future<void> _deletarGeladeira(String nomeGeladeira) async {
    try {
      final geladeira = todasGeladeiras.firstWhere(
        (g) => g['name'].toLowerCase() == nomeGeladeira.toLowerCase(),
        orElse: () => {},
      );

      if (geladeira.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro: Geladeira não encontrada.")),
        );
        return;
      }

      final geladeiraId = geladeira['id'];

      final confirmacao = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Confirmar Exclusão"),
            content:
                Text("Deseja realmente excluir a geladeira $nomeGeladeira?"),
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
      );

      if (confirmacao != true) return;

      final resultado =
          await _geladeiraReq.deletarGeladeira(geladeiraId, userId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultado)),
      );

      if (resultado.contains("sucesso")) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Aplicacao(),
          ),
        );
      }
    } catch (e) {
      print("Erro ao deletar geladeira: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao deletar geladeira.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cabecalho(titulo: "Deletar Geladeira"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Clique em uma geladeira para selecionar seu nome:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: todasGeladeiras.length,
                itemBuilder: (context, index) {
                  final geladeira = todasGeladeiras[index];
                  return ListTile(
                    title: Text(geladeira['name']),
                    subtitle: Text(geladeira['description'] ?? "Sem descrição"),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      setState(() {
                        _nomeGeladeiraController.text = geladeira['name'];
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Geladeira selecionada: ${geladeira['name']}"),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            CampoEscrever(
              hintText: "Nome da Geladeira",
              prefixIcon: Icons.edit,
              controller: _nomeGeladeiraController,
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_nomeGeladeiraController.text.isNotEmpty) {
                    _deletarGeladeira(_nomeGeladeiraController.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Erro: Nome não pode estar vazio.")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[300],
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                child: const Text(
                  "Deletar Geladeira",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
