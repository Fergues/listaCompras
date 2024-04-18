// ignore_for_file: unused_import, use_super_parameters, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Produto {
  final String nome;
  final double quantidade;
  final String unidadeMedida;
  bool comprado; // Adicionando o atributo comprado

  Produto({
    required this.nome,
    this.quantidade = 0.0,
    this.unidadeMedida = 'Unidades',
    this.comprado = false, // Definindo o valor padrão de comprado como false
  });
}

class AdicionarProdutoLista extends StatefulWidget {
  final String listaNome; // Adicionando um parâmetro listaNome
  AdicionarProdutoLista({Key? key, required this.listaNome}) : super(key: key);

  @override
  _AdicionarProdutoListaState createState() => _AdicionarProdutoListaState();
}

class _AdicionarProdutoListaState extends State<AdicionarProdutoLista> {
  final List<Produto> listaProdutos = []; // Lista para armazenar os produtos
  final TextEditingController _nomeProdutoController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  String _selectedUnidadeMedida =
      'Unidades'; // Inicialmente definido como 'Unidades'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.listaNome,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 4,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: Text('Ordenar por ordem alfabética'),
                value: 'OrdenarAlfabeticamente',
              ),
            ],
            onSelected: (value) {
              if (value == 'OrdenarAlfabeticamente') {
                _ordenarPorOrdemAlfabetica();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _exibirBottomSheetAdicionarProduto(context);
              },
              child: Text(
                'Adicionar Produto',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
            ),
            SizedBox(height: 20),
            Divider(height: 20, thickness: 2), // Adicionando uma divisória
            SizedBox(height: 20),
            // Lista de produtos confirmados
            ReorderableListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              onReorder: _onReorder,
              children: listaProdutos.map((produto) {
                return _buildProdutoItem(produto);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProdutoItem(Produto produto) {
    return ListTile(
      key: Key(produto.nome),
      leading: SizedBox(
        width: 48,
        child: IconButton(
          icon: Icon(
            produto.comprado
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: produto.comprado ? Colors.green : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              produto.comprado = !produto
                  .comprado; // Alternar o estado de comprado/não comprado
            });
            _sortProdutos(); // Ordenar os produtos após alterar o estado de um produto
          },
        ),
      ),
      title: Text(
        produto.nome,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(
        '${produto.quantidade} ${produto.unidadeMedida}',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  void _exibirBottomSheetAdicionarProduto(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nomeProdutoController,
                decoration: InputDecoration(
                  labelText: 'Nome do Produto',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _quantidadeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Quantidade',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      value: _selectedUnidadeMedida,
                      onChanged: (value) {
                        setState(() {
                          _selectedUnidadeMedida = value!;
                        });
                      },
                      items: ['Unidades', 'Litros', 'Kg', 'Gramas', 'Outro']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Unidade',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Adicionar o produto à lista
                  Produto novoProduto = Produto(
                    nome: _nomeProdutoController.text,
                    quantidade:
                        double.tryParse(_quantidadeController.text) ?? 0.0,
                    unidadeMedida:
                        _selectedUnidadeMedida, // Usar a unidade de medida selecionada
                  );
                  setState(() {
                    listaProdutos.add(novoProduto);
                    _sortProdutos(); // Ordenar os produtos após adicionar um novo produto
                  });
                  // Limpar os campos após adicionar o produto
                  _nomeProdutoController.clear();
                  _quantidadeController.clear();
                  // Fechar o BottomSheet
                  Navigator.pop(context);
                },
                child: Text(
                  'Adicionar Produto',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Produto item = listaProdutos.removeAt(oldIndex);
      listaProdutos.insert(newIndex, item);
    });
  }

  void _sortProdutos() {
    List<Produto> produtosNaoConfirmados =
        listaProdutos.where((produto) => !produto.comprado).toList();
    produtosNaoConfirmados.sort((a, b) {
      return a.nome.compareTo(b.nome);
    });
    List<Produto> produtosConfirmados =
        listaProdutos.where((produto) => produto.comprado).toList();
    setState(() {
      listaProdutos.clear();
      listaProdutos.addAll(produtosNaoConfirmados);
      listaProdutos.addAll(produtosConfirmados);
    });
  }

  void _ordenarPorOrdemAlfabetica() {
    List<Produto> produtosNaoConfirmados =
        listaProdutos.where((produto) => !produto.comprado).toList();
    produtosNaoConfirmados.sort((a, b) {
      return a.nome.compareTo(b.nome);
    });
    List<Produto> produtosConfirmados =
        listaProdutos.where((produto) => produto.comprado).toList();
    setState(() {
      listaProdutos.clear();
      listaProdutos.addAll(produtosNaoConfirmados);
      listaProdutos.addAll(produtosConfirmados);
    });
  }
}
