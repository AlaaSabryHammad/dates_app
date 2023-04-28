import 'package:dates_app/models/user_model.dart';
import 'package:dates_app/screens/user_appointments/widgets/user_card_completed.dart';
import 'package:flutter/material.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: usersCompleted.length,
          itemBuilder: (context, index) {
            var item = usersCompleted[index];
            return UserCardCompleted(name: item.name, label: item.label, date: item.date, time: item.time);
          }),
    );
  }
}