import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
<<<<<<< HEAD
import 'package:flutter/foundation.dart';
=======
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
<<<<<<< HEAD
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
=======
import 'package:ojir_clientapp/AllScreens/barcodeScanner.dart';
import 'package:provider/provider.dart';
import 'package:ojir_clientapp/AllScreens/HistoryScreen.dart';
import 'package:ojir_clientapp/AllScreens/aboutScreen.dart';
import 'package:ojir_clientapp/AllScreens/loginScreen.dart';
import 'package:ojir_clientapp/AllScreens/profileTabPage.dart';
import 'package:ojir_clientapp/AllScreens/ratingScreen.dart';
import 'package:ojir_clientapp/AllScreens/registerationScreen.dart';
import 'package:ojir_clientapp/AllScreens/searchScreen.dart';
import 'package:ojir_clientapp/AllWidgets/CollectFareDialog.dart';
import 'package:ojir_clientapp/AllWidgets/Divider.dart';
import 'package:ojir_clientapp/AllWidgets/noDriverAvailableDialog.dart';
import 'package:ojir_clientapp/AllWidgets/progressDialog.dart';
import 'package:ojir_clientapp/Assistants/assistantMethods.dart';
import 'package:ojir_clientapp/Assistants/geoFireAssistant.dart';
import 'package:ojir_clientapp/DataHandler/appData.dart';
import 'package:ojir_clientapp/Models/directDetails.dart';
import 'package:ojir_clientapp/Models/history.dart';
import 'package:ojir_clientapp/Models/nearbyAvailableDrivers.dart';
import 'package:ojir_clientapp/configMaps.dart';
import 'package:ojir_clientapp/main.dart';
import 'package:url_launcher/url_launcher.dart';



class MainScreen extends StatefulWidget
{
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
  static const String idScreen = "mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

<<<<<<< HEAD
enum KomposisiSampah { keras, lunak }

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DirectionDetails? tripDirectionDetails;
=======



class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin
{
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DirectionDetails tripDirectionDetails;
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

<<<<<<< HEAD
  late Position currentPosition;
=======
  Position currentPosition;
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
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

<<<<<<< HEAD
  late DatabaseReference rideRequestRef;

  BitmapDescriptor? nearByIcon = null;

  late List<NearbyAvailableDrivers> availableDrivers;

  String state = "normal";

  late StreamSubscription<DatabaseEvent> rideStreamSubscription;

  bool isRequestingPositionDetails = false;

  String uName = "";
  String photo = "";
=======
  DatabaseReference rideRequestRef;

  BitmapDescriptor nearByIcon;

  List<NearbyAvailableDrivers> availableDrivers;

  String state = "normal";

  StreamSubscription<Event> rideStreamSubscription;

  bool isRequestingPositionDetails = false;

  String uName="";

>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AssistantMethods.getCurrentOnlineUserInfo();
  }

<<<<<<< HEAD
  void saveRideRequest() {
    rideRequestRef = FirebaseDatabase.instance.ref("Ride Requests").push();
=======
  void saveRideRequest()
  {
    rideRequestRef = FirebaseDatabase.instance.reference().child("Ride Requests").push();
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff

    var pickUp = Provider.of<AppData>(context, listen: false).pickUpLocation;
    var dropOff = Provider.of<AppData>(context, listen: false).dropOffLocation;

<<<<<<< HEAD
    Map pickUpLocMap = {
      "latitude": pickUp!.latitude.toString(),
      "longitude": pickUp.longitude.toString(),
    };

    Map dropOffLocMap = {
      "latitude": dropOff!.latitude.toString(),
      "longitude": dropOff.longitude.toString(),
    };

    Map rideInfoMap = {
=======
    Map pickUpLocMap =
    {
      "latitude": pickUp.latitude.toString(),
      "longitude": pickUp.longitude.toString(),
    };

    Map dropOffLocMap =
    {
      "latitude": dropOff.latitude.toString(),
      "longitude": dropOff.longitude.toString(),
    };

    Map rideInfoMap =
    {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
      "driver_id": "waiting",
      "payment_method": "cash",
      "pickup": pickUpLocMap,
      "dropoff": dropOffLocMap,
      "created_at": DateTime.now().toString(),
      "rider_name": userCurrentInfo.name,
      "rider_phone": userCurrentInfo.phone,
      "pickup_address": pickUp.placeName,
      "dropoff_address": dropOff.placeName,
      "ride_type": carRideType,
    };

    rideRequestRef.set(rideInfoMap);

    rideStreamSubscription = rideRequestRef.onValue.listen((event) async {
<<<<<<< HEAD
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
            .toString()
            .toString());
        double driverLng = double.parse(event.snapshot
            .child("driver_location")
            .child("longitude")
            .value
            .toString()
            .toString());
        LatLng driverCurrentLocation = LatLng(driverLat, driverLng);

        if (statusRide == "accepted") {
          updateRideTimeToPickUpLoc(driverCurrentLocation);
        } else if (statusRide == "onride") {
          updateRideTimeToDropOffLoc(driverCurrentLocation);
        } else if (statusRide == "arrived") {
=======
      if(event.snapshot.value == null)
      {
        return;
      }

      if(event.snapshot.value["car_details"] != null)
      {
        setState(() {
          carDetailsDriver = event.snapshot.value["car_details"].toString();
        });
      }
      if(event.snapshot.value["driver_name"] != null)
      {
        setState(() {
          driverName = event.snapshot.value["driver_name"].toString();
        });
      }
      if(event.snapshot.value["driver_phone"] != null)
      {
        setState(() {
          driverphone = event.snapshot.value["driver_phone"].toString();
        });
      }

      if(event.snapshot.value["driver_location"] != null)
      {
        double driverLat = double.parse(event.snapshot.value["driver_location"]["latitude"].toString());
        double driverLng = double.parse(event.snapshot.value["driver_location"]["longitude"].toString());
        LatLng driverCurrentLocation = LatLng(driverLat, driverLng);

        if(statusRide == "accepted")
        {
          updateRideTimeToPickUpLoc(driverCurrentLocation);
        }
        else if(statusRide == "onride")
        {
          updateRideTimeToDropOffLoc(driverCurrentLocation);
        }
        else if(statusRide == "arrived")
        {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
          setState(() {
            rideStatus = "Driver has Arrived.";
          });
        }
      }

<<<<<<< HEAD
      if (event.snapshot.child("status").value.toString() != null) {
        statusRide = event.snapshot.child("status").value.toString().toString();
      }
      if (statusRide == "accepted") {
=======
      if(event.snapshot.value["status"] != null)
      {
        statusRide = event.snapshot.value["status"].toString();
      }
      if(statusRide == "accepted")
      {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
        displayDriverDetailsContainer();
        Geofire.stopListener();
        deleteGeofileMarkers();
      }
<<<<<<< HEAD
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

          String driverId = "";
          if (res == "close") {
            if (event.snapshot.child("driver_id").value.toString() != null) {
              driverId =
                  event.snapshot.child("driver_id").value.toString().toString();
            }

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RatingScreen(driverId: driverId)));

            rideRequestRef.onDisconnect();
            rideRequestRef = null!;
            rideStreamSubscription.cancel();
            rideStreamSubscription = null!;
=======
      if(statusRide == "ended")
      {
        if(event.snapshot.value["fares"] != null)
        {
          int fare = int.parse(event.snapshot.value["fares"].toString());
          var res = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context)=> CollectFareDialog(paymentMethod: "cash", fareAmount: fare,),
          );

          String driverId="";
          if(res == "close")
          {
            if(event.snapshot.value["driver_id"] != null)
            {
              driverId = event.snapshot.value["driver_id"].toString();
            }

            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RatingScreen(driverId: driverId)));

            rideRequestRef.onDisconnect();
            rideRequestRef = null;
            rideStreamSubscription.cancel();
            rideStreamSubscription = null;
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
            resetApp();
          }
        }
      }
    });
  }
<<<<<<< HEAD

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
=======
  
  void deleteGeofileMarkers()
  {
    setState(() {
      markersSet.removeWhere((element) => element.markerId.value.contains("driver"));
    });
  }

  void updateRideTimeToPickUpLoc(LatLng driverCurrentLocation) async
  {
    if(isRequestingPositionDetails == false)
    {
      isRequestingPositionDetails = true;

      var positionUserLatLng = LatLng(currentPosition.latitude, currentPosition.longitude);
      var details = await AssistantMethods.obtainPlaceDirectionDetails(driverCurrentLocation, positionUserLatLng);
      if(details == null)
      {
        return;
      }
      setState(() {
        rideStatus = "Driver is Coming - " + details.durationText;
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
      });

      isRequestingPositionDetails = false;
    }
  }

<<<<<<< HEAD
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
=======
  void updateRideTimeToDropOffLoc(LatLng driverCurrentLocation) async
  {
    if(isRequestingPositionDetails == false)
    {
      isRequestingPositionDetails = true;

      var dropOff = Provider.of<AppData>(context, listen: false).dropOffLocation;
      var dropOffUserLatLng = LatLng(dropOff.latitude, dropOff.longitude);

      var details = await AssistantMethods.obtainPlaceDirectionDetails(driverCurrentLocation, dropOffUserLatLng);
      if(details == null)
      {
        return;
      }
      setState(() {
        rideStatus = "Going to Destination - " + details.durationText;
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
      });

      isRequestingPositionDetails = false;
    }
  }

<<<<<<< HEAD
  void cancelRideRequest() {
=======
  void cancelRideRequest()
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    rideRequestRef.remove();
    setState(() {
      state = "normal";
    });
  }

<<<<<<< HEAD
  void displayRequestRideContainer() {
=======
  void displayRequestRideContainer()
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    setState(() {
      requestRideContainerHeight = 250.0;
      rideDetailsContainerHeight = 0;
      bottomPaddingOfMap = 230.0;
      drawerOpen = true;
    });

    saveRideRequest();
  }

<<<<<<< HEAD
  void displayDriverDetailsContainer() {
=======
  void displayDriverDetailsContainer()
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    setState(() {
      requestRideContainerHeight = 0.0;
      rideDetailsContainerHeight = 0.0;
      bottomPaddingOfMap = 295.0;
      driverDetailsContainerHeight = 285.0;
    });
  }

<<<<<<< HEAD
  resetApp() {
=======
  resetApp()
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
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

<<<<<<< HEAD
  void displayRideDetailsContainer() async {
=======
  void displayRideDetailsContainer() async
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    await getPlaceDirection();

    setState(() {
      searchContainerHeight = 0;
      rideDetailsContainerHeight = 340.0;
      bottomPaddingOfMap = 360.0;
      drawerOpen = false;
    });
  }

<<<<<<< HEAD
  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
=======
  void locatePosition() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

<<<<<<< HEAD
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
=======
    CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods.searchCoordinateAddress(position, context);
    print("This is your Address :: " + address);

    initGeoFireListner();

    uName = userCurrentInfo.name;
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff

    AssistantMethods.retrieveHistoryInfo(context);
  }

<<<<<<< HEAD
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-7.9467136, 112.6134797),
    zoom: 17,
  );

  String buttonText = "Buang Sampah";
  KomposisiSampah? _komposisi = KomposisiSampah.keras;

  String currentHelp = "";

=======
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
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
<<<<<<< HEAD
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
=======
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset("images/user_icon.png", height: 65.0, width: 65.0,),
                      SizedBox(width: 16.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(uName, style: TextStyle(fontSize: 16.0, fontFamily: "Brand Bold"),),
                          SizedBox(height: 6.0,),
                          GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileTabPage()));
                              },
                              child: Text("Visit Profile")
                          ),
                        ],
                      ),
                    ],
                  ),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                ),
              ),

              DividerWidget(),

<<<<<<< HEAD
              const SizedBox(
                height: 12.0,
              ),

              //Drawer Body Contrllers
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryScreen()));
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
=======
              SizedBox(height: 12.0,),

              //Drawer Body Contrllers
              GestureDetector(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HistoryScreen()));
                },
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text("History", style: TextStyle(fontSize: 15.0),),
                ),
              ),
              GestureDetector(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileTabPage()));
                },
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Visit Profile", style: TextStyle(fontSize: 15.0),),
                ),
              ),
              GestureDetector(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutScreen()));
                },
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About", style: TextStyle(fontSize: 15.0),),
                ),
              ),
              GestureDetector(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> BarcodeScreen()));
                },
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text("Barcode(Maintance)", style: TextStyle(fontSize: 15.0),),
                ),
              ),
              GestureDetector(
                onTap: ()
                {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Sign Out", style: TextStyle(fontSize: 15.0),),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
<<<<<<< HEAD
            padding: EdgeInsets.only(bottom: 200, top: 50.0, right: 6),
=======
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap, top: 25.0),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            polylines: polylineSet,
            markers: markersSet,
            circles: circlesSet,
<<<<<<< HEAD
            onMapCreated: (GoogleMapController controller) {
=======
            onMapCreated: (GoogleMapController controller)
            {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 300.0;
              });

              locatePosition();
            },
          ),
<<<<<<< HEAD
          //HamburgerButton for Drawer
          Positioned(
            top: 60.0,
            left: 25.0,
            child: GestureDetector(
              onTap: () {
                if (drawerOpen) {
                  scaffoldKey.currentState!.openDrawer();
                } else {
=======

          //HamburgerButton for Drawer
          Positioned(
            top: 36.0,
            left: 22.0,
            child: GestureDetector(
              onTap: ()
              {
                if(drawerOpen)
                {
                  scaffoldKey.currentState?.openDrawer();
                }
                else
                {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                  resetApp();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
<<<<<<< HEAD
                  boxShadow: const [
=======
                  boxShadow: [
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
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
<<<<<<< HEAD
                  radius: 20.0,
                  child: Icon(
                    (drawerOpen) ? Icons.menu : Icons.close,
                    color: Colors.black,
                  ),
=======
                  child: Icon((drawerOpen) ? Icons.menu : Icons.close, color: Colors.black,),
                  radius: 20.0,
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                ),
              ),
            ),
          ),

          //Search Ui
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: AnimatedSize(
<<<<<<< HEAD
              curve: Curves.bounceIn,
              duration: const Duration(milliseconds: 160),
              child: Container(
                height: searchContainerHeight,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0)),
=======
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                height: searchContainerHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
<<<<<<< HEAD
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6.0),
                      const Text(
                        "Hi there,",
                        style: TextStyle(fontSize: 12.0),
                      ),
                      const Text(
                        "Where to?",
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: "Brand Bold"),
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () async {
                          var res = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchScreen()));

                          if (res == "obtainDirection") {
=======
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6.0),
                      Text("Hi there,", style: TextStyle(fontSize: 12.0),),
                      Text("Where to?", style: TextStyle(fontSize: 20.0, fontFamily: "Brand Bold"),),
                      SizedBox(height: 20.0),

                      GestureDetector(
                        onTap: () async
                        {
                          var res = await Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));

                          if(res == "obtainDirection")
                          {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                            displayRideDetailsContainer();
                          }
                        },
                        child: Container(
<<<<<<< HEAD
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.search,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text("Search Drop Off"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.home,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
=======
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 6.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.7, 0.7),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Icon(Icons.search, color: Colors.blueAccent,),
                                  SizedBox(width: 10.0,),
                                  Text("Search Bank Sampah"),
                                ],
                              ),
                            ),
                          ),
                      ),

                      SizedBox(height: 24.0),
                      Row(
                        children: [
                          Icon(Icons.home, color: Colors.grey,),
                          SizedBox(width: 12.0,),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
<<<<<<< HEAD
                                Provider.of<AppData>(context).pickUpLocation !=
                                        null
                                    ? (Provider.of<AppData>(context)
                                        .pickUpLocation!
                                        .placeName!
                                        .toString())
                                    : "Add Home",
                                maxLines: 2,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Text(
                                "Your living home address",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12.0),
                              ),
=======
                                Provider.of<AppData>(context).pickUpLocation != null
                                    ? Provider.of<AppData>(context).pickUpLocation.placeName
                                    : "Add Home",
                              ),
                              SizedBox(height: 4.0,),
                              Text("Your living home address", style: TextStyle(color: Colors.black54, fontSize: 12.0),),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                            ],
                          ),
                        ],
                      ),
<<<<<<< HEAD
                      const SizedBox(height: 10.0),
                      DividerWidget(),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.work,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Add Work"),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "Your office address",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12.0),
                              ),
=======

                      SizedBox(height: 10.0),

                      DividerWidget(),

                      SizedBox(height: 16.0),

                      Row(
                        children: [
                          Icon(Icons.work, color: Colors.grey,),
                          SizedBox(width: 12.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add Work"),
                              SizedBox(height: 4.0,),
                              Text("Your office address", style: TextStyle(color: Colors.black54, fontSize: 12.0),),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

<<<<<<< HEAD
          Positioned(
              left: 0,
              right: 0,
              bottom: 10.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: <Widget>[
                          RadioListTile<KomposisiSampah>(
                            title: const Text('Keras'),
                            value: KomposisiSampah.keras,
                            groupValue: _komposisi,
                            onChanged: (KomposisiSampah? value) {
                              setState(() {
                                _komposisi = value;
                              });
                            },
                          ),
                          RadioListTile<KomposisiSampah>(
                            title: const Text('Lunak'),
                            value: KomposisiSampah.lunak,
                            groupValue: _komposisi,
                            onChanged: (KomposisiSampah? value) {
                              setState(() {
                                _komposisi = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
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
                            DatabaseReference newHelp =
                                FirebaseDatabase.instance.ref("help").push();
                            Map<String, Object> map = {
                              'id': newHelp.key.toString(),
                              'user': userCurrentInfo.id!,
                              'komposisi': _komposisi!.index.toString(),
                              'latitude': currentPosition.latitude,
                              'longitude': currentPosition.longitude,
                            };
                            newHelp.set(map);
                            currentHelp = newHelp.key.toString();
                          } else {
                            buttonText = "Buang Sampah";
                            FirebaseDatabase.instance
                                .ref("help")
                                .child(currentHelp)
                                .remove();
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

=======
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
          //Ride Details Ui
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedSize(
<<<<<<< HEAD
              curve: Curves.bounceIn,
              duration: const Duration(milliseconds: 160),
              child: Container(
                height: rideDetailsContainerHeight,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
=======
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                height: rideDetailsContainerHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
<<<<<<< HEAD
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17.0),
                  child: Column(
                    children: [
                      //bike ride
                      GestureDetector(
                        onTap: () {
=======

                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17.0),
                  child: Column(
                    children: [

                      //bike ride
                      GestureDetector(
                        onTap: ()
                        {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                          displayToastMessage("searching Bike...", context);

                          setState(() {
                            state = "requesting";
                            carRideType = "bike";
                          });
                          displayRequestRideContainer();
<<<<<<< HEAD
                          availableDrivers =
                              GeoFireAssistant.nearByAvailableDriversList;
=======
                          availableDrivers = GeoFireAssistant.nearByAvailableDriversList;
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                          searchNearestDriver();
                        },
                        child: Container(
                          width: double.infinity,
                          child: Padding(
<<<<<<< HEAD
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "images/bike.png",
                                  height: 70.0,
                                  width: 80.0,
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Bike",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "Brand Bold",
                                      ),
                                    ),
                                    Text(
                                      ((tripDirectionDetails != null)
                                          ? tripDirectionDetails!.distanceText!
                                          : ''),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
=======
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                // Image.asset("images/bike.png", height: 70.0, width: 80.0,),
                                SizedBox(width: 16.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bike", style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold",),
                                    ),
                                    Text(
                                      ((tripDirectionDetails != null) ? tripDirectionDetails.distanceText : '') , style: TextStyle(fontSize: 16.0, color: Colors.grey,),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                Text(
<<<<<<< HEAD
                                  ((tripDirectionDetails != null)
                                      ? '\$${(AssistantMethods.calculateFares(tripDirectionDetails!)) / 2}'
                                      : ''),
                                  style: const TextStyle(
                                    fontFamily: "Brand Bold",
                                  ),
=======
                                  ((tripDirectionDetails != null) ? '\$${(AssistantMethods.calculateFares(tripDirectionDetails))/2}' : ''), style: TextStyle(fontFamily: "Brand Bold",),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

<<<<<<< HEAD
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Divider(
                        height: 2.0,
                        thickness: 2.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),

                      //uber-go ride
                      GestureDetector(
                        onTap: () {
=======
                      SizedBox(height: 10.0,),
                      Divider(height: 2.0, thickness: 2.0,),
                      SizedBox(height: 10.0,),

                      //uber-go ride
                      GestureDetector(
                        onTap: ()
                        {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                          displayToastMessage("searching Uber-Go...", context);

                          setState(() {
                            state = "requesting";
                            carRideType = "uber-go";
                          });
                          displayRequestRideContainer();
<<<<<<< HEAD
                          availableDrivers =
                              GeoFireAssistant.nearByAvailableDriversList;
=======
                          availableDrivers = GeoFireAssistant.nearByAvailableDriversList;
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                          searchNearestDriver();
                        },
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
<<<<<<< HEAD
                                Image.asset(
                                  "images/ubergo.png",
                                  height: 70.0,
                                  width: 80.0,
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Uber-Go",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "Brand Bold",
                                      ),
                                    ),
                                    Text(
                                      ((tripDirectionDetails != null)
                                          ? tripDirectionDetails!.distanceText!
                                          : ''),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
=======
                                // Image.asset("", height: 70.0, width: 80.0,),
                                SizedBox(width: 16.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Motorcycle", style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold",),
                                    ),
                                    Text(
                                      ((tripDirectionDetails != null) ? tripDirectionDetails.distanceText : '') , style: TextStyle(fontSize: 16.0, color: Colors.grey,),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                Text(
<<<<<<< HEAD
                                  ((tripDirectionDetails != null)
                                      ? '\$${AssistantMethods.calculateFares(tripDirectionDetails!)}'
                                      : ''),
                                  style: const TextStyle(
                                    fontFamily: "Brand Bold",
                                  ),
=======
                                  ((tripDirectionDetails != null) ? '\$${AssistantMethods.calculateFares(tripDirectionDetails)}' : ''), style: TextStyle(fontFamily: "Brand Bold",),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

<<<<<<< HEAD
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Divider(
                        height: 2.0,
                        thickness: 2.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),

                      //uber-x ride
                      GestureDetector(
                        onTap: () {
=======
                      SizedBox(height: 10.0,),
                      Divider(height: 2.0, thickness: 2.0,),
                      SizedBox(height: 10.0,),

                      //uber-x ride
                      GestureDetector(
                        onTap: ()
                        {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                          displayToastMessage("searching Uber-X...", context);

                          setState(() {
                            state = "requesting";
                            carRideType = "uber-x";
                          });
                          displayRequestRideContainer();
<<<<<<< HEAD
                          availableDrivers =
                              GeoFireAssistant.nearByAvailableDriversList;
=======
                          availableDrivers = GeoFireAssistant.nearByAvailableDriversList;
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                          searchNearestDriver();
                        },
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
<<<<<<< HEAD
                                Image.asset(
                                  "images/uberx.png",
                                  height: 70.0,
                                  width: 80.0,
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Uber-X",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "Brand Bold",
                                      ),
                                    ),
                                    Text(
                                      ((tripDirectionDetails != null)
                                          ? tripDirectionDetails!.distanceText!
                                          : ''),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
=======
                                // Image.asset("images/uberx.png", height: 70.0, width: 80.0,),
                                SizedBox(width: 16.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tossa", style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold",),
                                    ),
                                    Text(
                                      ((tripDirectionDetails != null) ? tripDirectionDetails.distanceText : '') , style: TextStyle(fontSize: 16.0, color: Colors.grey,),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                Text(
<<<<<<< HEAD
                                  ((tripDirectionDetails != null)
                                      ? '\$${(AssistantMethods.calculateFares(tripDirectionDetails!)) * 2}'
                                      : ''),
                                  style: const TextStyle(
                                    fontFamily: "Brand Bold",
                                  ),
=======
                                  ((tripDirectionDetails != null) ? '\$${(AssistantMethods.calculateFares(tripDirectionDetails))*2}' : ''), style: TextStyle(fontFamily: "Brand Bold",),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

<<<<<<< HEAD
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Divider(
                        height: 2.0,
                        thickness: 2.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: const [
                            Icon(
                              FontAwesomeIcons.moneyCheckAlt,
                              size: 18.0,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Text("Cash"),
                            SizedBox(
                              width: 6.0,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black54,
                              size: 16.0,
                            ),
=======
                      SizedBox(height: 10.0,),
                      Divider(height: 2.0, thickness: 2.0,),
                      SizedBox(height: 10.0,),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.moneyCheckAlt, size: 18.0, color: Colors.black54,),
                            SizedBox(width: 16.0,),
                            Text("Cash"),
                            SizedBox(width: 6.0,),
                            Icon(Icons.keyboard_arrow_down, color: Colors.black54, size: 16.0,),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //Cancel Ui
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
<<<<<<< HEAD
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
=======
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
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
              height: requestRideContainerHeight,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
<<<<<<< HEAD
                    const SizedBox(
                      height: 12.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ColorizeAnimatedTextKit(
                        onTap: () {
                          print("Tap Event");
                        },
                        text: const [
                          "Requesting a Ride...",
                          "Please wait...",
                          "Finding a Driver...",
                        ],
                        textStyle:
                            TextStyle(fontSize: 55.0, fontFamily: "Signatra"),
                        colors: const [
                          Colors.green,
                          Colors.purple,
                          Colors.pink,
                          Colors.blue,
                          Colors.yellow,
                          Colors.red,
                        ],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 22.0,
                    ),
                    GestureDetector(
                      onTap: () {
=======
                    SizedBox(height: 12.0,),

                    SizedBox(
                        width: double.infinity,
                        child: ColorizeAnimatedTextKit(
                          onTap: () {
                            print("Tap Event");
                          },
                          text: [
                            "Requesting a Ride...",
                            "Please wait...",
                            "Finding a Driver...",
                          ],
                          textStyle: TextStyle(
                            fontSize: 55.0,
                            fontFamily: "Signatra"
                          ),
                          colors: [
                            Colors.green,
                            Colors.purple,
                            Colors.pink,
                            Colors.blue,
                            Colors.yellow,
                            Colors.red,
                          ],
                          textAlign: TextAlign.center,
                          alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                        ),
                      ),

                    SizedBox(height: 22.0,),

                    GestureDetector(
                      onTap: ()
                      {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                        cancelRideRequest();
                        resetApp();
                      },
                      child: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26.0),
<<<<<<< HEAD
                          border: Border.all(
                              width: 2.0, color: Colors.grey.shade300),
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 26.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: const Text(
                        "Cancel Ride",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.0),
                      ),
=======
                          border: Border.all(width: 2.0, color: Colors.grey),
                        ),
                        child: Icon(Icons.close, size: 26.0,),
                      ),
                    ),

                    SizedBox(height: 10.0,),

                    Container(
                      width: double.infinity,
                      child: Text("Cancel Ride", textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0),),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                    ),
                  ],
                ),
              ),
            ),
          ),

          //Display Assisned Driver Info
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
<<<<<<< HEAD
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
=======
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
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
<<<<<<< HEAD
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
=======
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.0,),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(rideStatus, textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontFamily: "Brand Bold"),),
                      ],
                    ),

                    SizedBox(height: 22.0,),

                    Divider(height: 2.0, thickness: 2.0,),

                    SizedBox(height: 22.0,),

                    Text(carDetailsDriver, style: TextStyle(color: Colors.grey),),

                    Text(driverName, style: TextStyle(fontSize: 20.0),),

                    SizedBox(height: 22.0,),

                    Divider(height: 2.0, thickness: 2.0,),

                    SizedBox(height: 22.0,),

>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //call button
                        Padding(
<<<<<<< HEAD
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
=======
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(24.0),
                            ),
                            onPressed: () async
                            {
                              launch(('tel://${driverphone}'));
                            },
                            color: Colors.black87,
                            child: Padding(
                              padding: EdgeInsets.all(17.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Call Driver   ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
                                  Icon(Icons.call, color: Colors.white, size: 26.0,),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
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

<<<<<<< HEAD
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
=======
  Future<void> getPlaceDirection() async
  {
    var initialPos = Provider.of<AppData>(context, listen: false).pickUpLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(message: "Please wait...",)
    );

    var details = await AssistantMethods.obtainPlaceDirectionDetails(pickUpLatLng, dropOffLatLng);
    setState(() {
      tripDirectionDetails = details;
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    });

    Navigator.pop(context);

    print("This is Encoded Points ::");
<<<<<<< HEAD
    print(details!.encodedPoints!);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(details.encodedPoints!);

    pLineCoordinates.clear();

    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
=======
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult = polylinePoints.decodePolyline(details.encodedPoints);

    pLineCoordinates.clear();

    if(decodedPolyLinePointsResult.isNotEmpty)
    {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
      });
    }

    polylineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: Colors.pink,
<<<<<<< HEAD
        polylineId: const PolylineId("PolylineID"),
=======
        polylineId: PolylineId("PolylineID"),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
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
<<<<<<< HEAD
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
=======
    if(pickUpLatLng.latitude > dropOffLatLng.latitude  &&  pickUpLatLng.longitude > dropOffLatLng.longitude)
    {
      latLngBounds = LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    }
    else if(pickUpLatLng.longitude > dropOffLatLng.longitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude), northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    }
    else if(pickUpLatLng.latitude > dropOffLatLng.latitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude), northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    }
    else
    {
      latLngBounds = LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }

    newGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      infoWindow: InfoWindow(title: initialPos.placeName, snippet: "my Location"),
      position: pickUpLatLng,
      markerId: MarkerId("pickUpId"),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    );

    Marker dropOffLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
<<<<<<< HEAD
      infoWindow:
          InfoWindow(title: finalPos.placeName, snippet: "DropOff Location"),
      position: dropOffLatLng,
      markerId: const MarkerId("dropOffId"),
=======
      infoWindow: InfoWindow(title: finalPos.placeName, snippet: "DropOff Location"),
      position: dropOffLatLng,
      markerId: MarkerId("dropOffId"),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
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

<<<<<<< HEAD
  void initGeoFireListner() {
    Geofire.initialize("availableDrivers");
    //comment
    Geofire.queryAtLocation(
            currentPosition.latitude, currentPosition.longitude, 15)!
        .listen((map) {
=======
  void initGeoFireListner()
  {
    Geofire.initialize("availableDrivers");
    //comment
    Geofire.queryAtLocation(currentPosition.latitude, currentPosition.longitude, 15).listen((map) {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
      print(map);
      if (map != null) {
        var callBack = map['callBack'];

        switch (callBack) {
          case Geofire.onKeyEntered:
<<<<<<< HEAD
            NearbyAvailableDrivers nearbyAvailableDrivers =
                NearbyAvailableDrivers();
            nearbyAvailableDrivers.key = map['key'];
            nearbyAvailableDrivers.latitude = map['latitude'];
            nearbyAvailableDrivers.longitude = map['longitude'];
            GeoFireAssistant.nearByAvailableDriversList
                .add(nearbyAvailableDrivers);
            if (nearbyAvailableDriverKeysLoaded == true) {
=======
            NearbyAvailableDrivers nearbyAvailableDrivers = NearbyAvailableDrivers();
            nearbyAvailableDrivers.key = map['key'];
            nearbyAvailableDrivers.latitude = map['latitude'];
            nearbyAvailableDrivers.longitude = map['longitude'];
            GeoFireAssistant.nearByAvailableDriversList.add(nearbyAvailableDrivers);
            if(nearbyAvailableDriverKeysLoaded == true)
            {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
              updateAvailableDriversOnMap();
            }
            break;

          case Geofire.onKeyExited:
            GeoFireAssistant.removeDriverFromList(map['key']);
            updateAvailableDriversOnMap();
            break;

          case Geofire.onKeyMoved:
<<<<<<< HEAD
            NearbyAvailableDrivers nearbyAvailableDrivers =
                NearbyAvailableDrivers();
=======
            NearbyAvailableDrivers nearbyAvailableDrivers = NearbyAvailableDrivers();
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
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

<<<<<<< HEAD
  void updateAvailableDriversOnMap() {
=======
  void updateAvailableDriversOnMap()
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    setState(() {
      markersSet.clear();
    });

    Set<Marker> tMakers = Set<Marker>();
<<<<<<< HEAD
    for (NearbyAvailableDrivers driver
        in GeoFireAssistant.nearByAvailableDriversList) {
      LatLng driverAvaiablePosition =
          LatLng(driver.latitude!, driver.longitude!);
=======
    for(NearbyAvailableDrivers driver in GeoFireAssistant.nearByAvailableDriversList)
    {
      LatLng driverAvaiablePosition = LatLng(driver.latitude, driver.longitude);
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff

      Marker marker = Marker(
        markerId: MarkerId('driver${driver.key}'),
        position: driverAvaiablePosition,
<<<<<<< HEAD
        icon: nearByIcon!,
=======
        icon: nearByIcon,
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
        //rotation: AssistantMethods.createRandomNumber(360),
      );

      tMakers.add(marker);
    }
    setState(() {
      markersSet = tMakers;
    });
  }

<<<<<<< HEAD
  void createIconMarker() {
    if (nearByIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size(2, 2));
      BitmapDescriptor.fromAssetImage(imageConfiguration, "images/car_ios.png")
          .then((value) {
=======
  void createIconMarker()
  {
    if(nearByIcon == null)
    {
      ImageConfiguration imageConfiguration = createLocalImageConfiguration(context, size: Size(2, 2));
      BitmapDescriptor.fromAssetImage(imageConfiguration, "images/car_ios.png")
          .then((value)
      {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
        nearByIcon = value;
      });
    }
  }

<<<<<<< HEAD
  void noDriverFound() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => NoDriverAvailableDialog());
  }

  void searchNearestDriver() {
    if (availableDrivers.isEmpty) {
=======
  void noDriverFound()
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => NoDriverAvailableDialog()
    );
  }

  void searchNearestDriver()
  {
    if(availableDrivers.length == 0)
    {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
      cancelRideRequest();
      resetApp();
      noDriverFound();
      return;
    }

    var driver = availableDrivers[0];
<<<<<<< HEAD

    driversRef
        .child(driver.key!)
        .child("car_details")
        .child("type")
        .once()
        .then((event) async {
      if (event.snapshot.value != null) {
        String carType = event.snapshot.value.toString();
        if (carType == carRideType) {
          notifyDriver(driver);
          availableDrivers.removeAt(0);
        } else {
          displayToastMessage(
              "$carRideType drivers not available. Try again.", context);
        }
      } else {
=======
    
    driversRef.child(driver.key).child("car_details").child("type").once().then((DataSnapshot snap) async
    {
      if(await snap.value != null)
      {
        String carType = snap.value.toString();
        if(carType == carRideType)
        {
          notifyDriver(driver);
          availableDrivers.removeAt(0);
        }
        else
        {
          displayToastMessage(carRideType + " drivers not available. Try again.", context);
        }
      }
      else
      {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
        displayToastMessage("No car found. Try again.", context);
      }
    });
  }

<<<<<<< HEAD
  void notifyDriver(NearbyAvailableDrivers driver) {
    driversRef.child(driver.key!).child("newRide").set(rideRequestRef.key);

    driversRef.child(driver.key!).child("token").once().then((event) {
      if (event.snapshot.value != null) {
        String token = event.snapshot.value.toString();
        AssistantMethods.sendNotificationToDriver(
            token, context, rideRequestRef.key!);
      } else {
=======
  void notifyDriver(NearbyAvailableDrivers driver)
  {
    driversRef.child(driver.key).child("newRide").set(rideRequestRef.key);

    driversRef.child(driver.key).child("token").once().then((DataSnapshot snap){
      if(snap.value != null)
      {
        String token = snap.value.toString();
        AssistantMethods.sendNotificationToDriver(token, context, rideRequestRef.key);
      }
      else
      {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
        return;
      }

      const oneSecondPassed = Duration(seconds: 1);
      var timer = Timer.periodic(oneSecondPassed, (timer) {
<<<<<<< HEAD
        if (state != "requesting") {
          driversRef.child(driver.key!).child("newRide").set("cancelled");
          driversRef.child(driver.key!).child("newRide").onDisconnect();
=======
        if(state != "requesting")
        {
          driversRef.child(driver.key).child("newRide").set("cancelled");
          driversRef.child(driver.key).child("newRide").onDisconnect();
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
          driverRequestTimeOut = 40;
          timer.cancel();
        }

        driverRequestTimeOut = driverRequestTimeOut - 1;

<<<<<<< HEAD
        driversRef.child(driver.key!).child("newRide").onValue.listen((event) {
          if (event.snapshot.value.toString() == "accepted") {
            driversRef.child(driver.key!).child("newRide").onDisconnect();
=======
        driversRef.child(driver.key).child("newRide").onValue.listen((event) {
          if(event.snapshot.value.toString() == "accepted")
          {
            driversRef.child(driver.key).child("newRide").onDisconnect();
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
            driverRequestTimeOut = 40;
            timer.cancel();
          }
        });

<<<<<<< HEAD
        if (driverRequestTimeOut == 0) {
          driversRef.child(driver.key!).child("newRide").set("timeout");
          driversRef.child(driver.key!).child("newRide").onDisconnect();
=======
        if(driverRequestTimeOut == 0)
        {
          driversRef.child(driver.key).child("newRide").set("timeout");
          driversRef.child(driver.key).child("newRide").onDisconnect();
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
          driverRequestTimeOut = 40;
          timer.cancel();

          searchNearestDriver();
        }
      });
    });
  }
}
