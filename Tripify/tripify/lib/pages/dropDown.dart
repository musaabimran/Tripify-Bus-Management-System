import 'package:flutter/material.dart';

// the widget that will make the faq drop down
class DropMedown extends StatelessWidget {
  final List colorsUsed;
  final List fontsUsed;
  final String title; // the title of the drop down
  final String text; // the text of the drop down

  // the constructor using it
  DropMedown(this.title, this.text, this.colorsUsed, this.fontsUsed);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(colorsUsed[0]),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[350],
      ),
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      child: ExpansionTile(
        backgroundColor: Color(colorsUsed[2]),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontsUsed[1],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            //to avoid any overflow
            child: Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Color(colorsUsed[0]),
                  fontSize: fontsUsed[1],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
