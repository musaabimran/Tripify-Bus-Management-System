import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
// Take the JSON as input and Fetch the selected_Value field
class selected_value_return {
  int selected_value;
// A varialbe
  selected_value_return(this.selected_value);
// A function to PARSE the JSON coming from the Database
  factory selected_value_return.fromJson(dynamic json) {
    return selected_value_return(json['selected_value'] as int);
  }
  // Return me the selected Value as string
  @override
  String toString() {
    return '${this.selected_value} ';
  }
}
