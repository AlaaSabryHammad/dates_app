import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../widgets/custom_textfield.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
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
                    tag: 'admin',
                    child: Image.asset(
                      'images/admin.png',
                      width: width * 0.4,
                      height: width * 0.4,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Admin Login',
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    controller: emailController,
                  ),
                  CustomTextField(
                    hint: 'Enter your password .....',
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
                      List admin = await firebaseFirestore
                          .collection('admins')
                          .get()
                          .then((value) {
                        return [
                          value.docs.first['email'],
                          value.docs.first['password']
                        ];
                      });
                      if (emailAddress == admin[0] && password == admin[1]) {
                        Navigator.pushNamed(context, '/home');
                      } else {
                        const snackBar = SnackBar(
                            content: Text('login data not correct ...'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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