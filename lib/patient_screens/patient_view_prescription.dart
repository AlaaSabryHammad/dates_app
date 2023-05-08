import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/constants.dart';
import 'package:dates_app/patient_screens/patient_prescription_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientViewDescriptions extends StatefulWidget {
  const PatientViewDescriptions({super.key});

  @override
  State<PatientViewDescriptions> createState() =>
      _PatientViewDescriptionsState();
}

class _PatientViewDescriptionsState extends State<PatientViewDescriptions> {
  List<PreCardWidget> preList = [];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  getPrescription() async {
    await firebaseFirestore
        .collection('bookings')
        .where('patientId', isEqualTo: firebaseAuth.currentUser!.uid)
        .get()
        .then((value) {
      for (var item in value.docs) {
        DateTime date = item['startTime'].toDate();
        String myDate = '${date.day}/${date.month}/${date.year}';
        print(myDate);
        setState(() {
          preList.add(PreCardWidget(
            clinic: item['clinic'],
            doctor: item['doctor'],
            date: myDate,
            item: item,
          ));
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getPrescription();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'My Prescriptions',
                style: mainHeaderStyle,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            preList.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        'No Prescriptions',
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: preList.length,
                        itemBuilder: (context, index) {
                          return preList[index];
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}

class PreCardWidget extends StatelessWidget {
  const PreCardWidget(
      {super.key,
      required this.doctor,
      required this.clinic,
      required this.date,
      required this.item});
  final String doctor, clinic, date;
  final QueryDocumentSnapshot item;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PatientPrescriptionDetail(item: item)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(20),
        height: 150,
        width: width - 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              customBoxShadow,
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    doctor,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    clinic,
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                date,
                style: TextStyle(
                    color: mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
