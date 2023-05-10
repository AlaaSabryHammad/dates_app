import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/screens/user_appointments/widgets/user_card_cancelled.dart';
import 'package:flutter/material.dart';

class CancelledScreen extends StatefulWidget {
  const CancelledScreen({super.key});

  @override
  State<CancelledScreen> createState() => _CancelledScreenState();
}

class _CancelledScreenState extends State<CancelledScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<UserCardCancelled> canceledDates = [];

  getCanceledDates() async {
    await firebaseFirestore
        .collection('bookings')
        .where('status', isEqualTo: 'canceled')
        .get()
        .then((value) {
      for (var item in value.docs) {
        DateTime dateTime = item['startTime'].toDate();
        String date = '$dateTime';
        setState(() {
          canceledDates.add(UserCardCancelled(
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
    getCanceledDates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: canceledDates.length,
          itemBuilder: (context, index) {
            var item = canceledDates[index];
            return item;
          }),
    );
  }
}
