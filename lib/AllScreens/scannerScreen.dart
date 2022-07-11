import 'dart:convert';

import 'package:dart_eval/dart_eval.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:rider_app/AllScreens/registerationScreen.dart';
import 'package:rider_app/configMaps.dart';
import 'package:rider_app/main.dart';
import 'package:http/http.dart' as http;

class ScannerScreen extends StatefulWidget {
  static const String idScreen = "about";

  @override
  _MyScannerScreenState createState() => _MyScannerScreenState();
}

class _MyScannerScreenState extends State<ScannerScreen> {
  String msg = 'Tekan Start';
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

    List<String> splitted = barcodeScanRes.split("_");
    bobot = splitted[2];

    DataSnapshot snapshotDriverName =
        await driversRef.child(splitted[0]).child("name").get();
    DataSnapshot snapshotUserPoin =
        await usersRef.child(userCurrentInfo.id!).child("poin").get();

    setState(() {
      msg = "Driver Dikenali";
      driverName = "Driver : ${snapshotDriverName.value}";
      bobot = "${splitted[2]} kg";
      poin = "Menghitung poin ...";

      updatePoin(
          splitted[2], snapshotUserPoin, splitted[0], driverName, splitted[1]);
    });
  }

  void updatePoin(
      berat, snapshotUserPoin, driverID, driverName, banksampah) async {
    http.Response response = await http.post(
      Uri.parse('https://ojir.my.id/api/get_point/member'),
      body: {
        'banksampah_id': banksampah,
        'jenis_sampah': _komposisi.toString(),
        'berat': berat,
      },
    );

    try {
      double i = double.parse(jsonDecode(response.body)['result'].toString());

      Map<String, Object> poinData = {
        "poin": double.parse(snapshotUserPoin.value.toString()) + i,
      };
      usersRef.child(userCurrentInfo.id!).update(poinData);

      DatabaseReference userOrderRef =
          usersRef.child(userCurrentInfo.id!).child("order").push();
      DatabaseReference driverOrderRef =
          driversRef.child(driverID).child("order").push();
      Map<String, dynamic> orderMap = {
        "id1": userOrderRef.key,
        "id2": driversRef.key,
        "date": DateTime.now().toString(),
        "berat": berat,
        "driver": driverName,
        "client": userCurrentInfo.name,
        "komposisi": _komposisi.toString(),
      };
      userOrderRef.set(orderMap);
      driverOrderRef.set(orderMap);

      setState(() {
        poin = "Dapat poin : $i";
      });
    } catch (exp) {
      displayToastMessage(exp.toString(), context);
    }
  }

  String? _komposisi = "keras";

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  RadioListTile<String>(
                    title: const Text('Keras'),
                    value: "keras",
                    groupValue: _komposisi,
                    onChanged: (String? value) {
                      setState(() {
                        _komposisi = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Lunak'),
                    value: "lunak",
                    groupValue: _komposisi,
                    onChanged: (String? value) {
                      setState(() {
                        _komposisi = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () => scanQR(), child: const Text('Start QR scan')),
            const SizedBox(
              height: 100,
            ),
            Text('$msg', style: const TextStyle(fontSize: 20)),
            Text('$driverName', style: const TextStyle(fontSize: 20)),
            Text('$bobot', style: const TextStyle(fontSize: 20)),
            Text('$poin', style: const TextStyle(fontSize: 20)),
          ])),
    );
  }
}
