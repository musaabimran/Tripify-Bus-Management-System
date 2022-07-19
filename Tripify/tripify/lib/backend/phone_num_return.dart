import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
// Take the JSON as input and Fetch the selected_Value field
class phone_num_return {
  String phone_num;
// A varialbe
  phone_num_return(this.phone_num);
// A function to PARSE the JSON coming from the Database
  factory phone_num_return.fromJson(dynamic json) {
    return phone_num_return(json['phone_num'] as String);
  }
  // Return me the selected Value as string
  @override
  String toString() {
    return '${this.phone_num} ';
  }
}
