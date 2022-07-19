import 'package:flutter/material.dart';
import 'package:tripify/pages/profilePage_Driver.dart';
import './../utilites/routes.dart';

class AdminManagementPage extends StatelessWidget {
  final List colorUsed;
  final List fontsUsed;
  const AdminManagementPage(this.colorUsed, this.fontsUsed);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Color(colorUsed[0]),
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
                  color: Color(colorUsed[2]),
                  height: 200,
                  width: 180,
                  child: Column(
                    children: [
                      Icon(
                        Icons.view_comfortable,
                        size: 150,
                        color: Color(colorUsed[4]),
                      ),
                      TextCustomized(colorUsed, "Manage Student", 18),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.manageStudents);
                },
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  color: Color(colorUsed[2]),
                  height: 200,
                  width: 180,
                  child: Column(
                    children: [
                      Icon(
                        Icons.view_comfortable,
                        size: 150,
                        color: Color(colorUsed[4]),
                      ),
                      TextCustomized(colorUsed, "Manage Drivers", 18),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.manageDrivers);
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
                  color: Color(colorUsed[2]),
                  height: 200,
                  width: 180,
                  child: Column(
                    children: [
                      Icon(
                        Icons.view_comfortable,
                        size: 150,
                        color: Color(colorUsed[4]),
                      ),
                      TextCustomized(colorUsed, "Manage Finance", 18),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.manageFinance);
                },
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  color: Color(colorUsed[2]),
                  height: 200,
                  width: 180,
                  child: Column(
                    children: [
                      Icon(
                        Icons.view_comfortable,
                        size: 150,
                        color: Color(colorUsed[4]),
                      ),
                      TextCustomized(colorUsed, "Manage Buses", 18),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.manageBus);
                },
              )
            ],
          ),
          Container(
            color: Color(colorUsed[0]),
            height: 80,
          ),
        ],
      ),
    );
  }
}
