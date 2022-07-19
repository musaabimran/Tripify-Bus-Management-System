import 'package:flutter/material.dart';

// making a customized wifget for the button the stateless widget
class Button extends StatelessWidget {
  // Button({ Key? key }) : super(key: key);

  //will use as given
  final List colorsUsed;
  final List fontsUsed;
  final String text;
  final VoidCallback doThis;

  //constructor taking the values and then will use
  const Button(this.colorsUsed, this.fontsUsed, this.text, this.doThis);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: doThis,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          // the background color
          primary: Color(colorsUsed[0]),
          padding: const EdgeInsets.all(10),
          side: BorderSide(color: Color(colorsUsed[2]), width: 2.0),
          alignment: Alignment.center,
          fixedSize: const Size(150, 50),
          textStyle: TextStyle(
            fontSize: fontsUsed[1],
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
