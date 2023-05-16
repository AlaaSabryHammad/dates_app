import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({super.key, required this.patientDocument});
  final Map<String, dynamic> patientDocument;

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? password, newPassword, confirm;
  resetPass() {
    firebaseAuth.currentUser!.updatePassword(newPassword!);
    firebaseFirestore
        .collection('patients')
        .doc(firebaseAuth.currentUser!.uid)
        .update({'password': newPassword});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 70, right: 20, left: 20),
          child: Column(
            children: [
              Container(
                width: 135,
                height: 135,
                decoration:
                    BoxDecoration(color: mainColor, shape: BoxShape.circle),
                child: Center(
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(65),
                        child: Image.asset(
                          'images/girl.png',
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${widget.patientDocument['fname']} ${widget.patientDocument['lname']}',
                style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                widget.patientDocument['email'],
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              Text(
                'Age : ${widget.patientDocument['age']}',
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: 135,
                height: 135,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: mainColor, width: 2, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [customBoxShadow],
                    color: Colors.white),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 50,
                        color: mainColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Update profile Info.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: 135,
                height: 135,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: mainColor, width: 2, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [customBoxShadow],
                    color: Colors.white),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_copy,
                        size: 50,
                        color: mainColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'View Medical File',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  resetPassword(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 135,
                  height: 135,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: mainColor, width: 2, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [customBoxShadow],
                      color: Colors.white),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          size: 50,
                          color: mainColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Reset Password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: textColor, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> resetPassword(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Reset Password',
                    style: TextStyle(
                        fontSize: 30,
                        color: mainColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: const InputDecoration(
                        hintText: 'write old password ....'),
                  ),
                  TextField(
                    onChanged: (value) {
                      newPassword = value;
                    },
                    decoration: const InputDecoration(
                        hintText: 'write new password ....'),
                  ),
                  TextField(
                    onChanged: (value) {
                      confirm = value;
                    },
                    decoration: const InputDecoration(
                        hintText: 'confirm new password ....'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    minWidth: 120,
                    color: mainColor,
                    onPressed: () async {
                      await firebaseFirestore
                          .collection('patients')
                          .doc(firebaseAuth.currentUser!.uid)
                          .get()
                          .then((value) async {
                        if (password == value.get('password')) {
                          if (newPassword == confirm) {
                            await resetPass();
                            var snackBar = const SnackBar(
                                content:
                                    Text('Password reset successfully ...'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            var snackBar = const SnackBar(
                                content: Text('old Password not correct ...'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      });
                      // Navigator.pop(context);
                    },
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
