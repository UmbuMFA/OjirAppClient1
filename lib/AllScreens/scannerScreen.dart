import 'package:dart_eval/dart_eval.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:rider_app/configMaps.dart';
import 'package:rider_app/main.dart';

class ScannerScreen extends StatefulWidget {
  static const String idScreen = "about";

  @override
  _MyScannerScreenState createState() => _MyScannerScreenState();
}

class _MyScannerScreenState extends State<ScannerScreen> {
  String driverID = '';
  String driverName = '';
  String bobot = '';
  String poin = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff1bac4b', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() async {
      List<String> splitted = barcodeScanRes.split("_");
      driverID = splitted[0];
      bobot = splitted[1];

      DataSnapshot snapshotDriverName =
          await driversRef.child(driverID).child("name").get();
      DataSnapshot snapshotUserPoin =
          await usersRef.child(userCurrentInfo.id!).child("poin").get();

      setState(() {
        driverID = splitted[0];
        driverName = "Driver : ${snapshotDriverName.value}";
        bobot = "${splitted[1]} kg";

        double i = double.parse(splitted[1]) / 1000;
        poin = "Dapat poin : $i";

        Map<String, Object> poinData = {
          "poin": double.parse(snapshotUserPoin.value.toString()) + i,
        };
        usersRef.child(userCurrentInfo.id!).update(poinData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: Container(
          alignment: Alignment.topCenter,
          child: Flex(direction: Axis.vertical, children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () => scanQR(), child: const Text('Start QR scan')),
            const SizedBox(
              height: 100,
            ),
            Text('$driverID', style: const TextStyle(fontSize: 20)),
            Text('$driverName', style: const TextStyle(fontSize: 20)),
            Text('$bobot', style: const TextStyle(fontSize: 20)),
            Text('$poin', style: const TextStyle(fontSize: 20)),
          ])),
    );
  }
}
