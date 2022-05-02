import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tcc_flutter/accelerometro_view/acelerometro_view.dart';
import 'package:tcc_flutter/giroscopio_view/giroscopio_view.dart';
import 'package:tcc_flutter/listagem_view/listagem_view.dart';
import 'package:tcc_flutter/localizacao_view/localizacao_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tcc_Flutter'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListagemView(),
                  ),
                );
              },
              child: Container(
                height: 48,
                color: Colors.blue,
                width: 160,
                child: const Center(
                  child: Text(
                    'LISTAGEM',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocalizacaoView(),
                    ));
              },
              child: Container(
                height: 48,
                color: Colors.blue,
                width: 160,
                child: const Center(
                  child: Text(
                    'LOCALIZAÇÃO',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AcelerometroView(),
                    ));
              },
              child: Container(
                height: 48,
                color: Colors.blue,
                width: 160,
                child: const Center(
                  child: Text(
                    'ACELEROMETRO',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GiroscopioView(),
                    ));
              },
              child: Container(
                height: 48,
                color: Colors.blue,
                width: 160,
                child: const Center(
                  child: Text(
                    'GIROSCÓPIO',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
