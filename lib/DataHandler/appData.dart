import 'package:flutter/cupertino.dart';
<<<<<<< HEAD
import 'package:rider_app/Models/address.dart';
import 'package:rider_app/Models/history.dart';

class AppData extends ChangeNotifier {
  Address? pickUpLocation, dropOffLocation;
=======
import 'package:ojir_clientapp/Models/address.dart';
import 'package:ojir_clientapp/Models/history.dart';

class AppData extends ChangeNotifier
{
  Address pickUpLocation, dropOffLocation;
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff

  String earnings = "0";
  int countTrips = 0;
  List<String> tripHistoryKeys = [];
  List<History> tripHistoryDataList = [];

<<<<<<< HEAD
  void updatePickUpLocationAddress(Address pickUpAddress) {
=======

  void updatePickUpLocationAddress(Address pickUpAddress)
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }

<<<<<<< HEAD
  void updateDropOffLocationAddress(Address dropOffAddress) {
=======
  void updateDropOffLocationAddress(Address dropOffAddress)
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }

  //history
<<<<<<< HEAD
  void updateEarnings(String updatedEarnings) {
=======
  void updateEarnings(String updatedEarnings)
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    earnings = updatedEarnings;
    notifyListeners();
  }

<<<<<<< HEAD
  void updateTripsCounter(int tripCounter) {
=======
  void updateTripsCounter(int tripCounter)
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    countTrips = tripCounter;
    notifyListeners();
  }

<<<<<<< HEAD
  void updateTripKeys(List<String> newKeys) {
=======
  void updateTripKeys(List<String> newKeys)
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    tripHistoryKeys = newKeys;
    notifyListeners();
  }

<<<<<<< HEAD
  void updateTripHistoryData(History eachHistory) {
    tripHistoryDataList.add(eachHistory);
    notifyListeners();
  }
}
=======
  void updateTripHistoryData(History eachHistory)
  {
    tripHistoryDataList.add(eachHistory);
    notifyListeners();
  }
}
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
