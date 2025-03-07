  import 'package:flutter/material.dart';
  import 'package:app_movel/Componentes/ConteudoRolavel.dart';
  import 'package:app_movel/Telas/DetalhesEstoque.dart';

  class EstoqueScreen extends StatelessWidget {
    const EstoqueScreen({super.key});

    @override
    Widget build(BuildContext context) {
      final List<Map<String, String>> meusEstoques = [
        {
          'titulo': 'Ambiente Pessoal 1',
          'descricao': 'Descrição do Ambiente Pessoal 1'
        },
        {
          'titulo': 'Ambiente Pessoal 2',
          'descricao': 'Descrição do Ambiente Pessoal 2'
        },
      ];

      final List<Map<String, String>> estoquesCompartilhados = [
        {
          'titulo': 'Ambiente Compartilhado 1',
          'descricao': 'Descrição do Ambiente Compartilhado 1'
        },
        {
          'titulo': 'Ambiente Compartilhado 2',
          'descricao': 'Descrição do Ambiente Compartilhado 2'
        },
      ];

      return Column(
        children: [
          Expanded(
            child: ConteudoRolavel(
              titulo: 'Meus Ambientes Pessoais',
              itens: meusEstoques,
              iconePadrao: Icons.inventory,
              onTapItem: (titulo, descricao) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalheEstoque(
                      titulo: titulo,
                      descricao: descricao,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ConteudoRolavel(
              titulo: 'Ambientes Compartilhados',
              itens: estoquesCompartilhados,
              iconePadrao: Icons.people,
              onTapItem: (titulo, descricao) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalheEstoque(
                      titulo: titulo,
                      descricao: descricao,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
