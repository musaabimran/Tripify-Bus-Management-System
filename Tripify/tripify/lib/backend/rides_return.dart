import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
// Take the JSON as input and Fetch the selected_Value field
class rides_return {
  int _rides;
// A varialbe
  rides_return(this._rides);
// A function to PARSE the JSON coming from the Database
  factory rides_return.fromJson(dynamic json) {
    return rides_return(json['rides'] as int);
  }
  // Return me the selected Value as string
  @override
  String toString() {
    return '${this._rides} ';
  }
}
