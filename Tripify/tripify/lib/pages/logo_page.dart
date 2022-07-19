import 'package:flutter/material.dart';
import 'package:tripify/utilites/routes.dart';

// making a stateful widget that will handel logo and animation
// the very first page that will be seen when application is started
class LogoPage extends StatefulWidget {
  // const LogoPage({Key? key}) : super(key: key);
  //saving the fonts and colors given
  // the colors and fonts passed
  final List colorsUsed;
  final List fontsUsed;
  const LogoPage(this.colorsUsed, this.fontsUsed);

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage>
    with SingleTickerProviderStateMixin {
  void toNextPage() async {
    // await Future.delayed(const Duration(seconds: 2));
    Navigator.pushNamed(context, MyRoutes.loginRoute);
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
      // giving the background color from our pallete
      backgroundColor: Color(widget.colorsUsed[0]),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 190, 0, 0),
            child: Center(
              child: Image.asset(
                "./assets/images/tripifyOnly_Light.png",
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller.view,
            builder: (context, child) {
              // will translate the image
              return Transform.translate(
                offset: Offset(590 * _controller.value - 300, 0.0), //the ofset
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  padding: EdgeInsets.all(0),
                  child: Image.asset(
                    "./assets/images/busOnly.png",
                  ),
                ), // use the child the logo image
              );
            },
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: ElevatedButton(
              onPressed: toNextPage,
              child: const Text("Let's Go"),
              style: ElevatedButton.styleFrom(
                // styling it
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                side:
                    BorderSide(color: Color(widget.colorsUsed[2]), width: 2.0),
                fixedSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 150, 0, 0),
            child: Text(
              "Powered By IMU Solutions",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(widget.colorsUsed[2]),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
