import 'package:app_movel/Componentes/Cabecalho.dart';
import 'package:app_movel/Componentes/Botao.dart';
import 'package:app_movel/Componentes/CampoEscrever.dart';
import 'package:app_movel/requisicoes/Conexao.dart';
import 'package:app_movel/requisicoes/ProdutoReq.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdicionarProduto extends StatefulWidget {
  const AdicionarProduto({super.key});

  @override
  State<AdicionarProduto> createState() => _AdicionarProdutoState();
}

class _AdicionarProdutoState extends State<AdicionarProduto> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();

  late Produtoreq _produtoReq;
  late String refrigeratorId;
  late String userId;

  @override
  void initState() {
    super.initState();
    _carregarIds(); 
  }

  Future<void> _carregarIds() async {
    final prefs = await SharedPreferences.getInstance();
    refrigeratorId = prefs.getString("refrigerator_id") ?? "";
    userId = prefs.getString("user_id") ?? "";
  }

  Future<void> _inserirProduto() async {
    if (_nomeController.text.isEmpty ||
        _dataController.text.isEmpty ||
        _quantidadeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Todos os campos devem ser preenchidos.")));
      return;
    }

    final nome = _nomeController.text;
    final dataExpiracao = _dataController.text;
    final quantidade = _quantidadeController.text;

    final conexao = await Conexao.getConnection();
    _produtoReq = Produtoreq(conexao);

    final resultado = await _produtoReq.inserirProduto(
      nome,
      dataExpiracao,
      refrigeratorId,
      userId,
      quantidade,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(resultado)));

    if (resultado == "Produto adicionado com sucesso!") {
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cabecalho(titulo: 'Novo Produto'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_shopping_cart,
                          size: 80, color: Colors.orange),
                      SizedBox(height: 10),
                      Text(
                        "NOVO PRODUTO",
                        style: TextStyle(
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
              hintText: "Digite o nome do produto",
              prefixIcon: Icons.shopping_bag,
              controller: _nomeController,
            ),
            const SizedBox(height: 10),

            CampoEscrever(
              hintText: "formato yyyy/mm/dd",
              prefixIcon: Icons.calendar_today,
              controller: _dataController,
            ),
            const SizedBox(height: 10),

            CampoEscrever(
              hintText: "Quantidade (kg)",
              prefixIcon: Icons.scale,
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
                  onPressed: _inserirProduto,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                  ),
                  child: const Text(
                    "ADICIONAR",
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
