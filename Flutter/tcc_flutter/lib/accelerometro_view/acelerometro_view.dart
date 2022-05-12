import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AcelerometroView extends StatefulWidget {
  const AcelerometroView({Key? key}) : super(key: key);

  @override
  State<AcelerometroView> createState() => _AcelerometroViewState();
}

class _AcelerometroViewState extends State<AcelerometroView> {
  DateTime? _before;
  DateTime? _after;
  bool first = false;
  UserAccelerometerEvent? acceleration;
  StreamSubscription<UserAccelerometerEvent>? _streamSubscription;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_streamSubscription != null) _streamSubscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acelerometro'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'tempo decorrido: ${_after == null ? '' : _after!.difference(_before!).inMilliseconds} ms'),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                if (!first) _before = DateTime.now();
                print('teste');
                _streamSubscription = userAccelerometerEvents
                    .listen((UserAccelerometerEvent event) {
                  setState(() {
                    if (!first) {
                      acceleration = event;
                      print('teste1');
                      if (event.x != 0.0 || event.y != 0.0 || event.z != 0.0) {
                        _after = DateTime.now();
                      }
                      first = true;
                    }
                  });
                });
              },
              child: Container(
                height: 48,
                color: Colors.blue,
                width: 200,
                child: const Center(
                  child: Text(
                    'BUSCAR ACELEROMETRO',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
                'x: ${acceleration == null ? '' : acceleration!.x}, y: ${acceleration == null ? '' : acceleration!.y} z: ${acceleration == null ? '' : acceleration!.z}')
          ],
        ),
      ),
    );
  }
}
