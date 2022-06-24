import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:rider_app/configMaps.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingScreen extends StatefulWidget {
  final String? driverId;

  RatingScreen({this.driverId});
=======
import 'package:ojir_clientapp/configMaps.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class RatingScreen extends StatefulWidget
{
  final String driverId;

  RatingScreen({
     this.driverId});
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

<<<<<<< HEAD
=======

>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
class _RatingScreenState extends State<RatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          margin: EdgeInsets.all(5.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
<<<<<<< HEAD
              SizedBox(
                height: 22.0,
              ),
              Text(
                "Rate this Driver",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Brand Bold",
                    color: Colors.black54),
              ),
              SizedBox(
                height: 22.0,
              ),
              Divider(
                height: 2.0,
                thickness: 2.0,
              ),
              SizedBox(
                height: 16.0,
              ),
=======
              SizedBox(height: 22.0,),

              Text(
                "Rate this Driver",
                style: TextStyle(fontSize: 20.0, fontFamily: "Brand Bold", color: Colors.black54),
              ),

              SizedBox(height: 22.0,),

              Divider(height: 2.0, thickness: 2.0,),

              SizedBox(height: 16.0,),

>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
              SmoothStarRating(
                rating: starCounter,
                color: Colors.green,
                allowHalfRating: false,
                starCount: 5,
                size: 45,
<<<<<<< HEAD
                onRated: (value) {
                  starCounter = value;

                  if (starCounter == 1) {
=======
                onRated: (value)
                {
                  starCounter = value;

                  if(starCounter == 1)
                  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                    setState(() {
                      title = "Very Bad";
                    });
                  }
<<<<<<< HEAD
                  if (starCounter == 2) {
=======
                  if(starCounter == 2)
                  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                    setState(() {
                      title = "Bad";
                    });
                  }
<<<<<<< HEAD
                  if (starCounter == 3) {
=======
                  if(starCounter == 3)
                  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                    setState(() {
                      title = "Good";
                    });
                  }
<<<<<<< HEAD
                  if (starCounter == 4) {
=======
                  if(starCounter == 4)
                  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                    setState(() {
                      title = "Very Good";
                    });
                  }
<<<<<<< HEAD
                  if (starCounter == 5) {
=======
                  if(starCounter == 5)
                  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                    setState(() {
                      title = "Excellent";
                    });
                  }
                },
              ),
<<<<<<< HEAD
              SizedBox(
                height: 14.0,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 55.0,
                    fontFamily: "Signatra",
                    color: Colors.green),
              ),
              SizedBox(
                height: 16.0,
              ),
=======

              SizedBox(height: 14.0,),

              Text(title, style: TextStyle(fontSize: 55.0, fontFamily: "Signatra", color: Colors.green),),

              SizedBox(height: 16.0,),

>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(24.0),
                  ),
<<<<<<< HEAD
                  onPressed: () async {
                    DatabaseReference driverRatingRef = FirebaseDatabase
                        .instance
                        .reference()
                        .child("drivers")
                        .child(widget.driverId!)
                        .child("ratings");

                    driverRatingRef.once().then((event) {
                      if (event.snapshot.value != null) {
                        double oldRatings =
                            double.parse(event.snapshot.value.toString());
                        double addRatings = oldRatings + starCounter;
                        double averageRatings = addRatings / 2;
                        driverRatingRef.set(averageRatings.toString());
                      } else {
=======
                  onPressed: () async
                  {
                    DatabaseReference driverRatingRef = FirebaseDatabase.instance.reference()
                        .child("drivers")
                        .child(widget.driverId)
                        .child("ratings");

                    driverRatingRef.once().then((DataSnapshot snap) {
                      if(snap.value != null)
                      {
                        double oldRatings = double.parse(snap.value.toString());
                        double addRatings = oldRatings + starCounter;
                        double averageRatings = addRatings/2;
                        driverRatingRef.set(averageRatings.toString());
                      }
                      else
                      {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                        driverRatingRef.set(starCounter.toString());
                      }
                    });

                    Navigator.pop(context);
                  },
                  color: Colors.green,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
<<<<<<< HEAD
                        Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
=======
                        Text("Submit", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                      ],
                    ),
                  ),
                ),
              ),
<<<<<<< HEAD
              SizedBox(
                height: 30.0,
              ),
=======

              SizedBox(height: 30.0,),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
            ],
          ),
        ),
      ),
    );
  }
}
