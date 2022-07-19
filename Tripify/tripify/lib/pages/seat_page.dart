import 'package:flutter/material.dart';

String selectedSeat = "S" + selectedi.toString() + selectedj.toString();

class Seats extends StatelessWidget {
  final List colorsUsed; // the colors used in the app
  final List fontsUsed; // the fonts used in the app

  const Seats(this.colorsUsed, this.fontsUsed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var _status = [
      [1, 1, 1, 0],
      [1, 1, 0, 1],
      [1, 1, 1, 1],
      [1, 1, 1, 1],
      [1, 1, 0, 0],
      [1, 1, 1, 1],
      [1, 1, 1, 1],
      [1, 1, 0, 1],
      [1, 0, 0, 1],
      [1, 1, 1, 1],
      [1, 1, 1, 1],
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              'Select Your Seat',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(colorsUsed[0]),
              ),
            ),
          ),
          Container(
            height: 720,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                Column(
                  children: [
                    for (int i = 0; i <= 10; i++)
                      Container(
                          margin:
                              EdgeInsets.only(top: 1 == 4 ? size.width * 2 : 1),
                          child: Row(
                            children: <Widget>[
                              for (int j = 1; j <= 4; j++)
                                Expanded(
                                  // flex: j == 1 || j == 10 ? 2 : 1,
                                  child: (i == 0 && j == 2) ||
                                          (i == 2 && j == 3) ||
                                          (i == 1 && j == 3) ||
                                          (i == 1 && j == 4) ||
                                          (i == 3 && j == 3) ||
                                          (i == 3 && j == 2) ||
                                          (i == 3 && j == 1) ||
                                          (i == 3 && j == 0) ||
                                          //(i == 0 || j == 1) ||
                                          (i == 0 && j == 2) ||
                                          (i == 0 && j == 3) ||
                                          (i == 0 && j == 3)
                                      ? Container()
                                      : Container(
                                          height: size.width / 10,
                                          width: 100 / 10,
                                          margin: EdgeInsets.all(5.2),
                                          child: _status[i][j - 1] == 1
                                              ? Chairs(colorsUsed, fontsUsed,
                                                  true, selected, i, j)
                                              : Chairs(colorsUsed, fontsUsed,
                                                  false, true, i, j),
                                        ),
                                )
                            ],
                          ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Chairs extends StatefulWidget {
  final List colorsUsed; // the colors used in the app
  final List fontsUsed; // the fonts used in the app
  final bool available; // the status of the chair
  final bool selected; // the status of the chair
  final int i;
  final int j;
  const Chairs(this.colorsUsed, this.fontsUsed, this.available, this.selected,
      this.i, this.j);

  @override
  State<Chairs> createState() => _ChairsState();
}

int colorSeat = 4;
double borderWidth = 0.0;
bool selected = false;
int selectedi = -1;
int selectedj = -1;

class _ChairsState extends State<Chairs> {
  select() {
    setState(() {
      selected = !selected;
      selectedi = selected ? widget.i : -1;
      selectedj = selected ? widget.j : -1;
      colorSeat = selected ? 1 : 4;
      borderWidth = selected ? 5.0 : 0.0;
      selectedSeat = "S" + selectedi.toString() + selectedj.toString();
    });
  }

  // for one seat only
  oneSeat() {}

  @override
  Widget build(BuildContext context) {
    return widget.available
        ? InkWell(
            child: Container(
              height: 12.0,
              width: 12.0,
              decoration: BoxDecoration(
                color: Color(widget.colorsUsed[colorSeat]),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Color(widget.colorsUsed[0]),
                  width: borderWidth,
                ),
              ),
            ),
            onTap: () {
              ((selectedi == -1 && selectedj == -1) ||
                      (selectedi == widget.i && selectedj == widget.j))
                  ? select()
                  : oneSeat();
            },
          )
        : Container(
            height: 12.0,
            width: 12.0,
            decoration: BoxDecoration(
              color: Color(widget.colorsUsed[0]),
              borderRadius: BorderRadius.circular(6),
            ),
          );
  }
}
