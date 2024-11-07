import 'package:flutter/material.dart';

class EdicaoProduto extends StatelessWidget {
  const EdicaoProduto(
      {super.key,
      required this.aoCancelar,
      required this.aoSalvarAlteracaoProduto});
  final VoidCallback aoSalvarAlteracaoProduto;
  final VoidCallback aoCancelar;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Produto
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
                          Icon(Icons.local_offer,
                              size: 80, color: Colors.yellow),
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
                // Todos os campos de edição seguem abaixo
                _buildEditableField(
                  label: "DATA DE VALIDADE:",
                  hintText: "27 DE DEZEMBRO DE 2015",
                ),
                const SizedBox(height: 10),
                _buildEditableField(
                  label: "QUANTIDADE:",
                  hintText: "250 KG",
                ),
                const SizedBox(height: 10),
                _buildEditableField(
                  label: "ÚLTIMA COMPRA:",
                  hintText: "20 DE DEZEMBRO DE 2015",
                ),
                const SizedBox(height: 10),
                _buildEditableField(
                  label: "PREÇO:",
                  hintText: "R\$ 19,90/kg",
                ),
                const SizedBox(height: 10),
                _buildEditableField(
                  label: "NOME:",
                  hintText: "PRODUTO5",
                ),
                const SizedBox(height: 10),
                _buildEditableField(
                  label: "IMAGEM:",
                  hintText: "INSIRA O LINK DA IMAGEM",
                ),
                const SizedBox(height: 10),
                _buildEditableField(
                  label: "CONSUMO MÉDIO:",
                  hintText: "1KG POR DIA",
                ),
              ],
            ),
          ),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text(
                  'VOLTAR',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: aoSalvarAlteracaoProduto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text(
                  'ATUALIZAR',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildEditableField({
    required String label,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.orange[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
