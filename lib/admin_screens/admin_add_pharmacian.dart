import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AdminAddPharmacian extends StatefulWidget {
  const AdminAddPharmacian({super.key});

  @override
  State<AdminAddPharmacian> createState() => _AdminAddPharmacianState();
}

class _AdminAddPharmacianState extends State<AdminAddPharmacian> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool sexStatus = true;
  String sex = 'male';
  String? dropdownValue;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mainColor.withOpacity(0.3)),
                    child: Image.asset(
                      'images/pharmacian.png',
                      width: width * 0.5,
                      height: width * 0.5,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Add Pharmacist',
                    style: mainHeaderStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AddDoctorTextField(
                    controller: userNameController,
                    hint: 'Doctor User Name ...',
                    icon: Icons.person,
                    label: 'User Name',
                  ),
                  AddDoctorTextField(
                    controller: emailController,
                    hint: 'Doctor Email Address ...',
                    icon: Icons.email,
                    label: 'Email Address',
                  ),
                  AddDoctorTextField(
                    controller: passwordController,
                    hint: 'Doctor password ...',
                    icon: Icons.lock,
                    label: 'Password',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sexStatus = true;
                            sex = 'Male';
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                              color: sexStatus
                                  ? mainColor
                                  : Colors.grey.withOpacity(0.5)),
                          child: const Center(
                            child: Text(
                              'Male',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sexStatus = false;
                            sex = 'Female';
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                              color: sexStatus
                                  ? Colors.grey.withOpacity(0.5)
                                  : mainColor),
                          child: const Center(
                            child: Text(
                              'Female',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    color: mainColor,
                    minWidth: width - 120,
                    elevation: 5,
                    onPressed: () async {
                      FirebaseApp app = await Firebase.initializeApp(
                          name: 'Secondary', options: Firebase.app().options);
                      try {
                        UserCredential userCredential =
                            await FirebaseAuth.instanceFor(app: app)
                                .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                        await firebaseFirestore
                            .collection('doctors')
                            .doc(userCredential.user!.uid)
                            .set({
                          'email': emailController.text,
                          'name': userNameController.text,
                          'password': passwordController.text,
                          'sex': sex,
                          'clinic': dropdownValue
                        });
                        Navigator.pushReplacementNamed(
                            context, '/view-doctors');
                      } on FirebaseAuthException {
                        // Do something with exception. This try/catch is here to make sure
                        // that even if the user creation fails, app.delete() runs, if is not,
                        // next time Firebase.initializeApp() will fail as the previous one was
                        // not deleted.
                      }

                      await app.delete();
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddDoctorTextField extends StatelessWidget {
  const AddDoctorTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
  });
  final TextEditingController controller;
  final String label, hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
            )),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon),
              border: const OutlineInputBorder()),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
