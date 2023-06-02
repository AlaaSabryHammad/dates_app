import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class PatientAppUpdateDetails extends StatelessWidget {
  const PatientAppUpdateDetails(
      {super.key,
      required this.oldApp,
      required this.startDate,
      required this.endDate});
  final QueryDocumentSnapshot oldApp;
  final DateTime startDate;
  final DateTime endDate;

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
                'Appointment Details',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: mainColor),
              ),
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [customBoxShadow],
                  border: Border.all(
                      color: mainColor, width: 2, style: BorderStyle.solid)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Clinic Name :",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: mainColor),
                    ),
                  ),
                  Text(
                    "${oldApp.get('clinic')}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Doctor Name :",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: mainColor),
                    ),
                  ),
                  Text(
                    "${oldApp.get('doctor')}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Start Time :",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: mainColor),
                    ),
                  ),
                  Text(
                    "$startDate",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "End Time :",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: mainColor),
                    ),
                  ),
                  Text(
                    "$endDate",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                ],
              ),
            )),
            MaterialButton(
              minWidth: width - 50,
              padding: const EdgeInsets.symmetric(vertical: 20),
              elevation: 15,
              color: mainColor,
              onPressed: () async {
                await firebaseFirestore
                    .collection('doctors')
                    .doc(oldApp.get('doctorID'))
                    .collection('appointments')
                    .where('startTime', isEqualTo: oldApp.get('startTime'))
                    .get()
                    .then((value) async {
                  for (var doc in value.docs) {
                    await firebaseFirestore
                        .collection('doctors')
                        .doc(oldApp.get('doctorID'))
                        .collection('appointments')
                        .doc(doc.id)
                        .update({
                      'startTime': startDate,
                      'endTime': endDate,
                    });
                  }
                });
                await firebaseFirestore
                    .collection('bookings')
                    .doc(oldApp.id)
                    .update({
                  'startTime': startDate,
                  'endTime': endDate,
                });
                // await firebaseFirestore
                //     .collection('doctors')
                //     .doc(doctorDocument.id)
                //     .collection('appointments')
                //     .add({
                //   'startTime': startDate,
                //   'endTime': endDate,
                //   'status': 'booked'
                // });
                // await firebaseFirestore
                //     .collection('patients')
                //     .doc(FirebaseAuth.instance.currentUser!.uid)
                //     .get()
                //     .then((value) async {
                //   await firebaseFirestore.collection('bookings').add({
                //     'patientId': FirebaseAuth.instance.currentUser!.uid,
                //     'medicalFileNumber': value.get('medicalFileNumber'),
                //     'patientName':
                //         FirebaseAuth.instance.currentUser!.displayName,
                //     'startTime': startDate,
                //     'endTime': endDate,
                //     'clinic': clinicDocument.get('clinic_name'),
                //     'clinicID': clinicDocument.id,
                //     'doctor': doctorDocument.get('name'),
                //     'doctorID': doctorDocument.id,
                //     'status': 'active',
                //     'isWaiting': true,
                //     'isRefered': false,
                //     'testCompleted': false,
                //     'preCompleted': false
                //   });
                // });
                Navigator.pushReplacementNamed(
                    context, '/patient-book-app-success');
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
