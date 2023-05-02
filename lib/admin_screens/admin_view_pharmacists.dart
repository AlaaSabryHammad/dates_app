import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/view_screens/view_doctors_screen/doctor_details_screen.dart';

class AdminViewPharmacists extends StatefulWidget {
  const AdminViewPharmacists({super.key});

  @override
  State<AdminViewPharmacists> createState() => _AdminViewPharmacistsState();
}

class _AdminViewPharmacistsState extends State<AdminViewPharmacists> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
          child: Column(
            children: [
              Text(
                'Manage Pharmacists',
                style: TextStyle(
                    color: mainColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: StreamBuilder(
                      stream:
                          firebaseFirestore.collection('doctors').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var item = snapshot.data!.docs[index];
                                return DoctorCard(
                                  clinic: item['clinic'],
                                  email: item['email'],
                                  image: item['sex'] == 'male' ? 'man' : 'girl',
                                  name: item['name'],
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DoctorDetailsScreen(
                                                  ds: item,
                                                )));
                                  },
                                  delete: () {
                                    print('ddddddddddddd');
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (context) => AlertDialog(
                                    //     title: Text(
                                    //       'Delete Patient',
                                    //       style: TextStyle(
                                    //           color: mainColor,
                                    //           fontWeight: FontWeight.bold,
                                    //           fontSize: 18),
                                    //     ),
                                    //     content: Text(
                                    //       'Do tou want to remove the patient?',
                                    //       style: TextStyle(
                                    //           color: textColor,
                                    //           fontSize: 16,
                                    //           fontWeight: FontWeight.bold),
                                    //     ),
                                    //     actions: [
                                    //       MaterialButton(
                                    //         color: mainColor,
                                    //         elevation: 5,
                                    //         onPressed: () {},
                                    //         child: const Text(
                                    //           'Ok',
                                    //           style: TextStyle(
                                    //               color: Colors.white,
                                    //               fontWeight: FontWeight.bold),
                                    //         ),
                                    //       ),
                                    //       MaterialButton(
                                    //         color: Colors.red,
                                    //         elevation: 5,
                                    //         onPressed: () {
                                    //           Navigator.pop(context);
                                    //         },
                                    //         child: const Text(
                                    //           'Cancel',
                                    //           style: TextStyle(
                                    //               color: Colors.white,
                                    //               fontWeight: FontWeight.bold),
                                    //         ),
                                    //       )
                                    //     ],
                                    //   ),
                                    // );
                                  },
                                  update: () {},
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('${snapshot.error}'),
                          );
                        }
                        return const Center(
                          child: Text('There is no doctors'),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.onPressed,
    required this.update,
    required this.delete,
    required this.name,
    required this.email,
    required this.clinic,
    required this.image,
  });
  final VoidCallback onPressed, update, delete;
  final String name, email, clinic, image;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return
        //  GestureDetector(
        //   onTap: onPressed,
        // child:
        Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15),
      height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          customBoxShadow,
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/$image.png',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    email,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
              Text(
                clinic,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    color: mainColor,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                elevation: 5,
                color: mainColor,
                onPressed: () {},
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                elevation: 5,
                color: Colors.red,
                onPressed: () {},
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
      // ),
    );
  }
}
