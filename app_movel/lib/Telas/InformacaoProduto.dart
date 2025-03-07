import 'package:app_movel/Componentes/Cabecalho.dart';
import 'package:app_movel/Componentes/Botao.dart';
import 'package:app_movel/Componentes/CampoEscrever.dart';
import 'package:app_movel/requisicoes/Conexao.dart';
import 'package:app_movel/requisicoes/ProdutoReq.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class InformacaoProduto extends StatefulWidget {
  const InformacaoProduto({super.key});

  @override
  State<InformacaoProduto> createState() => _InformacaoProdutoState();
}

class _InformacaoProdutoState extends State<InformacaoProduto> {
  String produtoId = "";
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  late Produtoreq _produtoReq;

  @override
  void initState() {
    super.initState();
    _carregarProduto();
  }

  Future<void> _carregarProduto() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      produtoId = prefs.getString("product_id") ?? "";

      final conexao = await Conexao.getConnection();
      _produtoReq = Produtoreq(conexao);

      final produto = await _produtoReq.getProdutoPorId(produtoId);

      final dataExpiracao = produto['expiration_date'] is DateTime
          ? DateFormat('yyyy-MM-dd').format(produto['expiration_date'])
          : produto['expiration_date'] ?? "";

      setState(() {
        _nomeController.text = produto['name'] ?? "";
        _dataController.text = dataExpiracao;
        _quantidadeController.text = produto['quantidade']?.toString() ?? "";
      });
    } catch (e) {
      print("Erro ao carregar produto: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao carregar produto.")),
      );
    }
  }

  Future<void> _atualizarProduto() async {
    try {
      final resultado = await _produtoReq.atualizarProduto(
        produtoId,
        _nomeController.text,
        _dataController.text,
        _quantidadeController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultado)),
      );
      if (resultado.contains("sucesso")) {
        Navigator.pop(context);
      }
    } catch (e) {
      print("Erro ao atualizar produto: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao atualizar produto.")),
      );
    }
  }

  Future<void> _excluirProduto() async {
    final confirmacao = await _mostrarDialogoConfirmacao();
    if (!confirmacao) return;

    try {
      final resultado = await _produtoReq.deletarProduto(produtoId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultado)),
      );
      if (resultado.contains("sucesso")) {
        Navigator.pop(context);
      }
    } catch (e) {
      print("Erro ao excluir produto: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao excluir produto.")),
      );
    }
  }

  Future<bool> _mostrarDialogoConfirmacao() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Confirmação"),
              content: const Text(
                  "Você tem certeza que deseja excluir este produto?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Excluir"),
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
      appBar: Cabecalho(titulo: 'Informações do Produto'),
      body: SingleChildScrollView(
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
                    children: [
                      const Icon(Icons.local_offer,
                          size: 80, color: Colors.orange),
                      const SizedBox(height: 10),
                      Text(
                        _nomeController.text.isNotEmpty
                            ? _nomeController.text
                            : "Produto",
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
              hintText: "Nome do Produto",
              prefixIcon: Icons.edit,
              controller: _nomeController,
            ),
            const SizedBox(height: 10),
            CampoEscrever(
              hintText: "Data de Expiração",
              prefixIcon: Icons.calendar_today,
              controller: _dataController,
            ),
            const SizedBox(height: 10),
            CampoEscrever(
              hintText: "Quantidade (kg)",
              prefixIcon: Icons.numbers,
              controller: _quantidadeController,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Botao(
                  texto: 'VOLTAR',
                  tipoNavegacao: 'pop',
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _atualizarProduto,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                  ),
                  child: const Text(
                    "ATUALIZAR",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _excluirProduto,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                  ),
                  child: const Text(
                    "EXCLUIR",
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
