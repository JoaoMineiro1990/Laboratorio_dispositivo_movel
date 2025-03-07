import 'package:app_movel/Componentes/Cabecalho.dart';
import 'package:flutter/material.dart';
import 'package:app_movel/Componentes/botao.dart';
import 'package:app_movel/Componentes/CampoEscrever.dart';

class EdicaoProduto extends StatelessWidget {
  const EdicaoProduto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cabecalho(
        titulo: 'StockPocket',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.local_offer, size: 80, color: Colors.yellow),
                      SizedBox(height: 10),
                      Text(
                        "PRODUTO5",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            CampoEscrever(
              hintText:
                  "27 DE DEZEMBRO DE 2015", 
              prefixIcon: Icons.calendar_today,
            ),
            const SizedBox(height: 10),
            CampoEscrever(
              hintText: "250 KG",
              prefixIcon: Icons.scale,
            ),
            const SizedBox(height: 10),
            CampoEscrever(
              hintText:
                  "20 DE DEZEMBRO DE 2015", 
            ),
            const SizedBox(height: 10),
            CampoEscrever(
              hintText:
                  "R\$ 19,90/kg", 
              prefixIcon: Icons.attach_money,
            ),
            const SizedBox(height: 10),
            CampoEscrever(
              hintText:
                  "PRODUTO5", 
              prefixIcon: Icons.local_offer,
            ),
            const SizedBox(height: 10),
            CampoEscrever(
              hintText:
                  "INSIRA O LINK DA IMAGEM", 
              prefixIcon: Icons.image,
            ),
            const SizedBox(height: 10),
            CampoEscrever(
              hintText:
                  "1KG POR DIA", 
              prefixIcon: Icons.fastfood,
            ),
            const SizedBox(height: 20), 
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Botao(
                  texto: 'VOLTAR',
                  tipoNavegacao: 'pop',
                ),
                SizedBox(width: 10),
                Botao(texto: 'ATUALIZAR', tipoNavegacao: 'pop'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
