import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/constants.dart';
import 'package:dates_app/doctor_screens/refer_screens/refer_select_clinic.dart';
import 'package:flutter/material.dart';
import 'doctor_add_prescription.dart';
import 'doctor_record_test.dart';

class DoctorShowApp extends StatefulWidget {
  const DoctorShowApp({super.key, required this.item});
  final QueryDocumentSnapshot item;

  @override
  State<DoctorShowApp> createState() => _DoctorShowAppState();
}

class _DoctorShowAppState extends State<DoctorShowApp> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController diagController = TextEditingController();
  String? patientName, patientEmail, patientId, patientAge;
  setPatientData() async {
    await firebaseFirestore
        .collection('patients')
        .doc(widget.item['patientId'])
        .get()
        .then((value) {
      setState(() {
        patientName = value.get('fname');
        patientEmail = value.get('email');
        patientId = value.get('nationalid');
        patientAge = value.get('age');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setPatientData();
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: mainColor,
        body: Column(
          children: [
            SizedBox(
              width: width,
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      patientName ?? '',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Text(
                      patientEmail ?? '',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      'ID: $patientId',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      'Age: $patientAge',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MaterialButton(
                            elevation: 10,
                            color: textColor,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorAddPrescription(
                                    item: widget.item,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Add Prescription',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 100,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: StreamBuilder(
                                stream: firebaseFirestore
                                    .collection('bookings')
                                    .doc(widget.item.id)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data!['prescription'] ==
                                        null) {
                                      return const Center(
                                          child: Text('no prescription'));
                                    } else {
                                      List dataList =
                                          snapshot.data!['prescription'];
                                      return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: dataList.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [customBoxShadow],
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        mainColor,
                                                        Colors.white,
                                                        mainColor
                                                      ]),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        dataList[index]['item'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        '${dataList[index]['count']}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                          });
                                    }
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            elevation: 10,
                            color: textColor,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorRecordTestScreen(
                                    item: widget.item,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Add Test Result',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 100,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: StreamBuilder(
                                stream: firebaseFirestore
                                    .collection('bookings')
                                    .doc(widget.item.id)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data!['tests'] == null) {
                                      return const Center(
                                          child: Text('no Tests'));
                                    } else {
                                      List xx = snapshot.data!['tests'];
                                      List dataList = [];
                                      for (var element in xx) {
                                        if (element['result'] != '') {
                                          dataList.add(element);
                                        }
                                      }
                                      return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: dataList.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [customBoxShadow],
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        mainColor,
                                                        Colors.white,
                                                        mainColor
                                                      ]),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        dataList[index]
                                                            ['testName'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        '${dataList[index]['result']}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                          });
                                    }
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            elevation: 10,
                            color: textColor,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReferSelectClinic(
                                    patientId: patientId!,
                                    patientName: patientName!,
                                    oldApp: widget.item,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Refer',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Patient Diagnosis',
                            style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 250,
                            child: TextField(
                              maxLines: null, // Set this
                              expands: true, // and this
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                  hintText: 'Write here ......',
                                  border: OutlineInputBorder()),
                              controller: diagController,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CheckboxListTile(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                              firebaseFirestore
                                  .collection('bookings')
                                  .doc(widget.item.id)
                                  .update({'finished': isChecked});
                            },
                            title: Text(
                              'Check if finished',
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Patient Medical File',
                            style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            elevation: 10,
                            color: mainColor,
                            onPressed: () {
                              firebaseFirestore
                                  .collection('bookings')
                                  .doc(widget.item.id)
                                  .update({
                                'patientDiagnosis': diagController.text,
                                'status': 'completed',
                                'isWaiting': false
                              });

                              Navigator.pushReplacementNamed(
                                  context, '/doctor-app');
                            },
                            child: const Text(
                              'Finish',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
