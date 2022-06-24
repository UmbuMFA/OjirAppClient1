import 'package:flutter/material.dart';

<<<<<<< HEAD
class ProgressDialog extends StatelessWidget {
  String? message;

  ProgressDialog({this.message});

  @override
  Widget build(BuildContext context) {
=======

class ProgressDialog extends StatelessWidget 
{
  String message;
  ProgressDialog({this.message});

  @override
  Widget build(BuildContext context) 
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    return Dialog(
      backgroundColor: Colors.black54,
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
<<<<<<< HEAD
              SizedBox(
                width: 6.0,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              SizedBox(
                width: 26.0,
              ),
              Text(
                message!,
=======
              SizedBox(width: 6.0,),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
              SizedBox(width: 26.0,),
              Text(
                message,
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
                style: TextStyle(color: Colors.black, fontSize: 10.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
