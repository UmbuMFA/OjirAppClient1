import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/AllScreens/historyScreen.dart';
import 'package:rider_app/AllScreens/scannerScreen.dart';
import 'package:rider_app/AllScreens/loginScreen.dart';
import 'package:rider_app/AllScreens/profileTabPage.dart';
import 'package:rider_app/AllScreens/ratingScreen.dart';
import 'package:rider_app/AllScreens/registerationScreen.dart';
import 'package:rider_app/AllScreens/searchScreen.dart';
import 'package:rider_app/AllWidgets/CollectFareDialog.dart';
import 'package:rider_app/AllWidgets/Divider.dart';
import 'package:rider_app/AllWidgets/noDriverAvailableDialog.dart';
import 'package:rider_app/AllWidgets/progressDialog.dart';
import 'package:rider_app/Assistants/assistantMethods.dart';
import 'package:rider_app/Assistants/geoFireAssistant.dart';
import 'package:rider_app/DataHandler/appData.dart';
import 'package:rider_app/Models/directDetails.dart';
import 'package:rider_app/Models/nearbyAvailableDrivers.dart';
import 'package:rider_app/configMaps.dart';
import 'package:rider_app/main.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DirectionDetails? tripDirectionDetails;

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  late Position currentPosition;

  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  double rideDetailsContainerHeight = 0;
  double requestRideContainerHeight = 0;
  double searchContainerHeight = 300.0;
  double driverDetailsContainerHeight = 0;

  bool drawerOpen = true;
  bool nearbyAvailableDriverKeysLoaded = false;

  late DatabaseReference rideRequestRef;

  BitmapDescriptor? nearByIcon = null;

  late List<NearbyAvailableDrivers> availableDrivers;

  String state = "normal";

  late StreamSubscription<DatabaseEvent> rideStreamSubscription;

  bool isRequestingPositionDetails = false;

  String uName = "";
  String photo = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    perm();

    AssistantMethods.getCurrentOnlineUserInfo();
  }

  void perm() async {
    if (await Permission.contacts.request().isGranted) {}

    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.camera,
      Permission.phone,
    ].request();
    print(statuses[Permission.location]);

    if (await Permission.location.request().isGranted) {
      AssistantMethods.getCurrentOnlineUserInfo();
    }
  }

  void saveRideRequest() {
    rideRequestRef = FirebaseDatabase.instance.ref("Ride Requests").push();

    var pickUp = Provider.of<AppData>(context, listen: false).pickUpLocation;
    var dropOff = Provider.of<AppData>(context, listen: false).dropOffLocation;

    Map pickUpLocMap = {
      "latitude": pickUp!.latitude.toString(),
      "longitude": pickUp.longitude.toString(),
    };

    // Map dropOffLocMap = {
    //   "latitude": dropOff!.latitude.toString(),
    //   "longitude": dropOff.longitude.toString(),
    // };

    Map rideInfoMap = {
      "driver_id": "waiting",
      "payment_method": "cash",
      "pickup": pickUpLocMap,
      "dropoff": pickUpLocMap,
      // "dropoff": dropOffLocMap,
      "created_at": DateTime.now().toString(),
      "rider_name": userCurrentInfo.name,
      "rider_phone": userCurrentInfo.phone,
      "pickup_address": pickUp.placeName,
      "dropoff_address": pickUp.placeName,
      // "dropoff_address": dropOff.placeName,
      "ride_type": carRideType,
    };

    rideRequestRef.set(rideInfoMap);

    rideStreamSubscription = rideRequestRef.onValue.listen((event) async {
      if (event.snapshot.value == null) {
        return;
      }

      if (event.snapshot.child("car_details").value.toString() != null) {
        setState(() {
          carDetailsDriver =
              event.snapshot.child("car_details").value.toString().toString();
        });
      }
      if (event.snapshot.child("driver_name").value.toString() != null) {
        setState(() {
          driverName =
              event.snapshot.child("driver_name").value.toString().toString();
        });
      }
      if (event.snapshot.child("driver_phone").value.toString() != null) {
        setState(() {
          driverphone =
              event.snapshot.child("driver_phone").value.toString().toString();
        });
      }

      if (event.snapshot.child("driver_location").value.toString() != null) {
        double driverLat = double.parse(event.snapshot
            .child("driver_location")
            .child("latitude")
            .value
            .toString());
        double driverLng = double.parse(event.snapshot
            .child("driver_location")
            .child("longitude")
            .value
            .toString());
        LatLng driverCurrentLocation = LatLng(driverLat, driverLng);

        if (statusRide == "accepted") {
          updateRideTimeToPickUpLoc(driverCurrentLocation);
        } else if (statusRide == "onride") {
          updateRideTimeToDropOffLoc(driverCurrentLocation);
        } else if (statusRide == "arrived") {
          setState(() {
            rideStatus = "Driver has Arrived.";
          });
        }
      }

      if (event.snapshot.child("status").value.toString() != null) {
        statusRide = event.snapshot.child("status").value.toString().toString();
      }
      if (statusRide == "accepted") {
        displayDriverDetailsContainer();
        Geofire.stopListener();
        deleteGeofileMarkers();
      }
      if (statusRide == "ended") {
        if (event.snapshot.child("fares").value.toString() != null) {
          int fare = int.parse(
              event.snapshot.child("fares").value.toString().toString());
          var res = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => CollectFareDialog(
              paymentMethod: "cash",
              fareAmount: fare,
            ),
          );

          rideRequestRef.onDisconnect();
        }
      }
    });
  }

  void deleteGeofileMarkers() {
    setState(() {
      markersSet
          .removeWhere((element) => element.markerId.value.contains("driver"));
    });
  }

  void updateRideTimeToPickUpLoc(LatLng driverCurrentLocation) async {
    if (isRequestingPositionDetails == false) {
      isRequestingPositionDetails = true;

      var positionUserLatLng =
          LatLng(currentPosition.latitude, currentPosition.longitude);
      var details = await AssistantMethods.obtainPlaceDirectionDetails(
          driverCurrentLocation, positionUserLatLng);
      if (details == null) {
        return;
      }
      setState(() {
        rideStatus = "Driver is Coming - ${details.durationText}";
      });

      isRequestingPositionDetails = false;
    }
  }

  void updateRideTimeToDropOffLoc(LatLng driverCurrentLocation) async {
    if (isRequestingPositionDetails == false) {
      isRequestingPositionDetails = true;

      var dropOff =
          Provider.of<AppData>(context, listen: false).dropOffLocation;
      var dropOffUserLatLng = LatLng(dropOff!.latitude!, dropOff.longitude!);

      var details = await AssistantMethods.obtainPlaceDirectionDetails(
          driverCurrentLocation, dropOffUserLatLng);
      if (details == null) {
        return;
      }
      setState(() {
        rideStatus = "Going to Destination - ${details.durationText}";
      });

      isRequestingPositionDetails = false;
    }
  }

  void cancelRideRequest() {
    rideRequestRef.remove();
    setState(() {
      state = "normal";
    });
  }

  void displayRequestRideContainer() {
    setState(() {
      requestRideContainerHeight = 250.0;
      rideDetailsContainerHeight = 0;
      bottomPaddingOfMap = 230.0;
      drawerOpen = true;
    });

    saveRideRequest();
  }

  void displayDriverDetailsContainer() {
    setState(() {
      requestRideContainerHeight = 0.0;
      rideDetailsContainerHeight = 0.0;
      bottomPaddingOfMap = 295.0;
      driverDetailsContainerHeight = 285.0;
    });
  }

  resetApp() {
    setState(() {
      drawerOpen = true;
      searchContainerHeight = 300.0;
      rideDetailsContainerHeight = 0;
      requestRideContainerHeight = 0;
      bottomPaddingOfMap = 230.0;

      polylineSet.clear();
      markersSet.clear();
      circlesSet.clear();
      pLineCoordinates.clear();

      statusRide = "";
      driverName = "";
      driverphone = "";
      carDetailsDriver = "";
      rideStatus = "Driver is Coming";
      driverDetailsContainerHeight = 0.0;
    });

    locatePosition();
  }

  void displayRideDetailsContainer() async {
    await getPlaceDirection();

    setState(() {
      searchContainerHeight = 0;
      rideDetailsContainerHeight = 340.0;
      bottomPaddingOfMap = 360.0;
      drawerOpen = false;
    });
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address =
        await AssistantMethods.searchCoordinateAddress(position, context);
    if (kDebugMode) {
      print("This is your Address :: $address");
    }

    initGeoFireListner();

    uName = userCurrentInfo.name!;
    photo = userCurrentInfo.photo!;

    AssistantMethods.retrieveHistoryInfo(context);
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-7.9467136, 112.6134797),
    zoom: 17,
  );

  String buttonText = "Buang Sampah";

  String currentHelp = "";

  @override
  Widget build(BuildContext context) {
    createIconMarker();
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              //Drawer Header
              DrawerHeader(
                decoration: const BoxDecoration(color: Color(0xFF1bac4b)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        photo,
                        height: 65.0,
                        width: 65.0,
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          uName,
                          style: const TextStyle(
                              fontSize: 16.0, fontFamily: "Brand Bold"),
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              DividerWidget(),

              const SizedBox(
                height: 12.0,
              ),

              //Drawer Body Contrllers
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HistoryScreen()));
                },
                child: const ListTile(
                  leading: Icon(Icons.history),
                  title: Text(
                    "History",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileTabPage()));
                },
                child: const ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    "Profile",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ScannerScreen()));
                },
                child: const ListTile(
                  leading: Icon(Icons.qr_code),
                  title: Text(
                    "QR Code",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.idScreen, (route) => false);
                },
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    "Sign Out",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: const EdgeInsets.only(bottom: 100, top: 50.0, right: 6),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            polylines: polylineSet,
            markers: markersSet,
            circles: circlesSet,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 100.0;
              });

              locatePosition();
            },
          ),
          //HamburgerButton for Drawer
          Positioned(
            top: 60.0,
            left: 25.0,
            child: GestureDetector(
              onTap: () {
                if (drawerOpen) {
                  scaffoldKey.currentState!.openDrawer();
                } else {
                  resetApp();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20.0,
                  child: Icon(
                    (drawerOpen) ? Icons.menu : Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
              left: 0,
              right: 0,
              bottom: 10.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          elevation: 0,
                          primary: const Color(0xFF1bac4b)),
                      onPressed: (() {
                        setState(() {
                          if (currentHelp == "") {
                            buttonText = "Mencari Kurir";
                            currentHelp = "baru";

                            setState(() {
                              state = "requesting";
                              carRideType = "bike";
                            });
                            displayRequestRideContainer();
                            availableDrivers =
                                GeoFireAssistant.nearByAvailableDriversList;
                            searchNearestDriver();
                          } else {
                            buttonText = "Buang Sampah";
                            currentHelp = "";
                          }
                        });
                      }),
                      child: SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(buttonText),
                        ),
                      ),
                    ),
                  )
                ],
              )),

          //Display Assisned Driver Info
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0.5,
                    blurRadius: 16.0,
                    color: Colors.black54,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              height: driverDetailsContainerHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 6.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          rideStatus,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20.0, fontFamily: "Brand Bold"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 22.0,
                    ),
                    const Divider(
                      height: 2.0,
                      thickness: 2.0,
                    ),
                    const SizedBox(
                      height: 22.0,
                    ),
                    Text(
                      carDetailsDriver,
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      driverName,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    const SizedBox(
                      height: 22.0,
                    ),
                    const Divider(
                      height: 2.0,
                      thickness: 2.0,
                    ),
                    const SizedBox(
                      height: 22.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //call button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            onPressed: () async {
                              launch(('tel://$driverphone'));
                            },
                            color: Colors.black87,
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text(
                                    "Call Driver   ",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.call,
                                    color: Colors.white,
                                    size: 26.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getPlaceDirection() async {
    var initialPos =
        Provider.of<AppData>(context, listen: false).pickUpLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLatLng = LatLng(initialPos!.latitude!, initialPos.longitude!);
    var dropOffLatLng = LatLng(finalPos!.latitude!, finalPos.longitude!);

    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: "Please wait...",
            ));

    var details = await AssistantMethods.obtainPlaceDirectionDetails(
        pickUpLatLng, dropOffLatLng);
    setState(() {
      tripDirectionDetails = details!;
    });

    Navigator.pop(context);

    print("This is Encoded Points ::");
    print(details!.encodedPoints!);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(details.encodedPoints!);

    pLineCoordinates.clear();

    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: Colors.pink,
        polylineId: const PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polylineSet.add(polyline);
    });

    LatLngBounds latLngBounds;
    if (pickUpLatLng.latitude > dropOffLatLng.latitude &&
        pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    } else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }

    newGoogleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      infoWindow:
          InfoWindow(title: initialPos.placeName, snippet: "my Location"),
      position: pickUpLatLng,
      markerId: const MarkerId("pickUpId"),
    );

    Marker dropOffLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow:
          InfoWindow(title: finalPos.placeName, snippet: "DropOff Location"),
      position: dropOffLatLng,
      markerId: const MarkerId("dropOffId"),
    );

    setState(() {
      markersSet.add(pickUpLocMarker);
      markersSet.add(dropOffLocMarker);
    });

    Circle pickUpLocCircle = Circle(
      fillColor: Colors.blueAccent,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("pickUpId"),
    );

    Circle dropOffLocCircle = Circle(
      fillColor: Colors.deepPurple,
      center: dropOffLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.deepPurple,
      circleId: CircleId("dropOffId"),
    );

    setState(() {
      circlesSet.add(pickUpLocCircle);
      circlesSet.add(dropOffLocCircle);
    });
  }

  void initGeoFireListner() {
    Geofire.initialize("availableDrivers");
    //comment
    Geofire.queryAtLocation(
            currentPosition.latitude, currentPosition.longitude, 15)!
        .listen((map) {
      print(map);
      if (map != null) {
        var callBack = map['callBack'];

        switch (callBack) {
          case Geofire.onKeyEntered:
            NearbyAvailableDrivers nearbyAvailableDrivers =
                NearbyAvailableDrivers();
            nearbyAvailableDrivers.key = map['key'];
            nearbyAvailableDrivers.latitude = map['latitude'];
            nearbyAvailableDrivers.longitude = map['longitude'];
            GeoFireAssistant.nearByAvailableDriversList
                .add(nearbyAvailableDrivers);
            if (nearbyAvailableDriverKeysLoaded == true) {
              updateAvailableDriversOnMap();
            }
            break;

          case Geofire.onKeyExited:
            GeoFireAssistant.removeDriverFromList(map['key']);
            updateAvailableDriversOnMap();
            break;

          case Geofire.onKeyMoved:
            NearbyAvailableDrivers nearbyAvailableDrivers =
                NearbyAvailableDrivers();
            nearbyAvailableDrivers.key = map['key'];
            nearbyAvailableDrivers.latitude = map['latitude'];
            nearbyAvailableDrivers.longitude = map['longitude'];
            GeoFireAssistant.updateDriverNearbyLocation(nearbyAvailableDrivers);
            updateAvailableDriversOnMap();
            break;

          case Geofire.onGeoQueryReady:
            updateAvailableDriversOnMap();
            break;
        }
      }

      setState(() {});
    });
    //comment
  }

  void updateAvailableDriversOnMap() {
    setState(() {
      markersSet.clear();
    });

    Set<Marker> tMakers = Set<Marker>();
    for (NearbyAvailableDrivers driver
        in GeoFireAssistant.nearByAvailableDriversList) {
      LatLng driverAvaiablePosition =
          LatLng(driver.latitude!, driver.longitude!);

      Marker marker = Marker(
        markerId: MarkerId('driver${driver.key}'),
        position: driverAvaiablePosition,
        icon: nearByIcon!,
        //rotation: AssistantMethods.createRandomNumber(360),
      );

      tMakers.add(marker);
    }
    setState(() {
      markersSet = tMakers;
    });
  }

  void createIconMarker() {
    if (nearByIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size(2, 2));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, "images/car_android.png")
          .then((value) {
        nearByIcon = value;
      });
    }
  }

  void noDriverFound() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => NoDriverAvailableDialog());
  }

  void searchNearestDriver() {
    if (availableDrivers.isEmpty) {
      cancelRideRequest();
      resetApp();
      noDriverFound();
      return;
    }

    var driver = availableDrivers[0];

    driversRef.child(driver.key!).once().then((event) async {
      if (event.snapshot.value != null) {
        notifyDriver(driver);
        availableDrivers.removeAt(0);
      } else {
        displayToastMessage("No driver found. Try again.", context);
      }
    });
  }

  void notifyDriver(NearbyAvailableDrivers driver) {
    driversRef.child(driver.key!).child("newRide").set(rideRequestRef.key);

    driversRef.child(driver.key!).child("token").once().then((event) {
      if (event.snapshot.value != null) {
        String token = event.snapshot.value.toString();
        AssistantMethods.sendNotificationToDriver(
            token, context, rideRequestRef.key!);
      } else {
        return;
      }

      const oneSecondPassed = Duration(seconds: 1);
      var timer = Timer.periodic(oneSecondPassed, (timer) {
        if (state != "requesting") {
          driversRef.child(driver.key!).child("newRide").set("cancelled");
          driversRef.child(driver.key!).child("newRide").onDisconnect();
          driverRequestTimeOut = 40;
          timer.cancel();
        }

        driverRequestTimeOut = driverRequestTimeOut - 1;

        driversRef.child(driver.key!).child("newRide").onValue.listen((event) {
          if (event.snapshot.value.toString() == "accepted") {
            driversRef.child(driver.key!).child("newRide").onDisconnect();
            driverRequestTimeOut = 40;
            timer.cancel();
          }
        });

        if (driverRequestTimeOut == 0) {
          driversRef.child(driver.key!).child("newRide").set("timeout");
          driversRef.child(driver.key!).child("newRide").onDisconnect();
          driverRequestTimeOut = 40;
          timer.cancel();

          searchNearestDriver();
        }
      });
    });
  }
}
