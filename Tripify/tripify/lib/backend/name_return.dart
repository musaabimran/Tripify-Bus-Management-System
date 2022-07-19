import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
// Take the JSON as input and Fetch the selected_Value field
class name_return {
  String _name;
// A varialbe
  name_return(this._name);
// A function to PARSE the JSON coming from the Database
  factory name_return.fromJson(dynamic json) {
    return name_return(json['name'] as String);
  }
  // Return me the selected Value as string
  @override
  String toString() {
    return '${this._name} ';
  }
}
