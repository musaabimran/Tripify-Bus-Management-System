import 'package:flutter/material.dart';
import 'package:tripify/pages/profilePage_Driver.dart';
import './../utilites/routes.dart';

class AdminMainPage extends StatefulWidget {
  final List colorUsed;
  final List fontsUsed;
  const AdminMainPage(this.colorUsed, this.fontsUsed);

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Color(widget.colorUsed[0]),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: Image.asset(
                  "assets/images/tripifyOnly_Light.png",
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  color: Color(widget.colorUsed[2]),
                  height: 200,
                  width: 180,
                  child: Column(
                    children: [
                      Icon(
                        Icons.view_comfortable,
                        size: 150,
                        color: Color(widget.colorUsed[4]),
                      ),
                      TextCustomized(widget.colorUsed, "View Student", 18),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.viewStudents);
                },
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  color: Color(widget.colorUsed[2]),
                  height: 200,
                  width: 180,
                  child: Column(
                    children: [
                      Icon(
                        Icons.view_comfortable,
                        size: 150,
                        color: Color(widget.colorUsed[4]),
                      ),
                      TextCustomized(widget.colorUsed, "View Drivers", 18),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.viewDrivers);
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  color: Color(widget.colorUsed[2]),
                  height: 200,
                  width: 180,
                  child: Column(
                    children: [
                      Icon(
                        Icons.view_comfortable,
                        size: 150,
                        color: Color(widget.colorUsed[4]),
                      ),
                      TextCustomized(widget.colorUsed, "View Finance", 18),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.viewFinance);
                },
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  color: Color(widget.colorUsed[2]),
                  height: 200,
                  width: 180,
                  child: Column(
                    children: [
                      Icon(
                        Icons.view_comfortable,
                        size: 150,
                        color: Color(widget.colorUsed[4]),
                      ),
                      TextCustomized(widget.colorUsed, "View Buses", 18),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.viewBuses);
                },
              )
            ],
          ),
          Container(
            color: Color(widget.colorUsed[0]),
            height: 80,
          ),
        ],
      ),
    );
  }
}
