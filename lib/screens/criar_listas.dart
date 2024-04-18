// ignore_for_file: unnecessary_null_comparison, use_super_parameters, library_private_types_in_public_api, prefer_const_constructors, sort_child_properties_last

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lista_de_compras/screens/nome_lista.dart';
import 'package:lista_de_compras/screens/adicionar_produtos.dart';

class CriarListaCompras extends StatefulWidget {
  const CriarListaCompras({Key? key}) : super(key: key);

  @override
  _CriarListaComprasState createState() => _CriarListaComprasState();
}

class _CriarListaComprasState extends State<CriarListaCompras> {
  List<String> listas = [];

  @override
  void initState() {
    super.initState();
    _carregarListas();
  }

  Future<void> _carregarListas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listas = prefs.getStringList('listas') ?? [];
    });
  }

  Future<void> _salvarLista(String nomeLista) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> novasListas = List.from(listas)..add(nomeLista);
    await prefs.setStringList('listas', novasListas);
    setState(() {
      listas = novasListas;
    });
  }

  Future<void> _removerLista(String nomeLista) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> novasListas = List.from(listas)..remove(nomeLista);
    await prefs.setStringList('listas', novasListas);
    setState(() {
      listas = novasListas;
    });
  }

  bool _listaVazia() {
    return listas.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Minhas Listas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Seu'),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text('Curioso!'),
                  value: 2,
                ),
              ];
            },
          ),
        ],
      ),
      body: _listaVazia()
          ? _buildListaVazia()
          : ListView.builder(
              itemCount: listas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listas[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AdicionarProdutoLista(listaNome: listas[index])),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _removerLista(listas[index]);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final String listaNome = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListaNome()),
          );
          if (listaNome != null) {
            await _salvarLista(listaNome);
          }
        },
        label: Text(
          'Criar Lista',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildListaVazia() {
    final Random random = Random();
    final int randomNumber = random.nextInt(9) + 1;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/aleatorio$randomNumber.png',
            width: 250,
            height: 250,
          ),
          SizedBox(height: 20),
          Text(
            'Vamos planejar as compras!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Clique no botão para criar uma Lista',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
