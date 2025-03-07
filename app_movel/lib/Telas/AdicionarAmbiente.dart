// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'package:app_movel/Componentes/Botao.dart';
import 'package:app_movel/Componentes/CampoEscrever.dart';
import 'package:app_movel/Telas/Aplicacao.dart';
import 'package:app_movel/requisicoes/Conexao.dart';
import 'package:app_movel/requisicoes/GeladeiraReq.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdicionarAmbiente extends StatelessWidget {
  const AdicionarAmbiente({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nomeController = TextEditingController();
    TextEditingController descricaoController = TextEditingController();
    late GeladeiraReq geladeiraReq;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_home, size: 80, color: Colors.orange),
                      SizedBox(height: 10),
                      Text(
                        "NOVA GELADEIRA",
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
              hintText: "Digite o nome da Geladeira",
              prefixIcon: Icons.kitchen,
              controller: nomeController,
            ),
            const SizedBox(height: 10),
            CampoEscrever(
              hintText: "Descrição da Geladeira",
              prefixIcon: Icons.description,
              controller: descricaoController,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Botao(
                  texto: 'CANCELAR',
                  tipoNavegacao: 'push',
                  destino: Aplicacao(),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final userId = prefs.getString("user_id") ?? "";
                    print("User ID: $userId"); 
                    if (userId.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Erro: O usuário não foi encontrado."),
                      ));
                      return;
                    }

                    final nome = nomeController.text;
                    final descricao = descricaoController.text;

                    print("Nome da geladeira: $nome");
                    print(
                        "Descrição da geladeira: $descricao");
                    final conexao = await Conexao.getConnection();
                    geladeiraReq = GeladeiraReq(conexao);

                    final resultado = await geladeiraReq.inserirGeladeira(
                      nome,
                      descricao,
                      userId,
                    );

                    print(
                        "Resultado da inserção: $resultado"); 
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(resultado)));

                    if (resultado == "Geladeira adicionada com sucesso!") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Aplicacao()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[100],
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                  ),
                  child: const Text(
                    "ADICIONAR GELADEIRA", 
                    style: TextStyle(
                      color: Colors.black, 
                      fontSize: 16, 
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
