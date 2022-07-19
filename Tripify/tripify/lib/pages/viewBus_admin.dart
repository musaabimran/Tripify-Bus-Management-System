import 'package:flutter/material.dart';

// the buses
List _allBuses = [
  {"name": "k-3899", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "k-3899", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "k-3899", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "k-3899", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "k-3899", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "p-2000", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "p-2000", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
];

class ViewBuses extends StatefulWidget {
  final List colorUsed;
  final List fontsUsed;
  const ViewBuses(this.colorUsed, this.fontsUsed);

  @override
  State<ViewBuses> createState() => _ViewBusesState();
}

class _ViewBusesState extends State<ViewBuses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextCustomized(widget.colorUsed, "Buses You have", 28),
              const SizedBox(
                height: 20,
              ),
              Table(
                border: TableBorder.all(
                  color: Color(widget.colorUsed[4]),
                  width: 2,
                ),

                // the responsive columns for the table
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                },

                // allign the table
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,

                // the table data -- rows
                children: [
                  // table row
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(widget.colorUsed[2]),
                    ),
                    children: [
                      TextCustomized(widget.colorUsed, "Bus     Number", 20),
                      TextCustomized(widget.colorUsed, "Driver  Name", 20),
                      TextCustomized(widget.colorUsed, "Service Status", 20),
                    ],
                  ),

                  // the table data -- rows
                  for (var i = 0; i < _allBuses.length; i++)
                    TableRow(
                      children: [
                        TextCustomized(widget.colorUsed, _allBuses[i]['name'],
                            18), //the boarding number
                        TextCustomized(widget.colorUsed,
                            _allBuses[i]['driver name'], 18), //the name
                        //the driver name
                        TextCustomized(widget.colorUsed,
                            _allBuses[i]['service status'], 18),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// for the text for the profile
class TextCustomized extends StatelessWidget {
  final List colorUsed;
  final String text;
  final double size;

  const TextCustomized(this.colorUsed, this.text, this.size, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 1, right: 1),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          color: Color(colorUsed[0]),
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
