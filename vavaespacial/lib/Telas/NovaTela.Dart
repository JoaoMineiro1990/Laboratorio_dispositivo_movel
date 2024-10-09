import 'package:flutter/material.dart';

class NovaTela extends StatelessWidget {
  final Map<String, dynamic> informacoes;

  NovaTela(
      {required this.informacoes}); // Construtor para receber as informações

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Fim de Jogo', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[900]!, Colors.red[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'VOCÊ MORREU, QUE PENA, É O ESPAÇO NÉ...\n'
                  'ESCOLHAS RUINS MATAM TODO MUNDO!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
                const SizedBox(height: 20),
                ..._buildInformacoes(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInformacoes() {
    List<Widget> informacoesWidgets = [];

    // Adicionar informações como na tela de lançamento
    void addItem(String label, IconData icon,
        {bool hasValue = true, dynamic value}) {
      informacoesWidgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            hasValue ? '$label: $value' : 'Você foi sem $label!',
            style: TextStyle(
                fontSize: 18, color: hasValue ? Colors.white : Colors.red),
          ),
        ],
      ));
      informacoesWidgets.add(const SizedBox(height: 10));
    }

    addItem('Piloto', Icons.airplanemode_active,
        hasValue: informacoes['pilotoSelecionado'] != null,
        value: informacoes['pilotoSelecionado']);

    // Continue adicionando as outras informações como nos engenheiros, soldados, etc.

    return informacoesWidgets; // Retorna a lista de widgets
  }
}
