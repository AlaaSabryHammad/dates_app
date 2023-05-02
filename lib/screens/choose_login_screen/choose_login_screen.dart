import 'package:flutter/material.dart';
import 'widgets/choose_icon.dart';

class ChooseLoginScreen extends StatelessWidget {
  const ChooseLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 100, left: 30, right: 30, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'images/logo.png',
                    width: width * 0.5,
                    height: width * 0.5,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'TAIBAH CARE',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChooseIcon(
                      label: 'Patient',
                      image: 'images/patient.png',
                      onPressed: () {
                        Navigator.pushNamed(context, '/patient-login');
                      },
                      tag: 'patient',
                    ),
                    ChooseIcon(
                      label: 'doctor',
                      image: 'images/doctor.png',
                      onPressed: () {
                        Navigator.pushNamed(context, '/doctor-login');
                      },
                      tag: 'doctor',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChooseIcon(
                      label: 'pharmacian',
                      image: 'images/pharmacian.png',
                      onPressed: () {
                        Navigator.pushNamed(context, '/pharmacian-login');
                      },
                      tag: 'pharmacian',
                    ),
                    ChooseIcon(
                      label: 'Admin',
                      image: 'images/admin.png',
                      onPressed: () {
                        Navigator.pushNamed(context, '/admin-login');
                      },
                      tag: 'admin',
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
