import 'package:dates_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:dates_app/screens/user_appointments/widgets/user_card_upcoming.dart';
class UpcomingScreen extends StatelessWidget {
  const UpcomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: usersUpcoming.length,
          itemBuilder: (context, index) {
            var item = usersUpcoming[index];
            return UserCard(name: item.name, label: item.label, date: item.date, time: item.time);
          }),
    );
  }
}
