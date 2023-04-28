import 'package:dates_app/models/user_model.dart';
import 'package:dates_app/screens/user_appointments/widgets/user_card_cancelled.dart';
import 'package:flutter/material.dart';

class CancelledScreen extends StatelessWidget {
  const CancelledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: usersCancelled.length,
          itemBuilder: (context, index) {
            var item = usersCancelled[index];
            return UserCardCancelled(
                name: item.name,
                label: item.label,
                date: item.date,
                time: item.time);
          }),
    );
  }
}
