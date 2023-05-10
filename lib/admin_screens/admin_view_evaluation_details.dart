import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/constants.dart';
import 'package:flutter/material.dart';

class AdminViewEvaluationDetails extends StatefulWidget {
  const AdminViewEvaluationDetails({super.key, required this.item});
  final QueryDocumentSnapshot item;

  @override
  State<AdminViewEvaluationDetails> createState() =>
      _AdminViewEvaluationDetailsState();
}

class _AdminViewEvaluationDetailsState
    extends State<AdminViewEvaluationDetails> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String name = '';
  getPatientName() async {
    await firebaseFirestore
        .collection('patients')
        .doc(widget.item['patientId'])
        .get()
        .then((value) {
      setState(() {
        name = value.get('fname');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPatientName();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Service Evaluation',
                style: mainHeaderStyle,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Patient Name',
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                  child: Text(
                name,
                style: TextStyle(
                    color: mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Doctor Name',
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                  child: Text(
                widget.item['doctorName'],
                style: TextStyle(
                    color: mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Evaluation',
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: width - 40,
                // height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                    child: Text(
                  widget.item['description'],
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              minWidth: width - 150,
              elevation: 5,
              color: mainColor,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Done',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
