import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
// Take the JSON as input and Fetch the selected_Value field
class bus_no_return {
  String _bus_no;
// A varialbe
  bus_no_return(this._bus_no);
// A function to PARSE the JSON coming from the Database
  factory bus_no_return.fromJson(dynamic json) {
    return bus_no_return(json['bus_no'] as String);
  }
  // Return me the selected Value as string
  @override
  String toString() {
    return '${this._bus_no} ';
  }
}
