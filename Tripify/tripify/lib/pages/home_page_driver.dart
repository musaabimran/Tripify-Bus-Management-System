import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tripify/pages/helpPage_driver.dart';
import 'package:tripify/pages/profilePage_Driver.dart';
import '../utilites/routes.dart';
import './salaryDetails_Driver.dart';
import "./studentInfo_driver.dart";
import 'home_page.dart';

class HomePageDriver extends StatefulWidget {
  final List colorUsed;
  final List fontsUsed;

  HomePageDriver(this.colorUsed, this.fontsUsed);

  @override
  State<HomePageDriver> createState() => _HomePageDriverState();
}

class _HomePageDriverState extends State<HomePageDriver>
    with SingleTickerProviderStateMixin {
  int index = MyRoutes.index; // the index specified initallay
  // setting the state and updating the value
  updateIndex(int val) async {
    setState(() {
      index = val;
    });
  }

  // for the explicit animation
  // the controller
  late AnimationController _controller;

  // overriding a method
  void initState() {
    _controller = AnimationController(
      vsync: this, //animation controller need this
      duration: const Duration(seconds: 3), //the duration
    );
    _controller.repeat(); //for forever effect
    super.initState();
  }

  @override
  void dispose() {
    //disposing to avoid the memory leaks
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //to remove the by default back icon
        title: Column(children: [
          //for giving the height
          const SizedBox(
            height: 5,
          ),
          AnimatedBuilder(
            animation: _controller.view,
            builder: (context, child) {
              // will translate the image
              return Transform.translate(
                offset: Offset(400 * _controller.value - 80, 2.0), //the ofset
                child: child, // use the child the logo image
              );
            },
            child: Image.asset(
              "assets/images/busOnly.png",
              fit: BoxFit.contain,
              width: 100,
              height: 100,
            ),
          ),
          //for giving the height
          const SizedBox(
            height: 10,
          ),
        ]),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          index == 4
              ? MyProfileDriver(widget.colorUsed, widget.fontsUsed)
              : index == 3
                  ? HelpPageDriver(
                      widget.colorUsed, widget.fontsUsed) //help page
                  : index == 2
                      ? SalaryDetails(
                          widget.colorUsed, widget.fontsUsed) //the fee details
                      : index == 1
                          ? BusStudentsInfo(widget.colorUsed,
                              widget.fontsUsed) //the fee details
                          : HomePage(widget.colorUsed,
                              widget.fontsUsed) // the home page
          // some more containers to hold things
        ],
      )),

      // the bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        // value to the currentindex is current tab and initallay 0 --- home
        currentIndex: index,
        onTap:
            updateIndex, //by taping the index will also updated and new selected will be seen
        // fixedColor: Colors.white,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(widget.colorUsed[3]),
        iconSize: 30,

        // the styling
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),

        // background color
        backgroundColor: Color(widget.colorUsed[4]),

        // items using
        items: const [
          // adding the items
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_search_sharp),
            label: "Students",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.wallet_membership),
            label: "Salaray",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: "Help",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
