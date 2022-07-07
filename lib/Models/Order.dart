import 'package:firebase_database/firebase_database.dart';

class Order {
  String? paymentMethod;
  String? createdAt;
  String? status;
  String? fares;
  String? dropOff;
  String? pickup;

  Order(
      {this.paymentMethod,
        this.createdAt,
        this.status,
        this.fares,
        this.dropOff,
        this.pickup});

  Order.fromSnapshot(DataSnapshot snapshot) {
    paymentMethod = snapshot.child("payment_method").value.toString();
    createdAt = snapshot.child("created_at").value.toString();
    status = snapshot.child("status").value.toString();
    fares = snapshot.child("fares").value.toString();
    dropOff = snapshot.child("dropoff_address").value.toString();
    pickup = snapshot.child("pickup_address").value.toString();
  }
}
