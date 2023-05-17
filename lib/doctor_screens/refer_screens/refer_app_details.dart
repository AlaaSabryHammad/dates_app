import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class ReferAppDetails extends StatelessWidget {
  const ReferAppDetails(
      {super.key,
      required this.clinicDocument,
      required this.doctorDocument,
      required this.startDate,
      required this.endDate,
      required this.patientName,
      required this.patientId,
      required this.oldApp});
  final QueryDocumentSnapshot clinicDocument;
  final QueryDocumentSnapshot doctorDocument;
  final QueryDocumentSnapshot oldApp;
  final DateTime startDate;
  final DateTime endDate;
  final String patientName, patientId;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 120, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Appointments Details',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: mainColor),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Clinic Name :",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                ),
                Text(
                  "${clinicDocument.get('clinic_name')}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Doctor Name :",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                ),
                Text(
                  "${doctorDocument.get('name')}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Start Time :",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                ),
                Text(
                  "$startDate",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "End Time :",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                ),
                Text(
                  "$endDate",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
              ],
            )),
            MaterialButton(
              minWidth: width - 50,
              padding: const EdgeInsets.symmetric(vertical: 20),
              elevation: 15,
              color: mainColor,
              onPressed: () async {
                await firebaseFirestore
                    .collection('doctors')
                    .doc(doctorDocument.id)
                    .collection('appointments')
                    .add({
                  'startTime': startDate,
                  'endTime': endDate,
                  'status': 'booked'
                });
                await firebaseFirestore
                    .collection('bookings')
                    .doc(oldApp.id)
                    .update({
                  'status': 'completed',
                  'isRefered': true,
                });
                await firebaseFirestore.collection('bookings').add({
                  'patientId': patientId,
                  'patientName': patientName,
                  'startTime': startDate,
                  'endTime': endDate,
                  'clinic': clinicDocument.get('clinic_name'),
                  'clinicID': clinicDocument.id,
                  'doctor': doctorDocument.get('name'),
                  'doctorID': doctorDocument.id,
                  'status': 'active',
                  'isWaiting': true,
                  'isRefered': false,
                  'prescription': null,
                  'tests': null
                });
                Navigator.pushReplacementNamed(context, '/doctor-app');
              },
              child: const Text(
                'Confirm Appointment',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}