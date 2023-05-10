import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/choose_icon.dart';



class ChooseLoginScreen extends StatelessWidget {
  const ChooseLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'images/back.png',
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.3)),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'images/logo.png',
                        width: width * 0.3,
                        height: width * 0.3,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'TAIBAH CARE',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
        ],
      ),
    );
  }
}
