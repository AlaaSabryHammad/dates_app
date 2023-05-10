import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/constants.dart';
import 'package:flutter/material.dart';

import 'admin_view_evaluation_details.dart';

class AdminViewUserEvaluations extends StatefulWidget {
  const AdminViewUserEvaluations({super.key});

  @override
  State<AdminViewUserEvaluations> createState() =>
      _AdminViewUserEvaluationsState();
}

class _AdminViewUserEvaluationsState extends State<AdminViewUserEvaluations> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Review Users' Evaluations",
                textAlign: TextAlign.center,
                style: mainHeaderStyle,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                  stream:
                      firebaseFirestore.collection('evaluations').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var item = snapshot.data!.docs[index];
                            DateTime dateTime = item['time'].toDate();
                            String name = '';
                            // firebaseFirestore
                            //     .collection('patients')
                            //     .doc(item['patientId'])
                            //     .get()
                            //     .then((value) {
                            //   setState(() {
                            //     name = value.get('fname');
                            //   });
                            //   print(value.get('fname'));
                            //   print('*********');
                            // });

                            return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminViewEvaluationDetails())),
                              child: UserEvaluationCard(
                                  status: item['read'] ? 'read' : 'new',
                                  date: "${dateTime.day}",
                                  day: "${dateTime.day}",
                                  name: name),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class UserEvaluationCard extends StatelessWidget {
  const UserEvaluationCard({
    super.key,
    required this.status,
    required this.date,
    required this.day,
    required this.name,
  });
  final String status, date, day, name;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      width: width - 40,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [customBoxShadow],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: mainColor, borderRadius: BorderRadius.circular(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Text(day,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22))
                  ],
                ),
              ),
              Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    status,
                    style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recordes Added',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Recorded by $name',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: mainColor),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '1 Evaluation',
                style: TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }
}
