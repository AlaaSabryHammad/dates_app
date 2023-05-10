import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/screens/user_appointments/widgets/user_card_completed.dart';
import 'package:flutter/material.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<UserCardCompleted> completedDates = [];

  getCompletedDates() async {
    await firebaseFirestore
        .collection('bookings')
        .where('status', isEqualTo: 'completed')
        .get()
        .then((value) {
      for (var item in value.docs) {
        DateTime dateTime = item['startTime'].toDate();
        String date = '$dateTime';
        setState(() {
          completedDates.add(UserCardCompleted(
              name: item['patientName'],
              label: item['clinic'],
              date: item['doctor'],
              time: date));
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCompletedDates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: completedDates.length,
          itemBuilder: (context, index) {
            var item = completedDates[index];
            return item;
          }),
    );
  }
}
