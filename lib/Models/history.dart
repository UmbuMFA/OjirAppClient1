import 'package:firebase_database/firebase_database.dart';

<<<<<<< HEAD
class History {
  String? paymentMethod;
  String? createdAt;
  String? status;
  String? fares;
  String? dropOff;
  String? pickup;

  History(
      {this.paymentMethod,
      this.createdAt,
      this.status,
      this.fares,
      this.dropOff,
      this.pickup});

  History.fromSnapshot(DataSnapshot snapshot) {
    paymentMethod = snapshot.child("payment_method").value.toString();
    createdAt = snapshot.child("created_at").value.toString();
    status = snapshot.child("status").value.toString();
    fares = snapshot.child("fares").value.toString();
    dropOff = snapshot.child("dropoff_address").value.toString();
    pickup = snapshot.child("pickup_address").value.toString();
  }
}
=======
class History
{
  String paymentMethod;
  String createdAt;
  String status;
  String fares;
  String dropOff;
  String pickup;

  History({this.paymentMethod, this.createdAt, this.status, this.fares, this.dropOff, this.pickup});

  History.fromSnapshot(DataSnapshot snapshot)
  {
    paymentMethod = snapshot.value["payment_method"];
    createdAt = snapshot.value["created_at"];
    status = snapshot.value["status"];
    fares = snapshot.value["fares"];
    dropOff = snapshot.value["dropoff_address"];
    pickup = snapshot.value["pickup_address"];
  }
}
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
