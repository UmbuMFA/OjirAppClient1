import 'package:firebase_database/firebase_database.dart';

class Users {
  String? id;
  String? email;
  String? name;
  String? phone;
  String? photo;
  double? poin;
  String? bank_sampah;

  Users({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.photo,
    this.poin,
    this.bank_sampah,
  });

  Users.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key;
    email = dataSnapshot.child("email").value.toString();
    name = dataSnapshot.child("name").value.toString();
    phone = dataSnapshot.child("phone").value.toString();
    photo = dataSnapshot.child("photo").value.toString();
    poin = double.parse(dataSnapshot.child("poin").value.toString());
    bank_sampah = dataSnapshot.child("bank_sampah").value.toString();
  }
}
