import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListagemView extends StatelessWidget {
  const ListagemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listagem'),
      ),
      body: FutureBuilder<List<dynamic>>(
          future: loadList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => Card(
                  child: Column(
                    children: [
                      Image.network(snapshot.data![index]["image_url"]),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        snapshot.data![index]["first_name"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          }),
    );
  }

  Future<List<dynamic>> loadList() async {
    final String response =
        await rootBundle.loadString('assets/list_json.json');
    final data = await json.decode(response);

    return data;
  }
}
