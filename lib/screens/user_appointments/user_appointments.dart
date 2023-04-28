import 'package:dates_app/constants.dart';
import 'package:dates_app/screens/user_appointments/screens_data.dart';
import 'package:flutter/material.dart';

class UserAppointmentsScreen extends StatefulWidget {
  const UserAppointmentsScreen({super.key});

  @override
  State<UserAppointmentsScreen> createState() => _UserAppointmentsScreenState();
}

class _UserAppointmentsScreenState extends State<UserAppointmentsScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                CustomSelector(
                  label: 'Upcoming',
                  selectedWidth: selectedIndex == 0 ? 2 : 1,
                  selectedColor: selectedIndex == 0 ? mainColor : Colors.grey,
                  labelColor: selectedIndex == 0 ? mainColor : Colors.grey,
                ),
                CustomSelector(
                  label: 'Completed',
                  selectedWidth: selectedIndex == 1 ? 2 : 1,
                  selectedColor: selectedIndex == 1 ? mainColor : Colors.grey,
                  labelColor: selectedIndex == 1 ? mainColor : Colors.grey,
                ),
                CustomSelector(
                  label: 'Cancelled',
                  selectedWidth: selectedIndex == 2 ? 2 : 1,
                  selectedColor: selectedIndex == 2 ? mainColor : Colors.grey,
                  labelColor: selectedIndex == 2 ? mainColor : Colors.grey,
                ),
              ],
            ),
            Expanded(
              child: PageView(
                children: screens,
                onPageChanged: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSelector extends StatelessWidget {
  const CustomSelector({
    super.key,
    required this.label,
    required this.selectedWidth,
    required this.selectedColor,
    required this.labelColor,
  });
  final String label;
  final double selectedWidth;
  final Color selectedColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: (width - 40) / 3,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: selectedColor,
              width: selectedWidth,
              style: BorderStyle.solid),
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
