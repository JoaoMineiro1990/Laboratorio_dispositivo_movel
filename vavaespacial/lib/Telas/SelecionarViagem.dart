import 'package:flutter/material.dart';
import 'package:vavaespacial/Telas/RecursosScreen.dart';

class SelecionarViagem extends StatefulWidget {
  @override
  _SelecionarViagemState createState() => _SelecionarViagemState();
}

class _SelecionarViagemState extends State<SelecionarViagem> {
  // Variáveis para controlar o estado das checkboxes
  String? viagemSelecionada;

  void _selecionarViagem(String viagem) {
    setState(() {
      viagemSelecionada = viagem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione a Viagem',
            style: TextStyle(color: Colors.white)),
        centerTitle: true, // Centraliza o título
        backgroundColor: Colors.blue[900], // Azul espacial
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue[900]!,
              Colors.red[900]!
            ], // Gradiente azul para vermelho
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centraliza os elementos verticalmente
          crossAxisAlignment: CrossAxisAlignment
              .center, // Centraliza os elementos horizontalmente
          children: [
            const Text(
              'Escolha o tipo de viagem:',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('Viagem a Longa Distância',
                  style: TextStyle(color: Colors.white)),
              value: viagemSelecionada == 'Viagem a Longa Distância',
              onChanged: (bool? value) {
                if (value == true) {
                  _selecionarViagem('Viagem a Longa Distância');
                }
              },
              activeColor: Colors.orange,
              checkColor: Colors.orange, // Cor do check
              fillColor: WidgetStateProperty.all(
                  Colors.white), // Cor da caixa desmarcada
            ),
            CheckboxListTile(
              title: const Text('Viagens Perigosas',
                  style: TextStyle(color: Colors.white)),
              value: viagemSelecionada == 'Viagens Perigosas',
              onChanged: (bool? value) {
                if (value == true) {
                  _selecionarViagem('Viagens Perigosas');
                }
              },
              activeColor: Colors.orange,
              checkColor: Colors.orange, // Cor do check
              fillColor: WidgetStateProperty.all(
                  Colors.white), // Cor da caixa desmarcada
            ),
            CheckboxListTile(
              title: const Text('Viagens Difíceis',
                  style: TextStyle(color: Colors.white)),
              value: viagemSelecionada == 'Viagens Difíceis',
              onChanged: (bool? value) {
                if (value == true) {
                  _selecionarViagem('Viagens Difíceis');
                }
              },
              activeColor: Colors.orange,
              checkColor: Colors.orange, // Cor do check
              fillColor: WidgetStateProperty.all(
                  Colors.white), // Cor da caixa desmarcada
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: viagemSelecionada != null
                    ? () {
                        // Envia a viagem selecionada para a próxima tela
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecursosScreen(
                              viagemSelecionada: viagemSelecionada!,
                            ),
                          ),
                        );
                      }
                    : null, // Desabilita o botão se nenhuma viagem for selecionada
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Cor do botão
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Próximo', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
