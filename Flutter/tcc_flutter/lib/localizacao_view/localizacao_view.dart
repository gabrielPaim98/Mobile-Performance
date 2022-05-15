import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocalizacaoView extends StatefulWidget {
  const LocalizacaoView({Key? key}) : super(key: key);

  @override
  State<LocalizacaoView> createState() => _LocalizacaoViewState();
}

class _LocalizacaoViewState extends State<LocalizacaoView> {
  DateTime? _before;
  DateTime? _after;
  Position? _location;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _before = DateTime.now();
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localizacao'),
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
              onTap: () async {
                _location = await _determinePosition();
                setState(() {
                  _after = DateTime.now();
                });
              },
              child: Container(
                height: 48,
                color: Colors.blue,
                width: 200,
                child: const Center(
                  child: Text(
                    'BUSCAR LOCALIZAÇÃO',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
                'localizacao: ${_location == null ? '' : _location!.latitude}, ${_location == null ? '' : _location!.longitude}')
          ],
        ),
      ),
    );
  }
}
