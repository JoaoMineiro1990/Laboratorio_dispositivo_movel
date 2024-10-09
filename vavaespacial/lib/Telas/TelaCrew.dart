import 'package:flutter/material.dart';
import 'package:vavaespacial/Telas/TelaArmamentoRecusos.dart';

class TelaCrew extends StatefulWidget {
  final Map<String, dynamic> informacoesAnteriores;
  final bool vindoDeAjustesFinais; // Para saber se veio de Ajustes Finais

  TelaCrew(
      {required this.informacoesAnteriores, this.vindoDeAjustesFinais = false});

  @override
  _TelaCrewState createState() => _TelaCrewState();
}

class _TelaCrewState extends State<TelaCrew> {
  int pontosTripulacao = 0;
  int sobraTripulacao = 0; // Variável para armazenar a sobra
  int engenheiros = 0;
  int cozinheiros = 0;
  int soldados = 0;
  int medicos = 0;
  @override
  void initState() {
    super.initState();

    // Verifica se há valores anteriores e os restaura, caso existam
    engenheiros = widget.informacoesAnteriores['engenheiros'] ?? 0;
    cozinheiros = widget.informacoesAnteriores['cozinheiros'] ?? 0;
    soldados = widget.informacoesAnteriores['soldados'] ?? 0;
    medicos = widget.informacoesAnteriores['medicos'] ?? 0;

    // Restaura os pontos disponíveis de tripulação
    pontosTripulacao = widget.informacoesAnteriores['tripulacao'].toInt();
  }

  // Custo por tripulação
  final int custoEngenheiro = 20;
  final int custoCozinheiro = 10;
  final int custoSoldado = 30;
  final int custoMedico = 20;

  // Função para calcular os pontos de sobrevivência
  int calcularSobrevivencia() {
    return engenheiros + (cozinheiros * 2) + medicos;
  }

  // Função para calcular os pontos de combate/navegação
  int calcularCombateNavegacao() {
    return engenheiros + (soldados * 2) + medicos;
  }

  // Função para adicionar tripulação
  void adicionarTripulante(String tipo) {
    setState(() {
      if (tipo == 'engenheiro' && pontosTripulacao >= custoEngenheiro) {
        engenheiros++;
        pontosTripulacao -= custoEngenheiro;
      } else if (tipo == 'cozinheiro' && pontosTripulacao >= custoCozinheiro) {
        cozinheiros++;
        pontosTripulacao -= custoCozinheiro;
      } else if (tipo == 'soldado' && pontosTripulacao >= custoSoldado) {
        soldados++;
        pontosTripulacao -= custoSoldado;
      } else if (tipo == 'medico' && pontosTripulacao >= custoMedico) {
        medicos++;
        pontosTripulacao -= custoMedico;
      }

      // Atualiza a sobra da tripulação após adição
      sobraTripulacao = pontosTripulacao;
    });
  }

// Função para remover tripulação
  void removerTripulante(String tipo) {
    setState(() {
      if (tipo == 'engenheiro' && engenheiros > 0) {
        engenheiros--;
        pontosTripulacao += custoEngenheiro;
      } else if (tipo == 'cozinheiro' && cozinheiros > 0) {
        cozinheiros--;
        pontosTripulacao += custoCozinheiro;
      } else if (tipo == 'soldado' && soldados > 0) {
        soldados--;
        pontosTripulacao += custoSoldado;
      } else if (tipo == 'medico' && medicos > 0) {
        medicos--;
        pontosTripulacao += custoMedico;
      }

      // Atualiza a sobra da tripulação após remoção
      sobraTripulacao = pontosTripulacao;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione sua Tripulação',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[900]!, Colors.red[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Pontos Disponíveis de Tripulação: $pontosTripulacao',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            _buildCrewSelector(
                'Engenheiro', engenheiros, 'engenheiro', custoEngenheiro),
            _buildCrewSelector(
                'Cozinheiro', cozinheiros, 'cozinheiro', custoCozinheiro),
            _buildCrewSelector('Soldado', soldados, 'soldado', custoSoldado),
            _buildCrewSelector('Médico', medicos, 'medico', custoMedico),
            const SizedBox(height: 20),
            _buildStatBar('Sobrevivência', calcularSobrevivencia()),
            _buildStatBar('Combate/Navegação', calcularCombateNavegacao()),
            const SizedBox(height: 20),

            // Se vier de Ajustes Finais, mostra o botão Atualizar
            if (widget.vindoDeAjustesFinais)
              // Dentro do botão 'Atualizar', que aparece se vier de Ajustes Finais:
              ElevatedButton(
                onPressed: () {
                  // Envia de volta todos os valores atualizados
                  Map<String, dynamic> valoresAtualizados = {
                    'engenheiros': engenheiros,
                    'cozinheiros': cozinheiros,
                    'soldados': soldados,
                    'medicos': medicos,
                    'sobraTripulacao': sobraTripulacao,
                  };

                  // Volta para a tela de ajustes finais com os valores
                  Navigator.pop(context, valoresAtualizados);
                },
                child: const Text('Atualizar'),
              )

// Se não veio de Ajustes Finais, mostra o botão Continuar
            else
              ElevatedButton(
                onPressed: () {
                  // Atualiza a sobra e os valores de tripulantes
                  sobraTripulacao = pontosTripulacao;

                  Map<String, dynamic> informacoesAtualizadas = {
                    ...widget.informacoesAnteriores,
                    'engenheiros': engenheiros,
                    'cozinheiros': cozinheiros,
                    'soldados': soldados,
                    'medicos': medicos,
                    'sobrevivencia': calcularSobrevivencia(),
                    'combateNavegacao': calcularCombateNavegacao(),
                    'sobraTripulacao': sobraTripulacao, // Atualiza a sobra
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaArmamentoRecursos(
                          informacoesAnteriores: informacoesAtualizadas),
                    ),
                  );
                },
                child: const Text('Continuar'),
              ),
          ],
        ),
      ),
    );
  }

  // Função para construir os incrementadores de tripulação
  Widget _buildCrewSelector(
      String nome, int quantidade, String tipo, int custo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$nome (Custo: $custo)',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => removerTripulante(tipo),
              icon: const Icon(Icons.remove, color: Colors.white),
            ),
            Text(
              '$quantidade',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            IconButton(
              onPressed: () => adicionarTripulante(tipo),
              icon: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  // Função para construir as barras de estatísticas
  Widget _buildStatBar(String nome, int valor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$nome: $valor',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        Slider(
          value: valor.toDouble(),
          min: 0,
          max: 100,
          divisions: 100,
          onChanged: null, // As barras são apenas indicadores
        ),
      ],
    );
  }
}
