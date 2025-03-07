// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:app_movel/Componentes/Cabecalho.dart';
import 'package:app_movel/Componentes/botao.dart';
import 'package:app_movel/Componentes/ConteudoRolavel.dart';
import 'package:app_movel/Telas/AdicionarProduto.dart';
import 'package:app_movel/Telas/EditarAmbiente.dart';
import 'package:app_movel/Telas/InformacaoProduto.dart';
import 'package:app_movel/requisicoes/Conexao.dart';
import 'package:app_movel/requisicoes/Produtoreq.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Produtos extends StatefulWidget {
  const Produtos({super.key});

  @override
  State<Produtos> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  List<Map<String, dynamic>> produtos = [];
  late Produtoreq _produtoReq;
  String refrigeratorId = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> _carregarProdutos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      refrigeratorId = prefs.getString("refrigerator_id") ?? "";

      final conexao = await Conexao.getConnection();
      _produtoReq = Produtoreq(conexao);

      final listaProdutos =
          await _produtoReq.getProdutosPorGeladeira(refrigeratorId);

      print("Produtos carregados: $listaProdutos");

      setState(() {
        produtos = listaProdutos;
      });
    } catch (e) {
      print("Erro ao carregar produtos: $e");
    }
  }

  Future<void> _salvarProdutoId(String produtoId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("product_id", produtoId);
  }

  @override
  Widget build(BuildContext context) {
    _carregarProdutos();
    return Scaffold(
      appBar: Cabecalho(titulo: 'StockPocket'),
      body: Column(
        children: [
          Expanded(
            child: ConteudoRolavel(
              titulo: 'Selecione o Produto',
              itens: produtos
                  .map((p) => {
                        'titulo': p['name'],
                        'descricao':
                            "Vence em: ${p['expiration_date'] ?? 'Sem data'}",
                        'id': p['id'],
                      })
                  .toList(),
              iconePadrao: Icons.shopping_bag,
              onTapItem: (titulo, descricao) async {
                final produtoSelecionado = produtos.firstWhere(
                    (p) => p['name'] == titulo && p['expiration_date'] != null);

                final produtoId = produtoSelecionado['id'];

                if (produtoId != null) {
                  await _salvarProdutoId(
                      produtoId);
                  print("Produto selecionado: $produtoId");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InformacaoProduto()));
                }
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Botao(
                  texto: 'ADICIONAR',
                  tipoNavegacao: 'push',
                  destino: AdicionarProduto(),
                ),
                SizedBox(width: 10),
                Botao(
                  texto: 'EDITAR',
                  tipoNavegacao: 'push',
                  destino:
                      EditarAmbiente(), 
                ),
                SizedBox(width: 10),
                Botao(
                  texto: 'VOLTAR',
                  tipoNavegacao: 'pop',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
