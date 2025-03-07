import 'package:flutter/material.dart';

class CampoEscrever extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController controller;

  CampoEscrever({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    TextEditingController? controller,
  }) : controller = controller ?? TextEditingController();

  const CampoEscrever.comController({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.brown) : null,
        hintText: hintText,
        filled: true,
        fillColor: Colors.orange[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }


  String get text => controller.text;
}