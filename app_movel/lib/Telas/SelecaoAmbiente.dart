import 'package:app_movel/Componentes/ConteudoRolavel.dart';
import 'package:app_movel/Telas/DeleteGeladeira.dart';
import 'package:app_movel/Telas/Login.dart';
import 'package:app_movel/Telas/Produtos.dart';
import 'package:app_movel/requisicoes/GeladeiraReq.dart';
import 'package:app_movel/requisicoes/Conexao.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_movel/Telas/CompartilharProduto.dart';

class SelecaoAmbientes extends StatefulWidget {
  const SelecaoAmbientes({super.key});

  @override
  State<SelecaoAmbientes> createState() => _SelecaoAmbientesState();
}

class _SelecaoAmbientesState extends State<SelecaoAmbientes> {
  List<Map<String, dynamic>> geladeirasPessoais = [];
  List<Map<String, dynamic>> geladeirasCompartilhadas = [];
  late GeladeiraReq _geladeiraReq;
  String userId = "";

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getString("user_id") ?? "";

      final conexao = await Conexao.getConnection();
      _geladeiraReq = GeladeiraReq(conexao);

      final pessoais = await _geladeiraReq.getGeladeirasPessoais(userId);
      final compartilhadas =
          await _geladeiraReq.getGeladeirasCompartilhadas(userId);

      setState(() {
        geladeirasPessoais = pessoais;
        geladeirasCompartilhadas = compartilhadas;
      });
    } catch (e) {
      print("Erro ao carregar geladeiras: $e");
    }
  }

  Future<void> _salvarIdGeladeira(String geladeiraId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("refrigerator_id", geladeiraId);
    print("ID da geladeira salvo: $geladeiraId");
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ConteudoRolavel(
              titulo: 'Minhas Geladeiras',
              itens: geladeirasPessoais
                  .map((g) => {
                        'titulo': g['name'] ?? 'Sem título',
                        'descricao': g['description'] ?? 'Sem descrição',
                        'id': g['id'],
                      })
                  .toList(),
              iconePadrao: Icons.kitchen,
              onTapItem: (titulo, descricao) async {
                final geladeiraSelecionada = geladeirasPessoais.firstWhere(
                  (g) => g['name'] == titulo && g['description'] == descricao,
                );

                final geladeiraId = geladeiraSelecionada['id'];
                if (geladeiraId != null) {
                  await _salvarIdGeladeira(geladeiraId);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Produtos(),
                    ),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: ConteudoRolavel(
              titulo: 'Geladeiras Compartilhadas',
              itens: geladeirasCompartilhadas
                  .map((g) => {
                        'titulo': g['name'],
                        'descricao': g['description'],
                        'id': g['id'],
                      })
                  .toList(),
              iconePadrao: Icons.people,
              onTapItem: (titulo, descricao) async {
                final geladeiraSelecionada =
                    geladeirasCompartilhadas.firstWhere(
                  (g) => g['name'] == titulo && g['description'] == descricao,
                );

                final geladeiraId = geladeiraSelecionada['id'];
                if (geladeiraId != null) {
                  await _salvarIdGeladeira(geladeiraId);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Produtos(),
                    ),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CompartilharProduto(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[100],
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    "COMPARTILHAR",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DeleteGeladeira(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[100],
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    "DELETAR",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[100],
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    "DESLOGAR",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
