import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dates_app/screens/user_appointments/widgets/user_card_upcoming.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<UserCard> upcomingDates = [];
  getUpcomingDates() async {
    await firebaseFirestore
        .collection('bookings')
        .where('status', isEqualTo: 'active')
        .get()
        .then((value) {
      for (var item in value.docs) {
        DateTime dateTime = item['startTime'].toDate();
        String date = '$dateTime';
        setState(() {
          upcomingDates.add(UserCard(
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
    getUpcomingDates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: upcomingDates.length,
          itemBuilder: (context, index) {
            var item = upcomingDates[index];
            return item;
          }),
    );
  }
}
