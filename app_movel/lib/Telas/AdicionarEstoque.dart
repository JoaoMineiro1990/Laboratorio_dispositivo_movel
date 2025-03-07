import 'package:app_movel/Telas/Aplicacao.dart';
import 'package:flutter/material.dart';
import 'package:app_movel/Componentes/botao.dart';
import 'package:app_movel/Componentes/CampoEscrever.dart'; // Certifique-se de importar a classe CampoEscrever

class AdicionarEstoque extends StatelessWidget {
  const AdicionarEstoque({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem no topo da tela
          const Center(
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_home,
                        size: 80, color: Colors.orange), // Ícone do ambiente
                    SizedBox(height: 10),
                    Text(
                      "NOVO AMBIENTE",
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
          // Nome do Estoque
          CampoEscrever(
            hintText: "Digite o nome do estoque",
            prefixIcon: Icons.home,
          ),
          const SizedBox(height: 10),
          // Descrição do Estoque
          CampoEscrever(
            hintText: "ESTOQUE1",
            prefixIcon: Icons.description,
          ),
          const SizedBox(height: 10),
          // Localização do Estoque
          CampoEscrever(
            hintText: "Rua 10",
            prefixIcon: Icons.location_on,
          ),
          const SizedBox(height: 20),
          // Botões de Adicionar e Cancelar
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Botao(
                texto: 'ADICIONAR',
                tipoNavegacao: 'push',
                destino: Aplicacao(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
