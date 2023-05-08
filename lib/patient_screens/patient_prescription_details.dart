import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PatientPrescriptionDetail extends StatelessWidget {
  const PatientPrescriptionDetail({super.key, required this.item});
  final QueryDocumentSnapshot item;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 20),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.yellow.withOpacity(0.5),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow.withOpacity(0.5),
              border: Border.all(width: 2, color: Colors.blue),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [Text('Dr. Samia Ragab')],
            ),
          ),
        ),
      ),
    );
  }
}
