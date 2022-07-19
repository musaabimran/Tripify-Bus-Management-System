import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
// Take the JSON as input and Fetch the selected_Value field
class booking_Test {
  String test;
// A varialbe
  booking_Test(this.test);
// A function to PARSE the JSON coming from the Database
  factory booking_Test.fromJson(dynamic json) {
    return booking_Test(json['added'] as String);
  }
  // Return me the selected Value as string
  @override
  String toString() {
    return '${this.test} ';
  }
}
