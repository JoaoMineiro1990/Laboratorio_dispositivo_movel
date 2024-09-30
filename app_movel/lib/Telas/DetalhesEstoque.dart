import 'package:flutter/material.dart';

class DetalheEstoque extends StatelessWidget {
  final String titulo;
  final String descricao;
  final VoidCallback aoAcessarAmbientes; // Callback para acessar ambientes

  const DetalheEstoque({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.aoAcessarAmbientes,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Caixa do estoque
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.inventory,
                      size: 100, color: Colors.brown), // Ícone da caixa padrão
                  const SizedBox(height: 10),
                  Text(
                    titulo,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown),
                  ),
                  Text(
                    descricao,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Usuários que têm acesso:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Usar CircleAvatar como imagem temporária
                      Column(
                        children: [
                          CircleAvatar(
                              radius: 24, backgroundColor: Colors.brown),
                          SizedBox(height: 5),
                          Text("Harry Styles"),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                              radius: 24, backgroundColor: Colors.brown),
                          SizedBox(height: 5),
                          Text("Patricia"),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                              radius: 24, backgroundColor: Colors.brown),
                          SizedBox(height: 5),
                          Text("The Flash"),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                              radius: 24, backgroundColor: Colors.brown),
                          SizedBox(height: 5),
                          Text("Stolas"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Seção de informações
          const Text(
            "INFORMAÇÕES",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
          ),
          const SizedBox(height: 10),
          const Text(
            "CRIADO EM: 29 de novembro de 2023\n"
            "ÚLTIMA ATUALIZAÇÃO: 24 de agosto de 2024\n"
            "NÚMERO DE AMBIENTES: 10\n"
            "LOCALIZAÇÃO: Rua da minha casa que fica no bairro da minha casa na cidade da minha casa no país onde eu moro.",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),
          // Botão de Acessar
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              onPressed: aoAcessarAmbientes, // Usa o callback para navegar
              child: const Text(
                'ACESSAR',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
