import 'package:flutter/material.dart';
import 'package:vavaespacial/Telas/TelaArmamentoRecusos.dart';
import 'package:vavaespacial/Telas/TelaCrew.dart';
import 'package:vavaespacial/Telas/TelaPiloto.dart';
import 'package:vavaespacial/Telas/Lancamento.dart'; // Certifique-se de que este import está correto

class AjustesFinais extends StatefulWidget {
  final Map<String, dynamic> informacoesAnteriores;

  AjustesFinais({required this.informacoesAnteriores});

  @override
  _AjustesFinaisState createState() => _AjustesFinaisState();
}

class _AjustesFinaisState extends State<AjustesFinais> {
  int _selectedIndex = 0;
  Map<String, dynamic> informacoesCompletas = {};
  @override
  void initState() {
    super.initState();

    // Soma todas as sobras e guarda em sobraTotal
    int sobraTotal = (widget.informacoesAnteriores['sobraPiloto'] ?? 0) +
        (widget.informacoesAnteriores['sobraTripulacao'] ?? 0) +
        (widget.informacoesAnteriores['sobraArmamento'] ?? 0) +
        (widget.informacoesAnteriores['sobraRecursos'] ?? 0);

    // Zera as variáveis
    widget.informacoesAnteriores['tripulacao'] = 0;
    widget.informacoesAnteriores['piloto'] = 0;
    widget.informacoesAnteriores['armamento'] = 0;
    widget.informacoesAnteriores['recursos'] = 0;

    // Zera as sobras
    widget.informacoesAnteriores['sobraPiloto'] = 0;
    widget.informacoesAnteriores['sobraTripulacao'] = 0;
    widget.informacoesAnteriores['sobraArmamento'] = 0;
    widget.informacoesAnteriores['sobraRecursos'] = 0;

    // Armazena a sobra total para ser usada nas telas chamadas
    widget.informacoesAnteriores['sobraTotal'] = sobraTotal;
    informacoesCompletas = {
      ...widget.informacoesAnteriores,
      'sobraTotal': sobraTotal,
    };
  }

  // Soma todos os recursos restantes
  int calcularRecursosRestantes() {
    return (widget.informacoesAnteriores['sobraPiloto']?.toInt() ?? 0) +
        (widget.informacoesAnteriores['sobraTripulacao']?.toInt() ?? 0) +
        (widget.informacoesAnteriores['sobraArmamento']?.toInt() ?? 0) +
        (widget.informacoesAnteriores['sobraRecursos']?.toInt() ?? 0);
  }

  void _onItemTapped(int index) async {
    Map<String, dynamic>? resultado;

    switch (index) {
      case 0:
        // Envia o valor da sobra total para a tela de Crew
        resultado = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaCrew(
              informacoesAnteriores: {
                ...widget.informacoesAnteriores,
                'tripulacao': widget.informacoesAnteriores['sobraTotal'] ?? 0,
              },
              vindoDeAjustesFinais: true,
            ),
          ),
        );
        break;

      case 1:
        resultado = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaPiloto(
              informacoesAnteriores: {
                ...widget.informacoesAnteriores,
                'piloto': (widget.informacoesAnteriores['sobraTotal'] ?? 0) +
                    (widget.informacoesAnteriores['piloto'] ?? 0).toInt(),
              },
              vindoDeAjustesFinais: true,
            ),
          ),
        );
        break;
      case 2:
        // Divide a sobra total em duas partes
        int sobraTotal = widget.informacoesAnteriores['sobraTotal'] ?? 0;
        int sobraArmamento = sobraTotal ~/ 2; // Parte para armamento
        int sobraRecursos = sobraTotal - sobraArmamento; // Parte para recursos

        // Envia os valores para a tela de Armamento e Recursos
        resultado = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaArmamentoRecursos(
              informacoesAnteriores: {
                ...widget.informacoesAnteriores,
                'armamento': sobraArmamento,
                'recursos': sobraRecursos,
              },
              vindoDeAjustesFinais: true,
            ),
          ),
        );
        break;
      case 3:
        // Divide a sobra total em duas partes
        int sobraTotal = widget.informacoesAnteriores['sobraTotal'] ?? 0;
        int sobraArmamento = sobraTotal ~/ 2; // Parte para armamento
        int sobraRecursos = sobraTotal - sobraArmamento; // Parte para recursos

        // Envia os valores para a tela de Armamento e Recursos
        resultado = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaArmamentoRecursos(
              informacoesAnteriores: {
                ...widget.informacoesAnteriores,
                'armamento': sobraArmamento,
                'recursos': sobraRecursos,
              },
              vindoDeAjustesFinais: true,
            ),
          ),
        );
        break;
    }

    // Atualiza os valores ao retornar da tela de Crew ou Piloto
    if (resultado != null) {
      setState(() {
        // Atualiza os valores de tripulação ou piloto com os dados recebidos
        if (index == 0) {
          widget.informacoesAnteriores['engenheiros'] =
              resultado?['engenheiros'];
          widget.informacoesAnteriores['cozinheiros'] =
              resultado?['cozinheiros'];
          widget.informacoesAnteriores['soldados'] = resultado?['soldados'];
          widget.informacoesAnteriores['medicos'] = resultado?['medicos'];
          widget.informacoesAnteriores['sobraTotal'] =
              resultado?['sobraTripulacao'] ?? 0;
        } else if (index == 1) {
          widget.informacoesAnteriores['pilotoSelecionado'] =
              resultado?['pilotoSelecionado'];
          widget.informacoesAnteriores['sobraTotal'] =
              resultado?['sobraPiloto'] ?? 0;
        } else if (index == 2) {
          widget.informacoesAnteriores['armas'] = resultado?['armas'];
          widget.informacoesAnteriores['armaduras'] = resultado?['armaduras'];
          widget.informacoesAnteriores['medicamentos'] =
              resultado?['medicamentos'];
          widget.informacoesAnteriores['comida'] = resultado?['comida'];
          widget.informacoesAnteriores['entretenimento'] =
              resultado?['entretenimento'];

          widget.informacoesAnteriores['sobraTotal'] =
              (resultado?['sobraArmamento'] ?? 0) +
                  (resultado?['sobraRecursos'] ?? 0);
        }

        // Zera os valores de armamento e recursos
        widget.informacoesAnteriores['armamento'] = 0;
        widget.informacoesAnteriores['recursos'] = 0;
        widget.informacoesAnteriores['tripulacao'] = 0;
        widget.informacoesAnteriores['piloto'] = 0;

        informacoesCompletas = {
          ...widget.informacoesAnteriores,
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Ajustes Finais', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[900]!, Colors.red[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Recursos Restantes',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              '${widget.informacoesAnteriores['sobraTotal']}',
              style:
                  const TextStyle(fontSize: 22, color: Colors.lightBlueAccent),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Tipo fixo
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blue[800], // Cor da BottomNavigationBar
        selectedItemColor: Colors.white, // Cor dos itens selecionados
        unselectedItemColor: Colors.white70, // Cor dos itens não selecionados
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Crew',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flight),
            label: 'Piloto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Recursos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.security),
            label: 'Armamento',
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue[900], // Cor do botão flutuante
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Lancamento(informacoes: informacoesCompletas)),
            );
          },
          elevation: 0,
          child: const Icon(Icons.airplanemode_active,
              color: Colors.white), // Ícone do botão flutuante
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
