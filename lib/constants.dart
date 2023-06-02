import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Color mainColor = const Color(0xff07c1cb);
Color textColor = const Color(0xff77949a);
BoxShadow customBoxShadow =
    const BoxShadow(color: Colors.black26, offset: Offset(1, 1), blurRadius: 5);
// String adminEmail = 'admin@admin.com';
// String adminPassword = '123456789';
TextStyle mainHeaderStyle =
    TextStyle(fontSize: 30, color: mainColor, fontWeight: FontWeight.bold);
adminLogin(String password) async {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'admin@taibahu.edu.sa', password: password);
  return credential;
}
