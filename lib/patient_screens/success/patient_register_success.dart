import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class PatientRegisterSuccess extends StatelessWidget {
  const PatientRegisterSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/ok.png',
                    width: 130,
                    height: 130,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome ...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: mainColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 20),
                elevation: 10,
                color: textColor,
                onPressed: () {
                  print(FirebaseAuth.instance.currentUser);
                  Navigator.pushReplacementNamed(context, '/patient-home');
                },
                child: const Text(
                  'Start',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ))
        ],
      ),
    );
  }
}
