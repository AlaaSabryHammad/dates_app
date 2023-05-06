import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/constants.dart';
import 'package:flutter/material.dart';

class DoctorRecordTestScreen extends StatefulWidget {
  const DoctorRecordTestScreen({super.key, required this.item});
  final QueryDocumentSnapshot item;

  @override
  State<DoctorRecordTestScreen> createState() => _DoctorRecordTestScreenState();
}

class _DoctorRecordTestScreenState extends State<DoctorRecordTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Test Records',
                style: mainHeaderStyle,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // GridView.builder(
            //     gridDelegate: gridDelegate, itemBuilder: itemBuilder)
          ],
        ),
      ),
    );
  }
}
