import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
// Take the JSON as input and Fetch the selected_Value field
class fee_return {
  String fee;
// A varialbe
  fee_return(this.fee);
// A function to PARSE the JSON coming from the Database
  factory fee_return.fromJson(dynamic json) {
    return fee_return(json['fee'] as String);
  }
  // Return me the selected Value as string
  @override
  String toString() {
    return '${this.fee} ';
  }
}
