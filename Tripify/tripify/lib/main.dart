import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tripify/pages/mainHomeAdmin_page.dart';
import 'package:tripify/pages/management_page.dart';
import 'package:tripify/pages/profile_page.dart';

// the files using
// ignore: unused_import
import './utilites/maps.dart';
import './pages/logo_page.dart';
import './pages/login_page.dart';
import './pages/help_page_user.dart';
import './utilites/routes.dart';
import './pages/registration_page.dart';
import './pages/materialColor.dart';
import './pages/home_page_admin.dart';
import './pages/home_page_driver.dart';
import './pages/home_page_user.dart';
import './pages/feeDetail_page.dart';
import './pages/seat_page.dart';
import './pages/change_password_page.dart';
import './pages/change_username_page.dart';
import './pages/travel_details.dart';
import './pages/viewStudents_admin.dart';
import "./pages/viewDriver_admin.dart";
import './pages/viewFinance_admin.dart';
import './pages/viewBus_admin.dart';
import './pages/manageFinance_admin.dart';
import './pages/manageBus_admin.dart';
import './pages/manageDriver_admin.dart';
import './pages/manageStudent_admin.dart';

void main() async {
  // For firebase implementation
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await start_firebase();
  configLoading();
  runApp(Tripify());
}

class Logged_In_Username {
  static String? Currently_logged_in_user = "";
}

Future start_firebase() async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      Logged_In_Username.Currently_logged_in_user = "";
      print('User is currently signed out!');
    } else {
      print(user.email);
      print('User is signed in!');
      // Fetch the username from the email
      Logged_In_Username.Currently_logged_in_user = user.email;
      //Removes everything after first '@exmaple.com'
      Logged_In_Username.Currently_logged_in_user =
          Logged_In_Username.Currently_logged_in_user!.substring(
              0, Logged_In_Username.Currently_logged_in_user!.indexOf('@'));
      // Remember to convert this from nullable string to normal string to use in the different function

    }
  });
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 4000)
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = const Color.fromARGB(255, 15, 42, 194)
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = const Color.fromARGB(255, 124, 9, 9)
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

// the stateless widget the main from where will run the app
class Tripify extends StatelessWidget {
  Tripify({Key? key}) : super(key: key);

  // the colors we are going to use
  var colorsUsed = [0xFF02323A, 0xFF7F7601, 0xFFD9B29C, 0xFFA66249, 0xFF5E0202];

  // the font size --- 0 index for headings and 1 for text
  var fontsUsed = [30.0, 18.0];

  // overriding the build method
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // this MaterialApp will be the base and will call all other from here
      // using a builder for easy loading plugin

      // defining the themes
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(colorsUsed[4])),
      ),

      initialRoute: MyRoutes.root,
      builder: EasyLoading.init(),

      // the routes that will help in the navigation
      routes: {
        // will assigin widgets accordingly
        MyRoutes.root: (context) => LogoPage(colorsUsed, fontsUsed),

        MyRoutes.loginRoute: (context) => LoginPage(colorsUsed, fontsUsed),
        MyRoutes.registerRoute: (context) =>
            Registration(colorsUsed, fontsUsed),

        // home pages
        MyRoutes.homeRoute: (context) => HomePageUser(colorsUsed, fontsUsed),
        MyRoutes.adminRoute: (context) => HomePageAdmin(colorsUsed, fontsUsed),
        MyRoutes.driverRoute: (context) =>
            HomePageDriver(colorsUsed, fontsUsed),

        // the help pages
        MyRoutes.helpRouteUser: (context) =>
            HelpPageUser(colorsUsed, fontsUsed),

        MyRoutes.profile: (context) => MyProfile(colorsUsed, fontsUsed),

        // the fee detail page
        MyRoutes.feeDetailRoute: (context) => FeeDetails(colorsUsed, fontsUsed),

        // the page showing seats
        MyRoutes.seatsPresentation: (context) => Seats(colorsUsed, fontsUsed),

        // the forget password page
        MyRoutes.changePassword: (context) =>
            ChangePassword(colorsUsed, fontsUsed),
        MyRoutes.changeUsername: (context) =>
            ChangeUsername(colorsUsed, fontsUsed),

        MyRoutes.viewStudents: (context) => ViewStudents(colorsUsed, fontsUsed),
        MyRoutes.viewDrivers: (context) => ViewDrivers(colorsUsed, fontsUsed),
        MyRoutes.viewFinance: (context) => ViewFinance(colorsUsed, fontsUsed),
        MyRoutes.viewBuses: (context) => ViewBuses(colorsUsed, fontsUsed),

        MyRoutes.manageFinance: (context) =>
            ManageFinance(colorsUsed, fontsUsed),

        MyRoutes.manageBus: (context) => ManageBus(colorsUsed, fontsUsed),
        MyRoutes.manageStudents: (context) =>
            ManageStudent(colorsUsed, fontsUsed),
        MyRoutes.manageDrivers: (context) =>
            ManageDriver(colorsUsed, fontsUsed),
      },
    );
  }
}
