import 'package:flutter/material.dart';

class ListagemView extends StatelessWidget {
  const ListagemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listagem'),
      ),
      body: ListView.builder(
        itemCount: 10000,
        itemBuilder: (context, index) => ListTile(
          title: Text('Lista $index'),
        ),
      ),
    );
  }
}
