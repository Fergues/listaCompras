// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SobreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Sobre',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tema escolhido:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Lista de compras de supermercado',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Objetivo do Aplicativo:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Ajudar os usuários a organizar e gerenciar suas compras de forma eficiente, economizando tempo e dinheiro, e evitando esquecimentos de itens importantes.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Desenvolvedor:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Fernando Ferreira Rodrigues',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Disciplina:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Desenvolvimento de aplicativos móveis',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Instituição:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Fatec',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Professor:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Rodrigo Plotze',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
