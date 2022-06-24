import 'package:firebase_database/firebase_database.dart';
<<<<<<< HEAD

class Users {
  String? id;
  String? email;
  String? name;
  String? phone;
  String? photo;
  double? poin;

  Users({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.photo,
    this.poin,
  });

  Users.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key;
    email = dataSnapshot.child("email").value.toString();
    name = dataSnapshot.child("name").value.toString();
    phone = dataSnapshot.child("phone").value.toString();
    photo = dataSnapshot.child("photo").value.toString();
    poin = double.parse(dataSnapshot.child("poin").value.toString());
  }
}
=======
import 'package:flutter/material.dart';

class Users
{
  String id;
  String email;
  String name;
  String phone;

  Users({this.id, this.email, this.name, this.phone,});

  Users.fromSnapshot(DataSnapshot dataSnapshot)
  {
    id = dataSnapshot.key;
    email = dataSnapshot.value["email"];
    name = dataSnapshot.value["name"];
    phone = dataSnapshot.value["phone"];
  }
}
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
