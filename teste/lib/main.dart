import 'package:flutter/material.dart';
import 'package:teste/requisicoes/Conexao.dart';
import 'package:teste/requisicoes/ProdutoReq.dart'; // Sua classe de produtos

void main() {
  runApp(const ProdutoApp());
}

class ProdutoApp extends StatelessWidget {
  const ProdutoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atualizar Produto',
      home: AtualizarProdutoScreen(),
    );
  }
}

class AtualizarProdutoScreen extends StatefulWidget {
  @override
  _AtualizarProdutoScreenState createState() => _AtualizarProdutoScreenState();
}

class _AtualizarProdutoScreenState extends State<AtualizarProdutoScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataExpController = TextEditingController();
  final String _productId =
      "55555555-5555-5555-5555-555555555555"; // ID do produto fixo para teste

  late Produtoreq _produtoReq;
  String _mensagem = "";

  @override
  void initState() {
    super.initState();
    _iniciarConexao();
  }

  // Inicializa a conexão usando a classe Conexao
  Future<void> _iniciarConexao() async {
    try {
      final connection = await Conexao.getConnection();
      _produtoReq = Produtoreq(connection);
      await _carregarDados(); // Carrega os dados do produto ao iniciar
    } catch (e) {
      print("Erro ao iniciar conexão: $e");
    }
  }

  // Carrega os dados do produto pelo ID
  Future<void> _carregarDados() async {
    try {
      final dados = await _produtoReq.getProdutoPorId(_productId);
      setState(() {
        _nomeController.text = dados["name"];
        _dataExpController.text = dados["expiration_date"].toString();
      });
    } catch (e) {
      setState(() {
        _mensagem = "Erro ao carregar produto: $e";
      });
    }
  }

  // Função para atualizar o produto
  Future<void> _atualizarProduto() async {
    final newName = _nomeController.text.trim();
    final newExpirationDate = _dataExpController.text.trim();

    if (newName.isEmpty || newExpirationDate.isEmpty) {
      setState(() {
        _mensagem = "Por favor, preencha todos os campos.";
      });
      return;
    }

    final resultado = await _produtoReq.atualizarProduto(
      _productId,
      newName,
      newExpirationDate,
    );

    setState(() {
      _mensagem = resultado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Atualizar Produto"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Atualizar Produto:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: "Nome do Produto",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _dataExpController,
              decoration: const InputDecoration(
                labelText: "Data de Validade (YYYY-MM-DD)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _atualizarProduto,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text("Atualizar Produto"),
            ),
            const SizedBox(height: 20),
            Text(
              _mensagem,
              style: TextStyle(
                color:
                    _mensagem.contains("sucesso") ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
