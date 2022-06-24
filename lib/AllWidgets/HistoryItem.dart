import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:rider_app/Assistants/assistantMethods.dart';
import 'package:rider_app/Models/history.dart';

class HistoryItem extends StatelessWidget {
  final History? history;

  HistoryItem({this.history});

  @override
  Widget build(BuildContext context) {
=======
import 'package:ojir_clientapp/Assistants/assistantMethods.dart';
import 'package:ojir_clientapp/Models/history.dart';


class HistoryItem extends StatelessWidget
{
  final History history;
  HistoryItem({this.history});

  @override
  Widget build(BuildContext context)
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
<<<<<<< HEAD
              Container(
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'images/pickicon.png',
                      height: 16,
                      width: 16,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                        child: Container(
                            child: Text(
                      history!.pickup!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18),
                    ))),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '\$${history!.fares!}',
                      style: TextStyle(
                          fontFamily: 'Brand Bold',
                          fontSize: 16,
                          color: Colors.black87),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image.asset(
                    'images/desticon.png',
                    height: 16,
                    width: 16,
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Text(
                    history!.dropOff!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                AssistantMethods.formatTripDate(history!.createdAt!),
                style: TextStyle(color: Colors.grey),
              ),
=======

              Container(
                child: Row(
                  children: <Widget>[

                    Image.asset('images/pickicon.png', height: 16, width: 16,),
                    SizedBox(width: 18,),
                    Expanded(child: Container(child: Text(history.pickup, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18),))),
                    SizedBox(width: 5,),

                    Text('\$${history.fares}', style: TextStyle(fontFamily: 'Brand Bold', fontSize: 16, color: Colors.black87),),
                  ],
                ),
              ),

              SizedBox(height: 8,),

              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image.asset('images/desticon.png', height: 16, width: 16,),
                  SizedBox(width: 18,),

                  Text(history.dropOff, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18),),
                ],
              ),

              SizedBox(height: 15,),

              Text(AssistantMethods.formatTripDate(history.createdAt), style: TextStyle(color: Colors.grey),),
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
            ],
          ),
        ],
      ),
    );
  }
}
