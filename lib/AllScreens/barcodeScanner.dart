import 'package:flutter/material.dart';
// import 'package:owaste_client/AllScreens/mainscreen.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScreen extends StatefulWidget
{
  static const String idScreen = "barcode";

  @override
  _MyBarcodeScreenState createState() => _MyBarcodeScreenState();
}

class _MyBarcodeScreenState extends State<BarcodeScreen> {
  String code="";
  String getCode="";

  Future scanbarcode()async{
    getCode= await FlutterBarcodeScanner.scanBarcode("#009922", "Cancel", true);
    setState(() {
      code=getCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(
              height: 220,
              child: Center(
                // child: Image.asset('images/uberx.png'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 24, right: 24),
              child: Column(
                children: <Widget>[
                  Text(
                    'Scanner Fitur',
                    style: TextStyle(
                        fontSize: 90, fontFamily: 'Signatra'),
                  ),
                  SizedBox(height: 30),
                  // Text(
                  //     'This app has been developed by Umbu Michael and Ade Maria Ulfa, '
                  //         'and that\'s why 10M+ people already use this app',
                  //   style: TextStyle(fontFamily: "Brand-Bold"),
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              ),
            ),

            SizedBox(height: 40),
            FlatButton(
                onPressed: () {
                  scanbarcode();
                },
                child: const Text(
                    'Scanner',
                    style: TextStyle(
                        fontSize: 18, color: Colors.black
                    )
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0))
            ),
          ],
        ));
  }
}