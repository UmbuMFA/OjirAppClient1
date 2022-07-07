import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rider_app/Assistants/assistantMethods.dart';
import 'package:rider_app/Models/history.dart';

class HistoryItem extends StatelessWidget {
  final History? history;

  HistoryItem({this.history});

  static String formatTripDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate =
        "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'images/pickicon.png',
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Expanded(
                        child: Text(
                      history!.driver!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18),
                    )),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${history!.berat!} kg',
                      style: const TextStyle(
                          fontFamily: 'Brand Bold',
                          fontSize: 16,
                          color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                formatTripDate(history!.date!),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
