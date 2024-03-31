//import 'package:expense_wise/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_dilivery_application_1/pages/login.dart';
//import 'package:expense_wise/Screens/dashboard.dart';
//import 'package:expense_wise/services/db.dart';



class AuthService {
  //var db = Db();






  Future<void> deleteuser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => LoginPage())),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to delete account: ${e.toString()}"),
          );
        },
      );
    }
  }



  Future<void> logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => LoginPage())),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to logout: ${e.toString()}"),
          );
        },
      );
    }
  }

}
