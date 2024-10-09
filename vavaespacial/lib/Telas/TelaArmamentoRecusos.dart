import 'package:flutter/material.dart';
import 'package:vavaespacial/Telas/AjustesFinais.dart';

class TelaArmamentoRecursos extends StatefulWidget {
  final Map<String, dynamic> informacoesAnteriores;
  final bool vindoDeAjustesFinais;

  const TelaArmamentoRecursos({
    required this.informacoesAnteriores,
    this.vindoDeAjustesFinais = false,
  });

  @override
  _TelaArmamentoRecursosState createState() => _TelaArmamentoRecursosState();
}

class _TelaArmamentoRecursosState extends State<TelaArmamentoRecursos> {
  // Pontos iniciais
  int pontosArmamento = 0;
  int pontosRecursos = 0;

  // Quantidades para armamento e recursos
  int armas = 0;
  int armaduras = 0;
  int medicamentos = 0;
  int comida = 0;
  int entretenimento = 0;

  // Custos para cada item
  final int custoArma = 50;
  final int custoArmadura = 75;
  final int custoMedicamento = 30;
  final int custoComida = 20;
  final int custoEntretenimento = 40;

  @override
  void initState() {
    super.initState();
    // Inicializa os pontos de armamento e recursos
    pontosArmamento = widget.informacoesAnteriores['armamento']?.toInt() ?? 0;
    pontosRecursos = widget.informacoesAnteriores['recursos']?.toInt() ?? 0;

    // Recupera as quantidades salvas de armamento e recursos
    armas = widget.informacoesAnteriores['armas'] ?? 0;
    armaduras = widget.informacoesAnteriores['armaduras'] ?? 0;
    medicamentos = widget.informacoesAnteriores['medicamentos'] ?? 0;
    comida = widget.informacoesAnteriores['comida'] ?? 0;
    entretenimento = widget.informacoesAnteriores['entretenimento'] ?? 0;
  }

  // Funções para gerenciar armamento
  void adicionarArmamento(String tipo) {
    setState(() {
      if (tipo == 'arma' && pontosArmamento >= custoArma) {
        armas++;
        pontosArmamento -= custoArma;
      } else if (tipo == 'armadura' && pontosArmamento >= custoArmadura) {
        armaduras++;
        pontosArmamento -= custoArmadura;
      }
    });
  }

  void removerArmamento(String tipo) {
    setState(() {
      if (tipo == 'arma' && armas > 0) {
        armas--;
        pontosArmamento += custoArma;
      } else if (tipo == 'armadura' && armaduras > 0) {
        armaduras--;
        pontosArmamento += custoArmadura;
      }
    });
  }

  // Funções para gerenciar recursos
  void adicionarRecurso(String tipo) {
    setState(() {
      if (tipo == 'medicamento' && pontosRecursos >= custoMedicamento) {
        medicamentos++;
        pontosRecursos -= custoMedicamento;
      } else if (tipo == 'comida' && pontosRecursos >= custoComida) {
        comida++;
        pontosRecursos -= custoComida;
      } else if (tipo == 'entretenimento' &&
          pontosRecursos >= custoEntretenimento) {
        entretenimento++;
        pontosRecursos -= custoEntretenimento;
      }
    });
  }

  void removerRecurso(String tipo) {
    setState(() {
      if (tipo == 'medicamento' && medicamentos > 0) {
        medicamentos--;
        pontosRecursos += custoMedicamento;
      } else if (tipo == 'comida' && comida > 0) {
        comida--;
        pontosRecursos += custoComida;
      } else if (tipo == 'entretenimento' && entretenimento > 0) {
        entretenimento--;
        pontosRecursos += custoEntretenimento;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Armamento e Recursos'),
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
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Coluna para Armamento
                  _buildArmamentoColumn(),
                  // Coluna para Recursos
                  _buildRecursoColumn(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  // Função para construir a coluna de armamento
  Widget _buildArmamentoColumn() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Armamento',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 20),
          _buildArmamentoSelector('Armas', armas, 'arma', custoArma),
          _buildArmamentoSelector(
              'Armadura', armaduras, 'armadura', custoArmadura),
          const SizedBox(height: 20),
          Text(
            'Pontos Restantes de Armamento: $pontosArmamento',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Função para construir a coluna de recursos
  Widget _buildRecursoColumn() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Recursos',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 20),
          _buildRecursoSelector(
              'Medicamentos', medicamentos, 'medicamento', custoMedicamento),
          _buildRecursoSelector('Comida', comida, 'comida', custoComida),
          _buildRecursoSelector('Entretenimento', entretenimento,
              'entretenimento', custoEntretenimento),
          const SizedBox(height: 20),
          Text(
            'Pontos Restantes de Recursos: $pontosRecursos',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Função para construir os botões de baixo
  Widget _buildBottomButtons() {
    return Center(
      child: Column(
        children: [
          // Botão de Atualizar
          if (widget.vindoDeAjustesFinais) ...[
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> informacoesAtualizadas = {
                  ...widget.informacoesAnteriores,
                  'armas': armas,
                  'armaduras': armaduras,
                  'medicamentos': medicamentos,
                  'comida': comida,
                  'entretenimento': entretenimento,
                  'sobraArmamento': pontosArmamento,
                  'sobraRecursos': pontosRecursos,
                };

                // Retorna à tela anterior com as informações atualizadas
                Navigator.pop(context, informacoesAtualizadas);
              },
              child: const Text('Atualizar'),
            ),
            const SizedBox(height: 10), // Espaço entre os botões
          ],
          if (!widget.vindoDeAjustesFinais) ...[
// Botão de Continuar
            ElevatedButton(
              onPressed: () {
                // A lógica de continuar
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AjustesFinais(
                      informacoesAnteriores: {
                        ...widget.informacoesAnteriores,
                        'armas': armas,
                        'armaduras': armaduras,
                        'medicamentos': medicamentos,
                        'comida': comida,
                        'entretenimento': entretenimento,
                      },
                    ),
                  ),
                );
              },
              child: const Text('Continuar'),
            ),
          ]
        ],
      ),
    );
  }

  // Função para construir os incrementadores de armamento
  Widget _buildArmamentoSelector(
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
              onPressed: () => removerArmamento(tipo),
              icon: const Icon(Icons.remove, color: Colors.white),
            ),
            Text(
              '$quantidade',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            IconButton(
              onPressed: () => adicionarArmamento(tipo),
              icon: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  // Função para construir os incrementadores de recursos
  Widget _buildRecursoSelector(
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
              onPressed: () => removerRecurso(tipo),
              icon: const Icon(Icons.remove, color: Colors.white),
            ),
            Text(
              '$quantidade',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            IconButton(
              onPressed: () => adicionarRecurso(tipo),
              icon: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
