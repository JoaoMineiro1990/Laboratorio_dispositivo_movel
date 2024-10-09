import 'package:flutter/material.dart';
import 'dart:math';

import 'package:vavaespacial/Telas/TelaPiloto.dart';

class RecursosScreen extends StatefulWidget {
  final String viagemSelecionada;

  RecursosScreen({required this.viagemSelecionada});

  @override
  _RecursosScreenState createState() => _RecursosScreenState();
}

class _RecursosScreenState extends State<RecursosScreen> {
  int recursosGerados = 0;
  double piloto = 0;
  double armamento = 0;
  double tripulacao = 0;
  double recursos = 0;

  bool recursoGerado = false;

  // Calcula o total distribuído
  double _calcularTotalDistribuido() {
    return piloto + armamento + tripulacao + recursos;
  }

  // Calcula os recursos restantes
  double _calcularRecursosRestantes() {
    return recursosGerados - _calcularTotalDistribuido();
  }

  void _gerarRecursos() {
    setState(() {
      Random random = Random();
      recursosGerados =
          1000 + (random.nextInt(41) * 100); // Gera de 1000 a 5000
      recursoGerado = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recursos para ${widget.viagemSelecionada}',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // Centraliza o título
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: recursoGerado ? null : _gerarRecursos,
              child: Text('Gerar Suprimentos'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Recursos Restantes: ${_calcularRecursosRestantes().toInt()}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 16.0),
            _buildSlider('Piloto', piloto, (value) {
              if (_calcularRecursosRestantes() >= value - piloto) {
                setState(() {
                  piloto = value;
                });
              }
            }),
            _buildSlider('Armamento', armamento, (value) {
              if (_calcularRecursosRestantes() >= value - armamento) {
                setState(() {
                  armamento = value;
                });
              }
            }),
            _buildSlider('Tripulação', tripulacao, (value) {
              if (_calcularRecursosRestantes() >= value - tripulacao) {
                setState(() {
                  tripulacao = value;
                });
              }
            }),
            _buildSlider('Recursos', recursos, (value) {
              if (_calcularRecursosRestantes() >= value - recursos) {
                setState(() {
                  recursos = value;
                });
              }
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: recursoGerado &&
                      _calcularTotalDistribuido() >= (recursosGerados * 0.4)
                  ? () {
                      // Enviar as informações para a próxima tela
                      Map<String, dynamic> informacoes = {
                        'viagemSelecionada': widget.viagemSelecionada,
                        'recursosGerados': recursosGerados,
                        'piloto': piloto,
                        'armamento': armamento,
                        'tripulacao': tripulacao,
                        'recursos': recursos,
                      };
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TelaPiloto(
                            informacoesAnteriores: informacoes,
                          ),
                        ),
                      );
                    }
                  : null,
              child: Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${value.toInt()}',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Slider(
          value: value,
          min: 0,
          max: 1250,
          divisions: 125, // Para representar de 0 a 1250 com precisão
          onChanged: recursoGerado ? onChanged : null,
        ),
      ],
    );
  }
}
