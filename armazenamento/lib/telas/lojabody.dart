import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/userprovider.dart';

class lojabody extends StatelessWidget {
  const lojabody({Key? key}) : super(key: key);

  void _mostrarDialogoAdicionarItem(BuildContext context, bool isArma) {
    final TextEditingController itemController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Bordas pontiagudas
          ),
          title: Text(
            'Adicionar nova ${isArma ? 'arma' : 'habilidade'}',
            style: const TextStyle(color: Colors.white, fontFamily: 'Oswald'),
          ),
          content: TextField(
            controller: itemController,
            decoration: const InputDecoration(
              hintText: 'Nome do item',
              hintStyle: TextStyle(color: Colors.white54),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Voltar',
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                final itemName = itemController.text.trim();
                if (itemName.isNotEmpty) {
                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  final exists = isArma
                      ? userProvider.armas.contains(itemName)
                      : userProvider.habilidades.contains(itemName);

                  if (!exists) {
                    isArma
                        ? userProvider.adicionarArma(itemName)
                        : userProvider.adicionarHabilidade(itemName);
                    Navigator.of(context).pop();
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.black87,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          title: const Text(
                            'Item já existe!',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Oswald'),
                          ),
                          content: Text(
                            '${isArma ? 'Arma' : 'Habilidade'} já está na sua lista.',
                            style: const TextStyle(color: Colors.white),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colors.orangeAccent),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              child: const Text(
                'Adicionar',
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final armas = userProvider.armas;
    final habilidades = userProvider.habilidades;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('lib/imagens/Rogue-Trader-Weapons-768x460.jpg.webp'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(vertical: 32.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.zero, // Bordas pontiagudas
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Loja',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Oswald',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildScrollableItemList(context, 'Armas', armas, true),
                  const SizedBox(width: 20),
                  _buildScrollableItemList(
                      context, 'Habilidades', habilidades, false),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        _mostrarDialogoAdicionarItem(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
                    child: const Text(
                      'Adicionar nova arma',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Oswald',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () =>
                        _mostrarDialogoAdicionarItem(context, false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
                    child: const Text(
                      'Adicionar nova habilidade',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Oswald',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableItemList(
      BuildContext context, String title, List<String> items, bool isArma) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.zero, // Bordas pontiagudas
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '$title:',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Oswald',
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 8,
              radius: const Radius.circular(0), // Bordas retas
              interactive: true,
              child: ListView.builder(
                padding: const EdgeInsets.only(right: 8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Colors.black87, width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              items[index],
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Oswald',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.remove, color: Colors.redAccent),
                          onPressed: () => isArma
                              ? userProvider.removerArma(items[index])
                              : userProvider.removerHabilidade(items[index]),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
