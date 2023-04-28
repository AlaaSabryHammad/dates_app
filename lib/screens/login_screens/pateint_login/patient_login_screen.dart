import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';

class PatientLoginScreen extends StatefulWidget {
  const PatientLoginScreen({super.key});

  @override
  State<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
  String? emailAddress;
  String? password;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'patient',
                  child: Image.asset(
                    'images/patient.png',
                    width: width * 0.4,
                    height: width * 0.4,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Patient Login',
                    style: TextStyle(
                        color: textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login to continue ...... !',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  hint: 'Enter your email address .....',
                  icon: Icons.email,
                  label: 'Email Adress',
                  onPressed: (value) {
                    emailAddress = value;
                  },
                  isSecured: false,
                ),
                CustomTextField(
                  hint: 'Enter your password .....',
                  icon: Icons.lock,
                  label: 'Password',
                  onPressed: (value) {
                    password = value;
                  },
                  isSecured: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  elevation: 5,
                  onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailAddress!, password: password!);
                      DocumentSnapshot ds = await FirebaseFirestore.instance
                          .collection('patients')
                          .doc(credential.user!.uid)
                          .get();
                      if (ds.exists) {
                        Navigator.pushReplacementNamed(
                            context, '/patient-home');
                      } else {
                        Navigator.pushReplacementNamed(
                            context, '/complete-patient-profile');
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                  },
                  color: mainColor,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, letterSpacing: 1.1),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text("Don't you have an account ...?"),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/patient-register');
                        },
                        child: const Text('Register .'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
