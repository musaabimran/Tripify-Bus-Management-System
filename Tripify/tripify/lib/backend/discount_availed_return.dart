import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
// Take the JSON as input and Fetch the selected_Value field
class discount_availed_return {
  int _discount_availed;
// A varialbe
  discount_availed_return(this._discount_availed);
// A function to PARSE the JSON coming from the Database
  factory discount_availed_return.fromJson(dynamic json) {
    return discount_availed_return(json['Discount_availed'] as int);
  }
  // Return me the selected Value as string
  @override
  String toString() {
    return '${this._discount_availed} ';
  }
}
