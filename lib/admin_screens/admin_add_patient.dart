import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';

class AdminAddPatient extends StatefulWidget {
  const AdminAddPatient({super.key});

  @override
  State<AdminAddPatient> createState() => _AdminAddPatientState();
}

class _AdminAddPatientState extends State<AdminAddPatient> {
  String? fname;
  String? lname;
  String? email;
  String? password;
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'images/patient.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Add Patient',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: mainColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  onPressed: (value) {
                    fname = value;
                  },
                  label: 'First Name',
                  hint: 'first name ...',
                  icon: Icons.person,
                  isSecured: false,
                  controller: fnameController,
                ),
                CustomTextField(
                  onPressed: (value) {
                    lname = value;
                  },
                  label: 'Last Name',
                  hint: 'last name ...',
                  icon: Icons.person,
                  isSecured: false,
                  controller: lnameController,
                ),
                CustomTextField(
                  onPressed: (value) {
                    email = value;
                  },
                  label: 'Email Address',
                  hint: 'email address ...',
                  icon: Icons.email,
                  isSecured: false,
                  controller: emailController,
                ),
                CustomTextField(
                  onPressed: (value) {
                    password = value;
                  },
                  label: 'Password',
                  hint: 'password ...',
                  icon: Icons.person,
                  isSecured: false,
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  minWidth: width - 100,
                  color: mainColor,
                  onPressed: () async {
                    FirebaseFirestore firebaseFirestore =
                        FirebaseFirestore.instance;
                    FirebaseApp app = await Firebase.initializeApp(
                        name: 'Secondary', options: Firebase.app().options);
                    if (lname == null ||
                        email == null ||
                        password == null ||
                        fname == null) {
                      var snackBar = const SnackBar(
                          content: Text('Complete patient data ...'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      try {
                        UserCredential userCredential =
                            await FirebaseAuth.instanceFor(app: app)
                                .createUserWithEmailAndPassword(
                                    email: email!, password: password!);
                        await firebaseFirestore
                            .collection('patients')
                            .doc(userCredential.user!.uid)
                            .set({
                          'fName': fname,
                          'lName' : lname,
                          'email': email,
                          'password': password,
                          'type': 'patient'
                        });
                        // Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushReplacementNamed(context, '/home');
                        // });
                      } on FirebaseAuthException {
                        // Do something with exception. This try/catch is here to make sure
                        // that even if the user creation fails, app.delete() runs, if is not,
                        // next time Firebase.initializeApp() will fail as the previous one was
                        // not deleted.
                      }
                      await app.delete();
                    }
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
