import 'package:app_movel/Telas/AdicionarAmbiente.dart';
import 'package:app_movel/Telas/AdicionarEstoque.dart';
import 'package:app_movel/Telas/AdicionarProduto.dart';
import 'package:app_movel/Telas/DetalhesEstoque.dart';
import 'package:app_movel/Telas/EdicaoProduto.dart';
import 'package:app_movel/Telas/EditarAmbiente.dart';
import 'package:app_movel/Telas/EstoqueScreen.dart';
import 'package:app_movel/Telas/InformacaoProduto.dart';
import 'package:app_movel/Telas/PerfilUsuario.dart';
import 'package:app_movel/Telas/Produtos.dart';
import 'package:app_movel/Telas/SelecaoAmbiente.dart';
import 'package:flutter/material.dart';

class Aplicacao extends StatefulWidget {
  final String nomeDeUsuario;

  const Aplicacao({super.key, required this.nomeDeUsuario});

  @override
  State<Aplicacao> createState() => _AplicacaoState();
}

class _AplicacaoState extends State<Aplicacao> {
  int indexAtual = 0;
  Widget? telaAtual; // Variável que armazena a tela de detalhes/ambientes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[100],
          elevation: 0,
          title: const Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.inventory, color: Colors.brown),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'StockPocket',
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ),
        body: telaAtual ??
            IndexedStack(
              index: indexAtual,
              children: [
                EstoqueScreen(
                  nomeUsuario: widget.nomeDeUsuario,
                  aoSelecionarEstoque: (titulo, descricao) {
                    setState(() {
                      telaAtual = DetalheEstoque(
                        titulo: titulo,
                        descricao: descricao,
                        aoAcessarAmbientes: () {
                          setState(() {
                            telaAtual = SelecaoAmbientes(
                              tituloEstoque: titulo,
                              aoSelecionarProduto: () {
                                setState(() {
                                  telaAtual = Produtos(
                                    aoEntrarNoProduto: () {
                                      setState(() {
                                        telaAtual = InformacaoProduto(
                                          aoEditarProduto: () {
                                            setState(() {
                                              telaAtual = EdicaoProduto(
                                                aoCancelar: () {
                                                  setState(() {
                                                    telaAtual = null;
                                                    indexAtual = 0;
                                                  });
                                                },
                                              );
                                            });
                                          },
                                        );
                                      });
                                    },
                                    aoCancelar: () {
                                      setState(() {
                                        telaAtual = null;
                                        indexAtual = 0;
                                      });
                                    },
                                    aoAdicionarProduto: () {
                                      setState(() {
                                        telaAtual = AdicionarProduto(
                                            aoAdicionarProduto: () {
                                          setState(() {
                                            telaAtual = null;
                                            indexAtual = 0;
                                          });
                                        });
                                      });
                                    },
                                  );
                                });
                              },
                              aoCancelar: () {
                                setState(() {
                                  telaAtual = null;
                                  indexAtual = 0;
                                });
                              },
                              aoEditarAmbiente: () {
                                setState(() {
                                  telaAtual = EditarAmbiente(
                                    aoSalvarAmbiente: () {
                                      setState(() {
                                        telaAtual = null;
                                        indexAtual = 0;
                                      });
                                    },
                                  );
                                });
                              },
                              aoAdicionarAmbiente: () {
                                setState(() {
                                  telaAtual = AdicionarAmbiente(
                                    aoAdicionarAmbiente: () {
                                      setState(() {
                                        telaAtual = null;
                                        indexAtual = 0;
                                      });
                                    },
                                  );
                                });
                              },
                            );
                          });
                        },
                      );
                    });
                  },
                ),
                Container(), // Tela Adicionar
                Container(), // Tela Sobre
              ],
            ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: indexAtual,
          backgroundColor: Colors.orange[100],
          selectedItemColor: Colors.brown,
          unselectedItemColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline, size: 30),
              label: "Adicionar",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 30),
              label: "Sobre",
            ),
          ],
          onTap: (index) {
            setState(() {
              indexAtual = index;

              if (index == 2) {
                telaAtual = PerfilUsuario(
                  aoEditarPerfil: () {
                    setState(() {
                      // Defina a navegação ao editar o perfil
                    });
                  },
                );
              } else if (index == 1) {
                telaAtual = const Adicionarestoque();
              } else {
                telaAtual = null;
              }
            });
          },
        ));
  }
}
