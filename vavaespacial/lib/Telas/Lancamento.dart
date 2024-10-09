import 'package:flutter/material.dart';
import 'package:vavaespacial/Telas/NovaTela.dart';

class Lancamento extends StatelessWidget {
  final Map<String, dynamic> informacoes;

  Lancamento({required this.informacoes});

  @override
  Widget build(BuildContext context) {
    // Iniciar a navegação após 10 segundos
    Future.delayed(Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => NovaTela(
                informacoes: informacoes)), // Navega para a tela de GameOver
      );
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lançamento', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[900]!, Colors.red[900]!], // Defina suas cores
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
                  'Sua viagem foi bem sucedida?', // Mensagem exibida
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 20),
                CircularProgressIndicator(), // Indicador de carregamento (opcional)
                const SizedBox(height: 20),
                // Adicionar informações de quem foi
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

    void addItem(String label, IconData icon,
        {bool hasValue = true, dynamic value}) {
      informacoesWidgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centraliza o Row
        children: [
          Icon(icon, color: Colors.white), // Ícone correspondente
          const SizedBox(width: 8), // Espaçamento
          Text(
            hasValue ? '$label: $value' : 'Você foi sem $label!',
            style: TextStyle(
                fontSize: 18, color: hasValue ? Colors.white : Colors.red),
          ),
        ],
      ));
      informacoesWidgets
          .add(const SizedBox(height: 10)); // Espaçamento entre itens
    }

    addItem('Piloto', Icons.airplanemode_active,
        hasValue: informacoes['pilotoSelecionado'] != null,
        value: informacoes['pilotoSelecionado'] is String
            ? informacoes['pilotoSelecionado']
            : null); // Passa como null se não for uma string

    // Engenheiros
    addItem('Engenheiros', Icons.build,
        hasValue: informacoes['engenheiros'] != null &&
            informacoes['engenheiros'] > 0,
        value: informacoes['engenheiros']);

    // Cozinheiros
    addItem('Cozinheiros', Icons.kitchen,
        hasValue: informacoes['cozinheiros'] != null &&
            informacoes['cozinheiros'] > 0,
        value: informacoes['cozinheiros']);

    // Soldados
    addItem('Soldados', Icons.man,
        hasValue:
            informacoes['soldados'] != null && informacoes['soldados'] > 0,
        value: informacoes['soldados']);

    // Médicos
    addItem('Médicos', Icons.local_hospital,
        hasValue: informacoes['medicos'] != null && informacoes['medicos'] > 0,
        value: informacoes['medicos']);

    // Armas
    addItem('Armas', Icons.security,
        hasValue: informacoes['armas'] != null && informacoes['armas'] > 0,
        value: informacoes['armas']);

    // Armaduras
    addItem('Armaduras', Icons.shield,
        hasValue:
            informacoes['armaduras'] != null && informacoes['armaduras'] > 0,
        value: informacoes['armaduras']);

    // Medicamentos
    addItem('Medicamentos', Icons.local_pharmacy,
        hasValue: informacoes['medicamentos'] != null &&
            informacoes['medicamentos'] > 0,
        value: informacoes['medicamentos']);

    // Comida
    addItem('Comida', Icons.fastfood,
        hasValue: informacoes['comida'] != null && informacoes['comida'] > 0,
        value: informacoes['comida']);

    // Entretenimento
    addItem('Entretenimento', Icons.videogame_asset,
        hasValue: informacoes['entretenimento'] != null &&
            informacoes['entretenimento'] > 0,
        value: informacoes['entretenimento']);

    return informacoesWidgets; // Retorna a lista de widgets
  }
}
