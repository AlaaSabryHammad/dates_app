import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientAddServiceEvaluations extends StatefulWidget {
  const PatientAddServiceEvaluations({super.key});

  @override
  State<PatientAddServiceEvaluations> createState() =>
      _PatientAddServiceEvaluationsState();
}

class _PatientAddServiceEvaluationsState
    extends State<PatientAddServiceEvaluations> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController descController = TextEditingController();
  List<String> itemss = [];
  List<String> doctorsList = [];
  String? dropdownValue;
  String? dropdownValueDoctors;
  String? clinicID;
  String? doctorID;

  setClinicId(String clinicName) async {
    await firebaseFirestore
        .collection('clinics')
        .where('clinic_name', isEqualTo: clinicName)
        .get()
        .then((value) {
      clinicID = value.docs.first.id;
    });
  }

  setDoctorId(String doctorName) async {
    await firebaseFirestore
        .collection('doctors')
        .where('name', isEqualTo: doctorName)
        .get()
        .then((value) {
      doctorID = value.docs.first.id;
    });
  }

  getClinics() async {
    await firebaseFirestore.collection('clinics').get().then((value) {
      for (var element in value.docs) {
        setState(() {
          itemss.add(element.data()['clinic_name']);
        });
      }
      setState(() {
        dropdownValue = itemss[0];
      });
      setClinicId(dropdownValue!);
      getDoctors(dropdownValue!);
    });
  }

  getDoctors(String cliniName) async {
    await firebaseFirestore
        .collection('doctors')
        .where('clinic', isEqualTo: cliniName)
        .get()
        .then((value) {
      for (var element in value.docs) {
        setState(() {
          doctorsList.add(element.data()['name']);
        });
      }
      setState(() {
        dropdownValueDoctors = doctorsList[0];
      });
      setDoctorId(dropdownValueDoctors!);
    });
  }

  @override
  void initState() {
    super.initState();
    getClinics();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Add Service Evaluation',
                    textAlign: TextAlign.center,
                    style: mainHeaderStyle,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Choose Clinic',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    filled: true,
                    fillColor: mainColor,
                  ),
                  dropdownColor: mainColor,
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      doctorsList.clear();
                      dropdownValue = newValue!;
                    });
                    getDoctors(dropdownValue!);
                  },
                  items: itemss.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Choose Doctor',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    filled: true,
                    fillColor: mainColor,
                  ),
                  dropdownColor: mainColor,
                  value: dropdownValueDoctors,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValueDoctors = newValue!;
                    });
                  },
                  items:
                      doctorsList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Write An Evaluation',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 250,
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: TextField(
                    maxLines: null, // Set this
                    expands: true, // and this
                    keyboardType: TextInputType.multiline,
                    decoration:
                        const InputDecoration(hintText: 'Write here ......'),
                    controller: descController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  elevation: 5,
                  minWidth: 250,
                  color: mainColor,
                  onPressed: () async {
                    await firebaseFirestore.collection('evaluations').add({
                      'patientId': FirebaseAuth.instance.currentUser!.uid,
                      'clinicName': dropdownValue, 
                      'clinicID': clinicID,
                      'doctorName': dropdownValueDoctors,
                      'doctorId': doctorID,
                      'description': descController.text,
                      'read': false,
                      'time': FieldValue.serverTimestamp()
                    });
                    Navigator.pushReplacementNamed(
                        context, '/patient-view-evaluations');
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
