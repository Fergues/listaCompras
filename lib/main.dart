// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:lista_de_compras/screens/principal_view.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder:(context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrincipalView(),
    );
  }
}


