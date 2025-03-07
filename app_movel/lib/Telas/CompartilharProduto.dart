import 'package:app_movel/Componentes/Cabecalho.dart';
import 'package:app_movel/Componentes/CampoEscrever.dart';
import 'package:app_movel/requisicoes/Conexao.dart';
import 'package:app_movel/requisicoes/GeladeiraReq.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompartilharProduto extends StatefulWidget {
  const CompartilharProduto({super.key});

  @override
  State<CompartilharProduto> createState() => _CompartilharProdutoState();
}

class _CompartilharProdutoState extends State<CompartilharProduto> {
  String estoqueSelecionadoId = "";
  final TextEditingController _campoController = TextEditingController();
  late GeladeiraReq _geladeiraReq;
  String userId = "";
  List<Map<String, dynamic>> todosEstoques = [];

  @override
  void initState() {
    super.initState();
    _carregarEstoques();
  }

  Future<void> _carregarEstoques() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getString("user_id") ?? "";

      final conexao = await Conexao.getConnection();
      _geladeiraReq = GeladeiraReq(conexao);

      final pessoais = await _geladeiraReq.getGeladeirasPessoais(userId);
      final compartilhados =
          await _geladeiraReq.getGeladeirasCompartilhadas(userId);

      setState(() {
        todosEstoques = [...pessoais, ...compartilhados];
      });
    } catch (e) {
      print("Erro ao carregar estoques: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao carregar estoques.")),
      );
    }
  }

  Future<void> _adicionarEstoqueCompartilhado() async {
    if (_campoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro: O campo não pode estar vazio.")),
      );
      return;
    }

    final estoqueId = _campoController.text;

    try {
      final existe = await _geladeiraReq.getGeladeiraPorId(estoqueId);
      if (existe.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro: Estoque não encontrado.")),
        );
        return;
      }

      final resultado =
          await _geladeiraReq.compartilharGeladeira(userId, estoqueId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultado)),
      );
    } catch (e) {
      print("Erro ao adicionar estoque compartilhado: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao adicionar estoque.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cabecalho(titulo: "Compartilhar Produto"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Clique em um estoque para selecionar seu ID:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: todosEstoques.length,
                itemBuilder: (context, index) {
                  final estoque = todosEstoques[index];
                  return ListTile(
                    title: Text(estoque['name']),
                    subtitle: Text(estoque['description'] ?? "Sem descrição"),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      setState(() {
                        estoqueSelecionadoId = estoque['id'];
                        _campoController.text = estoqueSelecionadoId;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Estoque selecionado: ${estoque['name']} (${estoque['id']})"),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            CampoEscrever(
              hintText: "ID do Estoque",
              prefixIcon: Icons.copy,
              controller: _campoController,
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: _adicionarEstoqueCompartilhado,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[100],
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                child: const Text(
                  "Adicionar Estoque Compartilhado",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
