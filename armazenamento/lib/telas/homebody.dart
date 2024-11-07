import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/userprovider.dart';

class homebody extends StatelessWidget {
  const homebody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final username = userProvider.username ?? "Usuário desconhecido";
    final armas = userProvider.armas;
    final habilidades = userProvider.habilidades;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'lib/imagens/4k_wallpaper___warhammer_40_000___fan_art_by_aimages_dgm62an-fullview.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SingleChildScrollView(
            // Adicionado para permitir rolagem
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Bem-vindo, $username',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Oswald',
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Armas:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Oswald',
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                armas.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: armas
                            .map((arma) => ListTile(
                                  title: Text(
                                    arma,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Oswald',
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ))
                            .toList(),
                      )
                    : const Text(
                        'Nenhuma arma equipada.',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Oswald',
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                const SizedBox(height: 20),
                const Text(
                  'Habilidades:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Oswald',
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                habilidades.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: habilidades
                            .map((habilidade) => ListTile(
                                  title: Text(
                                    habilidade,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Oswald',
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ))
                            .toList(),
                      )
                    : const Text(
                        'Nenhuma habilidade selecionada.',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Oswald',
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
