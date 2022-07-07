import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/AllWidgets/HistoryItem.dart';
import 'package:rider_app/DataHandler/appData.dart';
import 'package:rider_app/Models/history.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String bulan = "Pilih Bulan";
  DateTime? selectedDate;
  List<History> items = [];
  List<History> filteredItems = [];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    items = Provider.of<AppData>(context, listen: false).tripHistoryDataList;
    filteredItems =
        Provider.of<AppData>(context, listen: false).tripHistoryDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip History'),
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                showMonthPicker(
                  context: context,
                  firstDate: DateTime(DateTime.now().year - 1, 5),
                  lastDate: DateTime(DateTime.now().year + 1, 9),
                  initialDate: selectedDate ?? DateTime.now(),
                  locale: const Locale("id"),
                ).then((date) {
                  if (date != null) {
                    List<History> tmp = [];
                    for (var element in items) {
                      int month1 = DateTime.parse(element.date!).month;
                      int year1 = DateTime.parse(element.date!).year;
                      int month2 = date.month;
                      int year2 = date.year;
                      if (month1 == month2 && year1 == year2) {
                        tmp.add(element);
                      }
                    }

                    setState(() {
                      selectedDate = date;
                      bulan = "${selectedDate!.month} / ${selectedDate!.year}";
                      filteredItems = tmp;
                    });
                  }
                });
              },
              child: Text(bulan)),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
                "Total ${filteredItems.isNotEmpty ? filteredItems.map((e) => int.parse(e.berat!)).reduce((a, b) => a + b) : 0} kg"),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.separated(
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return HistoryItem(
                history: filteredItems[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              thickness: 3.0,
              height: 3.0,
            ),
            itemCount: filteredItems.length,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }
}
