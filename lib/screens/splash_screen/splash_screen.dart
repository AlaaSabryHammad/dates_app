import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      if (user != null) {
        DocumentSnapshot ds = await FirebaseFirestore.instance
            .collection('patients')
            .doc(user!.uid)
            .get();
        if (ds.exists) {
          Navigator.pushReplacementNamed(context, '/patient-home');
        } else {
          Navigator.pushReplacementNamed(context, '/complete-patient-profile');
        }
      } else {
        Navigator.pushReplacementNamed(context, '/choose-login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(1, 1), blurRadius: 5)
              ]),
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  'images/logo.png',
                  width: width * 0.4,
                  height: width * 0.4,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'TAIBAH CARE',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
