import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/patient_screens/success/patient_update_profile_success.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class PatientUpdateProfile extends StatefulWidget {
  const PatientUpdateProfile({super.key, required this.patient});
  final Map patient;

  @override
  State<PatientUpdateProfile> createState() => _PatientUpdateProfileState();
}

class _PatientUpdateProfileState extends State<PatientUpdateProfile> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  TextEditingController nationalController = TextEditingController();
  TextEditingController chromesController = TextEditingController();
  TextEditingController allergyController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    fnameController.text = widget.patient['fname'];
    lnameController.text = widget.patient['lname'];
    // emailController.text = widget.patient['email'];
    // passwordController.text = widget.patient['password'];
    allergyController.text = widget.patient['allegry'];
    chromesController.text = widget.patient['chromes'];
    nationalController.text = widget.patient['nationalid'];
    ageController.text = widget.patient['age'];
  }

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
                  'Update Profile',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: mainColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'First Name',
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: fnameController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Name',
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: lnameController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Age',
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: ageController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.date_range),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'National ID',
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: nationalController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Allergy',
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: allergyController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.health_and_safety),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chronic Diseases',
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: chromesController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.health_and_safety),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
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
                    if (lnameController.text.isEmpty ||
                        fnameController.text.isEmpty ||
                        ageController.text.isEmpty ||
                        allergyController.text.isEmpty ||
                        chromesController.text.isEmpty ||
                        nationalController.text.isEmpty) {
                      var snackBar = const SnackBar(
                          content: Text('Complete patient data ...'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      await firebaseFirestore
                          .collection('patients')
                          .doc(firebaseAuth.currentUser!.uid)
                          .update({
                        'fname': fnameController.text,
                        'lname': lnameController.text,
                        'age': ageController.text,
                        'nationalid': nationalController.text,
                        'allegry': allergyController.text,
                        'chromes': chromesController.text,
                      });
                      await firebaseAuth.currentUser!.updateDisplayName(
                          '${fnameController.text} ${lnameController.text}');
                      // ignore: use_build_context_synchronously
                      // Navigator.pushReplacementNamed(context, '/patient-home');
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PatientUpdateProfileSuccess()));
                    }
                  },
                  child: const Text(
                    'Update',
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
