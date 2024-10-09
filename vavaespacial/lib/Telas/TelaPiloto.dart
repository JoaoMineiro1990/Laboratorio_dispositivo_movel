import 'package:flutter/material.dart';
import 'package:vavaespacial/Telas/TelaCrew.dart';

class TelaPiloto extends StatefulWidget {
  final Map<String, dynamic> informacoesAnteriores;
  final bool vindoDeAjustesFinais;

  TelaPiloto({
    required this.informacoesAnteriores,
    this.vindoDeAjustesFinais = false, // Valor padrão
  });

  @override
  _TelaPilotoState createState() => _TelaPilotoState();
}

class _TelaPilotoState extends State<TelaPiloto> {
  String? pilotoSelecionado;
  late int valorPilotoRestante;

  // Lista de pilotos com suas partes e seus nomes
  final List<Map<String, dynamic>> pilotos = [
    {'nome': 'Seu Zé', 'partes': 5},
    {'nome': 'Luiz Gonzaga', 'partes': 10},
    {'nome': 'Harry Styles', 'partes': 15},
    {'nome': 'Duda Beat', 'partes': 25},
  ];

  @override
  void initState() {
    super.initState();

    // Restaura o piloto selecionado, se houver
    pilotoSelecionado = widget.informacoesAnteriores['pilotoSelecionado'];

    // Restaura o valor de piloto, garantindo que seja um int
    int pilotoValor = (widget.informacoesAnteriores['piloto'] ?? 0).toInt();
    valorPilotoRestante =
        pilotoValor; // Atribui o valor à variável de valor restante
  }

  // Função para retornar a pontuação total do piloto multiplicando pelas partes
  int _getPontuacaoPiloto(int partes) {
    return partes * 25; // Multiplica as partes por 25 para calcular a pontuação
  }

  @override
  Widget build(BuildContext context) {
    int valorPiloto = widget.informacoesAnteriores['piloto'].toInt();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione o Piloto',
            style: TextStyle(color: Colors.white)),
        centerTitle: true, // Centraliza o título
        backgroundColor: Colors.blue[900], // Azul espacial
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context)
                .size
                .height, // Garante que ocupe a altura total
          ),
          child: Container(
            width: double.infinity, // Ocupa toda a largura
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[900]!, Colors.red[900]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selecione seu piloto:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                if (valorPiloto <= 625) ...[
                  _buildCheckboxPiloto(pilotos[0]['nome'],
                      _getPontuacaoPiloto(pilotos[0]['partes'])),
                  _buildCheckboxPiloto(pilotos[1]['nome'],
                      _getPontuacaoPiloto(pilotos[1]['partes'])),
                ] else ...[
                  for (var piloto in pilotos)
                    _buildCheckboxPiloto(
                        piloto['nome'], _getPontuacaoPiloto(piloto['partes'])),
                ],
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      // Se vier de Ajustes Finais, exibe o botão Atualizar
                      if (widget
                          .vindoDeAjustesFinais) // Use a flag vinda diretamente do widget
                        ElevatedButton(
                          onPressed: () {
                            if (pilotoSelecionado != null) {
                              // Apenas atualiza se um piloto for selecionado
                              Map<String, dynamic> valoresAtualizados = {
                                ...widget.informacoesAnteriores,
                                'pilotoSelecionado': pilotoSelecionado,
                                'piloto': valorPilotoRestante,
                                'sobraPiloto': valorPilotoRestante,
                              };

                              // Retorna para a tela anterior (Ajustes Finais) com os valores atualizados
                              Navigator.pop(context, valoresAtualizados);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // Cor do botão
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                          ),
                          child: const Text('Atualizar',
                              style: TextStyle(fontSize: 18)),
                        ),
                      // Botão Continuar (caso contrário)
                      if (!widget.vindoDeAjustesFinais)
                        ElevatedButton(
                          onPressed: pilotoSelecionado != null
                              ? () {
                                  Map<String, dynamic> informacoesAtualizadas =
                                      {
                                    ...widget.informacoesAnteriores,
                                    'piloto': valorPilotoRestante,
                                    'pilotoSelecionado': pilotoSelecionado,
                                  };

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TelaCrew(
                                        informacoesAnteriores:
                                            informacoesAtualizadas,
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // Cor do botão
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                          ),
                          child: const Text('Continuar',
                              style: TextStyle(fontSize: 18)),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxPiloto(String nome, int pontuacaoNovoPiloto) {
    return CheckboxListTile(
      title: Text(
        '$nome (Pontuação: $pontuacaoNovoPiloto)',
        style: const TextStyle(color: Colors.white),
      ),
      value: pilotoSelecionado == nome,
      onChanged: (bool? value) {
        setState(() {
          if (value == true && pilotoSelecionado != nome) {
            // Se já houver um piloto selecionado
            if (pilotoSelecionado != null) {
              // Calcula a pontuação do piloto atual
              int pontuacaoAtual = _getPontuacaoPiloto(pilotos
                  .firstWhere((p) => p['nome'] == pilotoSelecionado)['partes']);

              // Calcula a diferença entre o novo piloto e o atual
              int diferenca = pontuacaoNovoPiloto - pontuacaoAtual;

              // Caso 1: Novo piloto é mais caro
              if (diferenca > 0) {
                // Verifica se há sobra suficiente
                if (valorPilotoRestante >= diferenca) {
                  pilotoSelecionado = nome; // Escolhe o novo piloto
                  valorPilotoRestante -= diferenca; // Subtrai a diferença
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Sobra insuficiente para escolher $nome'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
              // Caso 2: Novo piloto é mais barato
              else if (diferenca < 0) {
                pilotoSelecionado = nome; // Escolhe o novo piloto
                valorPilotoRestante -=
                    diferenca; // Adiciona a diferença à sobra
              }
              // Caso 3: Se for igual, apenas troca o piloto
              else {
                pilotoSelecionado = nome; // Escolhe o novo piloto
              }
            } else {
              pilotoSelecionado = nome; // Escolhe o novo piloto
              valorPilotoRestante -=
                  pontuacaoNovoPiloto; // Subtrai o valor do primeiro piloto
            }
          }
        });
      },
      activeColor: const Color.fromARGB(255, 255, 255, 255),
      checkColor: Colors.orange, // Cor do check
      fillColor:
          WidgetStateProperty.all(Colors.white), // Cor da caixa desmarcada
    );
  }
}
