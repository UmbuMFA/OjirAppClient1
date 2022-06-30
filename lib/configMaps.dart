import 'package:firebase_auth/firebase_auth.dart';
import 'package:rider_app/Models/allUsers.dart';

String mapKey = "AIzaSyC2QsXxtU_FWRn0qAUzTquUsjvkN8NB1kQ";

late User firebaseUser;

late Users userCurrentInfo;

int driverRequestTimeOut = 40;
String statusRide = "";
String rideStatus = "Driver is Coming";
String carDetailsDriver = "";
String driverName = "";
String driverphone = "";

double starCounter = 0.0;
String title = "";
String carRideType = "";

String serverToken =
    "key=AAAA_gkEd3o:APA91bEtJZ1SQVhqkCoh0vP4CwEhdMUN_wEmXIUvtjRBZ-Srr-6URmbE2GHRS8tgDaO1gcmvhvLmjiS2ALztu439ReH0-up_V1cpAwk-ruNffUBTWpCudiXwWdRqiVYABzc2BZUmE8Z5";
