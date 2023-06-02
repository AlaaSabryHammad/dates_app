import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/view_screens/view_doctors_screen/doctor_details_screen.dart';

class AdminLabDetailsScreen extends StatelessWidget {
  const AdminLabDetailsScreen({super.key, required this.item});
  final QueryDocumentSnapshot item;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 250,
                    width: width,
                    decoration: BoxDecoration(color: textColor),
                    child: Center(
                      child: Text(
                        item['name'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: -50,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          item['sex'] == 'male'
                              ? 'images/man.png'
                              : 'images/girl.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              DoctorDetailCard(
                label: 'Name',
                value: item['name'],
              ),
              DoctorDetailCard(
                label: 'Email Address',
                value: item['email'],
              ),
              // DoctorDetailCard(
              //   label: 'Clini',
              //   value: item['clinic'],
              // ),
              DoctorDetailCard(
                label: 'Password',
                value: item['password'],
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: 200,
                elevation: 5,
                color: textColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 35,
              )
            ],
          ),
        ),
      ),
    );
  }
}
