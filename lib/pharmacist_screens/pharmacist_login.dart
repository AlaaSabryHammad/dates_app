import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/pharmacist_screens/pharmacist_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/custom_textfield.dart';

class PharmacistLogin extends StatefulWidget {
  const PharmacistLogin({super.key});

  @override
  State<PharmacistLogin> createState() => _PharmacistLoginState();
}

class _PharmacistLoginState extends State<PharmacistLogin> {
  String? emailAddress;
  String? password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: 'pharmacian',
                    child: Image.asset(
                      'images/pharmacian.png',
                      width: width * 0.4,
                      height: width * 0.4,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Pharmacist Login',
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
                      'Login to continue',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    hint: 'Enter Your Email Address',
                    icon: Icons.email,
                    label: 'Email Address',
                    onPressed: (value) {
                      emailAddress = value;
                    },
                    isSecured: false,
                    controller: emailController,
                  ),
                  CustomTextField(
                    hint: 'Enter Your Password',
                    icon: Icons.lock,
                    label: 'Password',
                    onPressed: (value) {
                      password = value;
                    },
                    isSecured: true,
                    controller: passwordController,
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
                        await firebaseFirestore
                            .collection('pharmacists')
                            .doc(credential.user!.uid)
                            .get()
                            .then((value) {
                          if (value.exists) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PharmacistHomePage()));
                          } else {
                            const snackBar = SnackBar(
                                content: Text('login data not correct'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          const snackBar = SnackBar(
                              content: Text('No user found for that email.'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (e.code == 'wrong-password') {
                          const snackBar = SnackBar(
                              content: Text(
                                  'Wrong password provided for that user.'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    color: mainColor,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 1.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
