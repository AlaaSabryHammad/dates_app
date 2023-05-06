import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/constants.dart';
import 'package:dates_app/doctor_screens/doctor_add_prescription.dart';
import 'package:dates_app/doctor_screens/doctor_record_test.dart';
import 'package:flutter/material.dart';

class DoctorAppointments extends StatefulWidget {
  const DoctorAppointments({super.key});

  @override
  State<DoctorAppointments> createState() => _DoctorAppointmentsState();
}

class _DoctorAppointmentsState extends State<DoctorAppointments> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool? isCompleted;
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
                'View Appointments',
                style: TextStyle(
                  color: mainColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: StreamBuilder(
                    stream: firebaseFirestore
                        .collection('bookings')
                        .orderBy('startTime', descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var item = snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () {},
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.only(
                                          bottom: 15, right: 5, left: 5),
                                      width: width - 50,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [customBoxShadow],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item['patientName'],
                                                    style: TextStyle(
                                                        color: textColor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text(
                                                    '10/10/2020',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text(
                                                    '10:00 PM',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    'Waiting ....',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    'Not Refered',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  // Checkbox(
                                                  //     value: isCompleted,
                                                  //     onChanged: (value) {})
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              MaterialButton(
                                                minWidth: 120,
                                                color: mainColor,
                                                elevation: 5,
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DoctorRecordTestScreen(
                                                        item: item,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  'Record Test',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              MaterialButton(
                                                minWidth: 120,
                                                color: mainColor,
                                                elevation: 5,
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DoctorAddPrescription(
                                                        item: item,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  'Prescription',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              MaterialButton(
                                                minWidth: 120,
                                                color: mainColor,
                                                elevation: 5,
                                                onPressed: () {},
                                                child: const Text(
                                                  'Refer',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    })),
          ],
        ),
      ),
    );
  }

  getPatientDocument(
      Future<DocumentSnapshot<Map<String, dynamic>>> document) async {
    var resultDocument = await document;
    return resultDocument;
  }
}

// class PatientAppCard extends StatelessWidget {
//   const PatientAppCard({
//     super.key,
//     required this.onPressed,
//     required this.isCompleted,
//     required this.onChanged,
//   });
//   final VoidCallback onPressed;
//   final bool isCompleted;
//   final Function onChanged;

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: onPressed,
//       child: Stack(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(20),
//             margin: const EdgeInsets.only(bottom: 15, right: 5, left: 5),
//             width: width - 50,
//             height: 200,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [customBoxShadow],
//                 borderRadius: BorderRadius.circular(10)),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Alaa Sabry',
//                           style: TextStyle(
//                               color: textColor,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const Text(
//                           '10/10/2020',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, color: Colors.blue),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const Text(
//                           '10:00 PM',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, color: Colors.blue),
//                         )
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Waiting ....',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, color: Colors.grey),
//                         ),
//                         const Text(
//                           'Not Refered',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         // CheckboxListTile(value: value, onChanged: onChanged)
//                         Checkbox(
//                             value: isCompleted,
//                             onChanged: (value) => onChanged(value))
//                       ],
//                     )
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     MaterialButton(
//                       minWidth: 120,
//                       color: mainColor,
//                       elevation: 5,
//                       onPressed: () {},
//                       child: const Text(
//                         'Test',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     MaterialButton(
//                       minWidth: 120,
//                       color: mainColor,
//                       elevation: 5,
//                       onPressed: () {},
//                       child: const Text(
//                         'Prescription',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     MaterialButton(
//                       minWidth: 120,
//                       color: mainColor,
//                       elevation: 5,
//                       onPressed: () {},
//                       child: const Text(
//                         'Refer',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
