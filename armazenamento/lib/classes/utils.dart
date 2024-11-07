import 'package:armazenamento/classes/notificacao.dart';
import 'package:armazenamento/classes/userprovider.dart';
import 'package:armazenamento/telas/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../classes/usuario.dart';

class Utils {
  static SharedPreferences? _preferences;

  static Future<void> initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveUserPreference(
      String username, bool rememberUser) async {
    await _preferences?.setBool('rememberUser', rememberUser);
    if (rememberUser) {
      await _preferences?.setString('savedUsername', username);
    } else {
      await _preferences?.remove('savedUsername');
    }
  }

  static Future<String?> loadRememberedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberUser = prefs.getBool('rememberUser') ?? false;
    if (rememberUser) {
      return prefs.getString('savedUsername');
    }
    return null;
  }

  // Função para verificar campos de username e password
  static bool verificarCampos(
      BuildContext context, String username, String password) {
    if (username.isEmpty && password.isEmpty) {
      Notificacao.showNotificacao(context, TipoNotificacao.espacoNaoPreenchido);
      return false;
    } else if (username.isEmpty) {
      Notificacao.showNotificacao(
          context, TipoNotificacao.usuarioNaoEncontrado);
      return false;
    } else if (password.isEmpty) {
      Notificacao.showNotificacao(context, TipoNotificacao.informacaoIncorreta);
      return false;
    }
    return true;
  }

  // Função para verificar se as senhas são iguais
  static bool verificarConfirmacaoSenha(String senha, String confirmarSenha) {
    return senha == confirmarSenha;
  }

  // Função para verificar se o email ou o nome de usuário já existem
  static Future<bool> verificarDisponibilidade(
      String username, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> usersData = prefs.getStringList('users') ?? [];

    for (String userData in usersData) {
      Map<String, dynamic> userJson = jsonDecode(userData);
      if (userJson['username'] == username || userJson['email'] == email) {
        return false; // Usuário ou email já existe
      }
    }
    return true; // Disponível
  }

  // Função para cadastrar o usuário
  static Future<bool> cadastrarUsuario(BuildContext context, String username,
      String password, String email) async {
    // Verifica se o nome de usuário ou email já existe
    bool isAvailable = await verificarDisponibilidade(username, email);

    if (!isAvailable) {
      Notificacao.showNotificacao(
          context,
          TipoNotificacao
              .jaExiste); // Notificação correta para usuário já existente
      return false;
    }

    // Cria o objeto User e salva como JSON no SharedPreferences
    final user = User(username: username, password: password);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> usersData = prefs.getStringList('users') ?? [];
    usersData.add(jsonEncode(user.toJson())); // Adiciona o novo usuário

    await prefs.setStringList('users', usersData); // Salva a lista atualizada

    // Notificação de sucesso para o cadastro
    Notificacao.showNotificacao(context, TipoNotificacao.ok);
    return true;
  }

  // Função para processar o cadastro completo do usuário
  static Future<void> processarCadastro(BuildContext context, String username,
      String password, String confirmarSenha, String email) async {
    // Verifica se todos os campos estão preenchidos
    if (!verificarCampos(context, username, password) || email.isEmpty) {
      Notificacao.showNotificacao(context, TipoNotificacao.espacoNaoPreenchido);
      return;
    }

    // Verifica se as senhas são iguais
    if (!verificarConfirmacaoSenha(password, confirmarSenha)) {
      Notificacao.showNotificacao(context, TipoNotificacao.informacaoIncorreta);
      return;
    }

    // Verifica se o nome de usuário ou email já existe
    bool sucesso = await cadastrarUsuario(context, username, password, email);

    if (sucesso) {
      Navigator.pop(context);
      Notificacao.showNotificacao(context, TipoNotificacao.ok);
    }
  }

  // Função para verificar se o usuário e senha combinam
  static Future<bool> verificarCredenciais(
      String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> usersData = prefs.getStringList('users') ?? [];

    for (String userData in usersData) {
      Map<String, dynamic> userJson = jsonDecode(userData);
      if (userJson['username'] == username &&
          userJson['password'] == password) {
        return true; // Usuário e senha combinam
      }
    }
    return false; // Usuário e senha não combinam
  }

  static Future<void> logar(BuildContext context, String username,
      String password, bool rememberUser) async {
    // Verifica se os campos estão preenchidos
    if (!verificarCampos(context, username, password)) return;

    // Verifica se as credenciais (usuário e senha) estão corretas
    bool credenciaisValidas = await verificarCredenciais(username, password);

    if (credenciaisValidas) {
      // Salva as preferências de login se o usuário deseja lembrar o login
      await saveUserPreference(username, rememberUser);

      // Atualiza o UserProvider com o nome do usuário
      Provider.of<UserProvider>(context, listen: false).login(username);

      // Navegação substituindo a tela de login por Home
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      // Notificação de erro se as credenciais não combinarem
      Notificacao.showNotificacao(
          context, TipoNotificacao.usuarioNaoEncontrado);
    }
  }
}
