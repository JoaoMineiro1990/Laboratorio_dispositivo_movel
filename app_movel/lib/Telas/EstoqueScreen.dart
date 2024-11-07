import 'package:flutter/material.dart';

class EstoqueScreen extends StatelessWidget {
  final String nomeUsuario; // Recebe o nome do usuário
  final Function(String, String)
      aoSelecionarEstoque; // Callback para selecionar o estoque

  const EstoqueScreen({
    super.key,
    required this.nomeUsuario,
    required this.aoSelecionarEstoque,
  });

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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centraliza horizontalmente
        children: [
          const SizedBox(height: 20),
          const Text(
            "Meus Ambientes Pessoais",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          // Lista de Meus Ambientes
          ...meusEstoques.map((estoque) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading:
                    const Icon(Icons.inventory, size: 40, color: Colors.brown),
                title: Text(estoque['titulo']!),
                subtitle: Text(estoque['descricao']!),
                onTap: () {
                  aoSelecionarEstoque(
                      estoque['titulo']!, estoque['descricao']!);
                },
              ),
            );
          }),

          const SizedBox(height: 30),
          const Text(
            "Meus Ambientes Compartilhados",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          // Lista de Ambientes Compartilhados
          ...estoquesCompartilhados.map((estoque) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading:
                    const Icon(Icons.people, size: 40, color: Colors.brown),
                title: Text(estoque['titulo']!),
                subtitle: Text(estoque['descricao']!),
                onTap: () {
                  aoSelecionarEstoque(
                      estoque['titulo']!, estoque['descricao']!);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
