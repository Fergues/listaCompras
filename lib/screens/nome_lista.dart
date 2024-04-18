// ignore_for_file: use_super_parameters, library_private_types_in_public_api, prefer_final_fields, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:lista_de_compras/screens/adicionar_produtos.dart';

class ListaNome extends StatefulWidget {
  const ListaNome({Key? key}) : super(key: key);

  @override
  _ListaNomeState createState() => _ListaNomeState();
}

class _ListaNomeState extends State<ListaNome> {
  TextEditingController _nomeListaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Nome da Lista',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Escolha um nome para sua lista:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Campo de texto para digitar o nome da lista manualmente
            TextField(
              controller: _nomeListaController,
              decoration: InputDecoration(
                hintText: 'Digite o nome da lista',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Sugestões:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Sugestões de nomes
            _buildSuggestedName(context, 'Minhas Compras'),
            _buildSuggestedName(context, 'Compras da Semana'),
            _buildSuggestedName(context, 'Lista de Supermercado'),
            _buildSuggestedName(context, 'Lista de Necessidades'),
          ],
        ),
      ),

      //Botão Criar no final da tela
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context, _nomeListaController.text);
          },
          label: Text(
            'Criar',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //Código para o usuário escolher dentre as sugestões
  Widget _buildSuggestedName(BuildContext context, String name) {
    return GestureDetector(
      onTap: () {
        _nomeListaController.text = name;
      },
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          name,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
