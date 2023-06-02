import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/admin_screens/admin_update_patient.dart';
import 'package:dates_app/constants.dart';
import 'package:dates_app/screens/view_screens/view_doctors_screen/doctor_details_screen.dart';
import 'package:flutter/material.dart';

class ViewDoctorsScreen extends StatefulWidget {
  const ViewDoctorsScreen({super.key});

  @override
  State<ViewDoctorsScreen> createState() => _ViewDoctorsScreenState();
}

class _ViewDoctorsScreenState extends State<ViewDoctorsScreen> {
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
                'Manage Doctors',
                style: TextStyle(
                    color: mainColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: firebaseFirestore.collection('doctors').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text(
                              'no Doctors',
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var item = snapshot.data!.docs[index];
                              if (snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No Doctors',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: textColor),
                                  ),
                                );
                              } else {
                                return DoctorCard(
                                  clinic: item['clinic'],
                                  email: item['email'],
                                  image: item['sex'] == 'male' ? 'man' : 'girl',
                                  name: item['name'],
                                  delete: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(
                                          'Delete Doctor',
                                          style: TextStyle(
                                              color: mainColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        content: Text(
                                          'Do tou want to remove the doctor?',
                                          style: TextStyle(
                                              color: textColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        actions: [
                                          MaterialButton(
                                            color: mainColor,
                                            elevation: 5,
                                            onPressed: () async {
                                              await firebaseFirestore
                                                  .collection('doctors')
                                                  .doc(item.id)
                                                  .delete();
                                              firebaseAuth.signOut();
                                              final credential =
                                                  await firebaseAuth
                                                      .signInWithEmailAndPassword(
                                                          email:
                                                              item.get('email'),
                                                          password: item
                                                              .get('password'));
                                              await credential.user!.delete();
                                              await firebaseAuth
                                                  .signInWithEmailAndPassword(
                                                      email:
                                                          'admin@taibahu.edu.sa',
                                                      password: '123456789');
                                              Navigator.pop(context);
                                              var snackBar = const SnackBar(
                                                  content: Text(
                                                      'Deleted Successfully ...'));
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            },
                                            child: const Text(
                                              'Ok',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          MaterialButton(
                                            color: Colors.red,
                                            elevation: 5,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  update: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorDetailsScreen(
                                          ds: item,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            });
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      }
                      return const Center(
                        child: Text('There is no doctors'),
                      );
                    }),
              ),
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
    required this.update,
    required this.delete,
    required this.name,
    required this.email,
    required this.clinic,
    required this.image,
  });
  final VoidCallback update, delete;
  final String name, email, clinic, image;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15),
      height: 150,
      decoration: BoxDecoration(
        border:
            Border.all(color: mainColor, width: 1, style: BorderStyle.solid),
        boxShadow: [
          customBoxShadow,
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.6,
            child: Column(
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
          ),
          SizedBox(
            width: 0.2 * width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  elevation: 5,
                  color: mainColor,
                  onPressed: update,
                  child: const Text(
                    'View',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                MaterialButton(
                  elevation: 5,
                  color: Colors.red,
                  onPressed: delete,
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
