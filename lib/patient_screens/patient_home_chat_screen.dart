import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/constants.dart';
import 'package:dates_app/patient_screens/patient_chat_screen.dart';
import 'package:flutter/material.dart';

class PatientHomeChatScreen extends StatefulWidget {
  const PatientHomeChatScreen({super.key});

  @override
  State<PatientHomeChatScreen> createState() => _PatientHomeChatScreenState();
}

class _PatientHomeChatScreenState extends State<PatientHomeChatScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            width: width,
            height: 200,
            decoration: BoxDecoration(color: mainColor),
            child: const Center(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Connect to your Doctor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          Expanded(
            child: FutureBuilder(
                future: firebaseFirestore.collection('doctors').get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var item = snapshot.data!.docs[index];
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                            receiverDocument: item)));
                              },
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                    item['sex'] == 'Female'
                                        ? 'images/girl.png'
                                        : 'images/man.png'),
                              ),
                              title: Text(
                                item['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(item['clinic']),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
