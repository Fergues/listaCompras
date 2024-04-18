// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class ValidadorLogin {
  static String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um email válido.';
    }
    return null;
  }

  static String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira uma senha válida.';
    }
    return null;
  }
}
