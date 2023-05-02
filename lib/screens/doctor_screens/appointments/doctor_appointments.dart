import 'package:dates_app/constants.dart';
import 'package:flutter/material.dart';

class DoctorAppointments extends StatelessWidget {
  const DoctorAppointments({super.key});

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
                'View Appointments',
                style: TextStyle(
                  color: mainColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView(
              children: [
                PatientAppCard(
                  onPressed: () {},
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class PatientAppCard extends StatelessWidget {
  const PatientAppCard({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 15, right: 5, left: 5),
            width: width - 50,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [customBoxShadow],
                borderRadius: BorderRadius.circular(10)),
            child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alaa Sabry',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '10/10/2020',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '10:00 PM',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    )
                  ],
                )),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: MaterialButton(
              elevation: 5,
              color: mainColor,
              onPressed: () {},
              child: const Text(
                'Show',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
