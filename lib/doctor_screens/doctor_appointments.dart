import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/constants.dart';
import 'package:dates_app/doctor_screens/doctor_add_prescription.dart';
import 'package:dates_app/doctor_screens/doctor_record_test.dart';
import 'package:dates_app/doctor_screens/doctor_refer.dart';
import 'package:dates_app/doctor_screens/doctor_show_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class DoctorAppointments extends StatefulWidget {
  const DoctorAppointments({super.key});

  @override
  State<DoctorAppointments> createState() => _DoctorAppointmentsState();
}

class _DoctorAppointmentsState extends State<DoctorAppointments> {
  bool? isCompleted;
  PageController pageController = PageController(initialPage: 0);
  List<Widget> appScreens = [const UpcommingWidget(), const CompletedWidget()];
  int selectedIndex = 0;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                      pageController.animateToPage(0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.linear);
                    },
                    child: Text(
                      'Upcomming',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color:
                              selectedIndex == 0 ? Colors.blue : Colors.grey),
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                      pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.linear);
                    },
                    child: Text(
                      'Completed',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color:
                              selectedIndex == 1 ? Colors.blue : Colors.grey),
                    )),
              ],
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  selectedIndex = value;
                },
                children: appScreens,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // getPatientDocument(
  //     Future<DocumentSnapshot<Map<String, dynamic>>> document) async {
  //   var resultDocument = await document;
  //   return resultDocument;
  // }
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

class UpcommingWidget extends StatelessWidget {
  const UpcommingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder(
        stream: firebaseFirestore
            .collection('bookings')
            .where('doctorID',
                // isEqualTo: 'IDqVgFlIhFZJRohBu5AtPEyhpS83')
                isEqualTo: firebaseAuth.currentUser!.uid)
            .where('status', isEqualTo: 'active')
            .orderBy('startTime', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var item = snapshot.data!.docs[index];
                  DateTime date = item['startTime'].toDate();
                  print(item);
                  print('************');
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
                              border: Border.all(
                                  color: mainColor,
                                  width: 1,
                                  style: BorderStyle.solid),
                              color: Colors.white,
                              boxShadow: [customBoxShadow],
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${date.day}/${date.month}/${date.year}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${date.hour}:${date.minute}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
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
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        'Not Refered',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                  // MaterialButton(
                                  //   minWidth: 120,
                                  //   color: mainColor,
                                  //   elevation: 5,
                                  //   onPressed: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             DoctorRecordTestScreen(
                                  //           item: item,
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  //   child: const Text(
                                  //     'Record Test',
                                  //     style: TextStyle(color: Colors.white),
                                  //   ),
                                  // ),
                                  // MaterialButton(
                                  //   minWidth: 120,
                                  //   color: mainColor,
                                  //   elevation: 5,
                                  //   onPressed: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             DoctorAddPrescription(
                                  //           item: item,
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  //   child: const Text(
                                  //     'Prescription',
                                  //     style: TextStyle(color: Colors.white),
                                  //   ),
                                  // ),
                                  MaterialButton(
                                    minWidth: 120,
                                    color: mainColor,
                                    elevation: 5,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorShowApp(item: item),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Show',
                                      style: TextStyle(color: Colors.white),
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
        });
  }
}

class CompletedWidget extends StatelessWidget {
  const CompletedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder(
        stream: firebaseFirestore
            .collection('bookings')
            .where('doctorID', isEqualTo: firebaseAuth.currentUser!.uid)
            .where('status', isEqualTo: 'completed')
            .orderBy('startTime', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var item = snapshot.data!.docs[index];
                  DateTime date = item['startTime'].toDate();
                  print(item);
                  print('************');
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
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${date.day}/${date.month}/${date.year}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${date.hour}:${date.minute}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
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
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        'Not Refered',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                      style: TextStyle(color: Colors.white),
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
                                      style: TextStyle(color: Colors.white),
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
                                                  DoctorRefer(item: item)));
                                    },
                                    child: const Text(
                                      'Refer',
                                      style: TextStyle(color: Colors.white),
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
        });
  }
}
