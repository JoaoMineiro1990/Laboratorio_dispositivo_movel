import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _username;
  List<String> _armas = [];
  List<String> _habilidades = [];

  String? get username => _username;
  List<String> get armas => _armas;
  List<String> get habilidades => _habilidades;

  // Função para fazer login (configura o usuário e notifica ouvintes)
  void login(String username) {
    _username = username;
    _armas = []; // Reseta as listas ao logar
    _habilidades = [];
    notifyListeners();
  }

  // Função para fazer logout
  void logout() {
    _username = null;
    _armas.clear();
    _habilidades.clear();
    notifyListeners();
  }

  // Funções para gerenciar armas
  void adicionarArma(String arma) {
    if (!_armas.contains(arma)) {
      _armas.add(arma);
      notifyListeners();
    }
  }

  void removerArma(String arma) {
    _armas.remove(arma);
    notifyListeners();
  }

  // Funções para gerenciar habilidades
  void adicionarHabilidade(String habilidade) {
    if (!_habilidades.contains(habilidade)) {
      _habilidades.add(habilidade);
      notifyListeners();
    }
  }

  void removerHabilidade(String habilidade) {
    _habilidades.remove(habilidade);
    notifyListeners();
  }
}
