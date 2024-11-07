import 'package:flutter/material.dart';

class InformacaoProduto extends StatelessWidget {
  final VoidCallback aoEditarProduto; // Callback para acessar a tela de edição
  final VoidCallback aoCancelar; // Callback para voltar à tela anterior

  const InformacaoProduto({
    super.key,
    required this.aoEditarProduto,
    required this.aoCancelar,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Centralizando o Card com a imagem e nome do produto
          const Center(
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
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
          // Seção de informações
          const Text(
            "INFORMAÇÕES",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 10),
          // Data de validade
          _buildInfoCard(
            icon: Icons.calendar_today,
            title: "DATA DE VALIDADE",
            description: "27 DE DEZEMBRO DE 2015 - EM 3 DIAS",
          ),
          const SizedBox(height: 10),
          // Quantidade
          _buildInfoCard(
            icon: Icons.scale,
            title: "QUANTIDADE",
            description: "250 KG",
          ),
          const SizedBox(height: 10),
          // Última compra / preço
          _buildInfoCard(
            icon: Icons.attach_money,
            title: "ÚLTIMA COMPRA / PREÇO",
            description: "20 DE DEZEMBRO 2015 | R\$ 19,90/kg",
          ),
          const SizedBox(height: 10),
          // Alerta de validade próxima
          const Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 5),
              Text(
                "DATA DE VALIDADE PRÓXIMA",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Botões de Editar e Voltar
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: aoCancelar, // Callback para voltar
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                  ),
                  child: const Text(
                    'VOLTAR',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: aoEditarProduto, // Callback para editar produto
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                  ),
                  child: const Text(
                    'EDITAR',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Função auxiliar para construir os cards de informação
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      color: Colors.orange[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.brown),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
