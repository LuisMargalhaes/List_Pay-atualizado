import 'package:flutter/material.dart';
import 'package:list_pay/pages/product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Product> _productsList = [
    Product(name: 'Macarrão', price: 1.99),
    Product(name: 'Arroz', price: 2.50),
  ];

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  List<Product> _filteredProductsList = [];

  @override
  void initState() {
    super.initState();
    _filteredProductsList = _productsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Pay'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _filteredProductsList = _productsList
                      .where((product) => product.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProductsList.length,
              itemBuilder: (context, index) {
                final product = _filteredProductsList[index];

                return ListTile(
                  title: Text(product.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('\$${product.price}'),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editProduct(product);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _confirmDeleteProduct(product);
                        },
                      ),
                    ],
                  ),
                  leading: Checkbox(
                    value: product.isBought,
                    onChanged: (value) =>
                        setState(() => product.isBought = value!),
                  ),
                );
              },
            ),
          ),
          _buildInputSection(),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Nome'),
        ),
        TextField(
          controller: _priceController,
          decoration: InputDecoration(labelText: 'Preço'),
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty &&
                _priceController.text.isNotEmpty) {
              setState(() {
                _productsList.add(
                  Product(
                    name: _nameController.text,
                    price: double.parse(_priceController.text),
                  ),
                );
                _filteredProductsList = _productsList;
              });

              _nameController.clear();
              _priceController.clear();
            }
          },
          child: Text('Adicionar Produto'),
        ),
      ],
    );
  }

  void _editProduct(Product product) {
    _nameController.text = product.name;
    _priceController.text = product.price.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Produto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product name'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Product price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  product.name = _nameController.text;
                  product.price = double.parse(_priceController.text);
                });
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteProduct(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar exclusão?'),
          content: Text('Você tem certeza que deseja excluir ${product.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar exclusão'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _productsList.remove(product);
                  _filteredProductsList.remove(product);
                });
                Navigator.pop(context);
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
