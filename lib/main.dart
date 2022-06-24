import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:provider/provider.dart';
import 'package:rider_app/AllScreens/loginScreen.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/AllScreens/registerationScreen.dart';
import 'package:rider_app/DataHandler/appData.dart';

void main() async {
=======
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ojir_clientapp/AllScreens/loginScreen.dart';
import 'package:ojir_clientapp/AllScreens/mainscreen.dart';
import 'package:ojir_clientapp/AllScreens/registerationScreen.dart';
import 'package:ojir_clientapp/DataHandler/appData.dart';

void main() async
{
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

<<<<<<< HEAD
DatabaseReference usersRef = FirebaseDatabase.instance.ref("users");
DatabaseReference driversRef = FirebaseDatabase.instance.ref("drivers");
DatabaseReference rideRequestRef =
    FirebaseDatabase.instance.ref("Ride Requests");
=======
DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");
DatabaseReference driversRef = FirebaseDatabase.instance.reference().child("drivers");
DatabaseReference rideRequestRef = FirebaseDatabase.instance.reference().child("Ride Requests");
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
<<<<<<< HEAD
        title: "Gojek Sampah",
=======
        title: 'Taxi Rider App',
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
<<<<<<< HEAD
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? LoginScreen.idScreen
            : MainScreen.idScreen,
        routes: {
=======
        initialRoute: FirebaseAuth.instance.currentUser == null ? LoginScreen.idScreen : MainScreen.idScreen,
        routes:
        {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
          RegisterationScreen.idScreen: (context) => RegisterationScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
          MainScreen.idScreen: (context) => MainScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
<<<<<<< HEAD
=======

>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
