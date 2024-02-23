import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFieldStyle() {
    return const TextStyle(
        height:5.0,

        //wordSpacing: 10.0,
        color: Color.fromRGBO(246, 246, 246, 1.0),
        // color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle HeadLineTextFieldStyle() {
    return const TextStyle(
        height:1.0,

        //wordSpacing: 10.0,
        color: Color.fromRGBO(9, 9, 8, 1.0),
        // color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }
  static TextStyle LightTextFieldStyle() {
    return const TextStyle(
        height:1.0,

        //wordSpacing: 10.0,
        color: Colors.black38,
        // color: Colors.black,
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle semiBoldTextFieldStyle() {
    return const TextStyle(
        height:1.0,

        //wordSpacing: 8.0,
        color: Colors.black,
        // color: Colors.black,
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }
}
