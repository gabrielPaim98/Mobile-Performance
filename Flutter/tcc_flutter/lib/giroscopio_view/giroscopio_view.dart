import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GiroscopioView extends StatefulWidget {
  const GiroscopioView({Key? key}) : super(key: key);

  @override
  State<GiroscopioView> createState() => _GiroscopioViewState();
}

class _GiroscopioViewState extends State<GiroscopioView> {
  DateTime? _before;
  DateTime? _after;
  GyroscopeEvent? _gyroscopeEvent;

  StreamSubscription<GyroscopeEvent>? _streamSubscription;

  bool first = false;
  @override
  void dispose() {
    super.dispose();
    if (_streamSubscription != null) _streamSubscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giroscopio'),
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
                _streamSubscription =
                    gyroscopeEvents.listen((GyroscopeEvent event) {
                  setState(() {
                    if (!first) {
                      _gyroscopeEvent = event;
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
                    'BUSCAR GIROSCOPIO',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
                'x: ${_gyroscopeEvent == null ? '' : _gyroscopeEvent!.x}, y: ${_gyroscopeEvent == null ? '' : _gyroscopeEvent!.y} z: ${_gyroscopeEvent == null ? '' : _gyroscopeEvent!.z}')
          ],
        ),
      ),
    );
  }
}
