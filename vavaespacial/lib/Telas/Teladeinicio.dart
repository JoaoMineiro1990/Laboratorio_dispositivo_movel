import 'package:flutter/material.dart';
import 'package:vavaespacial/Telas/SelecionarViagem.dart';

class TelaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Viagem Espacial'),
        backgroundColor: Colors.blue[900], // Azul espacial
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue[900]!,
              Colors.red[900]!
            ], // Azul indo pro vermelho
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/Imagens/foguete.png',
                width: 150,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Você está indo fazer uma viagem espacial, defina seus recursos, sua tripulação e seus recursos e boa sorte',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelecionarViagem(),
                    ),
                  );
                },
                child: Text('Vamos lá'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
