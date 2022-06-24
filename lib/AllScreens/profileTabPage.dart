<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:rider_app/configMaps.dart';

class ProfileTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
=======

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:ojir_clientapp/configMaps.dart';

class ProfileTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
<<<<<<< HEAD
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                userCurrentInfo.photo!,
                height: 100.0,
                width: 100.0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              userCurrentInfo.name!,
              style: const TextStyle(
                fontSize: 65.0,
                color: Colors.white,
=======

            Text(
              userCurrentInfo.name,
              style: TextStyle(
                fontSize: 65.0,
                color: Colors.black,
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                fontWeight: FontWeight.bold,
                fontFamily: 'Signatra',
              ),
            ),
<<<<<<< HEAD
            const SizedBox(
              height: 20,
              width: 200,
=======

            SizedBox(
              height: 20,
              width: 2,
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
              child: Divider(
                color: Colors.white,
              ),
            ),
<<<<<<< HEAD
            const SizedBox(
              height: 40.0,
            ),
            InfoCard(
              text: userCurrentInfo.phone!,
=======

            SizedBox(height: 40.0,),

            InfoCard(
              text: userCurrentInfo.phone,
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
              icon: Icons.phone,
              onPressed: () async {
                print("this is phone.");
              },
            ),
<<<<<<< HEAD
            InfoCard(
              text: userCurrentInfo.email!,
=======

            InfoCard(
              text: userCurrentInfo.email,
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
              icon: Icons.email,
              onPressed: () async {
                print("this is email.");
              },
            ),
<<<<<<< HEAD
            InfoCard(
              text: "0",
              icon: Icons.circle,
              onPressed: () async {
                print("this is poin.");
              },
            ),
=======

>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
          ],
        ),
      ),
    );
  }
}

<<<<<<< HEAD
class InfoCard extends StatelessWidget {
  final String? text;
  final IconData? icon;
  Function? onPressed;

  InfoCard({
    this.text,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed,
=======
// ignore: must_be_immutable
class InfoCard extends StatelessWidget
{
  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard({this.text, this.icon, this.onPressed,});

  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: onPressed(),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.black87,
          ),
          title: Text(
<<<<<<< HEAD
            text!,
            style: const TextStyle(
=======
            text,
            style: TextStyle(
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
              color: Colors.black87,
              fontSize: 16.0,
              fontFamily: 'Brand Bold',
            ),
          ),
        ),
      ),
    );
  }
}
<<<<<<< HEAD
=======

>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
