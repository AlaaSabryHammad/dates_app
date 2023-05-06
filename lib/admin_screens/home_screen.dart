import 'package:dates_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/appointment_action.dart';
import '../widgets/custom_icon.dart';
import '../widgets/user_action.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 90, left: 30, right: 30, bottom: 30),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Home Page',
                style: TextStyle(
                    color: mainColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Expanded(
                child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIcon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/user-appointments');
                      },
                      label: "Manage Users' Appointments",
                      icon: Icons.book_rounded,
                    ),
                    CustomIcon(
                      onPressed: () {
                        print('object');
                      },
                      label: 'Manage Available Dates',
                      icon: Icons.date_range_rounded,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIcon(
                      onPressed: () {
                        customShowModalSheet(context);
                      },
                      label: 'Manage Patients',
                      icon: Icons.groups_2_rounded,
                    ),
                    CustomIcon(
                      onPressed: () {
                        customShowModalSheetApp(context);
                      },
                      label: "Manage Doctors",
                      icon: Icons.groups_2_rounded,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIcon(
                      onPressed: () {
                        customShowModalSheetPharma(context);
                      },
                      label: 'Manage Pharmacists',
                      icon: Icons.groups_2_rounded,
                    ),
                    CustomIcon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/admin-view-evaluations');
                      },
                      label: "Review Users' Evaluations",
                      icon: Icons.analytics_rounded,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIcon(
                      onPressed: () {
                        // customShowModalSheet(context);
                        Navigator.pushNamed(context, '/add-clinic');
                      },
                      label: 'Manage Clinics',
                      icon: Icons.apartment_rounded,
                    ),
                    CustomIcon(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, '/choose-login');
                      },
                      label: 'Log out',
                      icon: Icons.logout_rounded,
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Future<dynamic> customShowModalSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Manage Patients',
                  style: TextStyle(
                      fontSize: 30,
                      color: mainColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                UserAction(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/admin-add-patient');
                  },
                  label: 'Add Patient',
                  icon: Icons.person_add_alt_1,
                ),
                const SizedBox(
                  height: 30,
                ),
                UserAction(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/admin-view-patients');
                  },
                  label: 'View Patient',
                  icon: Icons.groups_2_rounded,
                ),
                const SizedBox(
                  height: 30,
                ),
                // UserAction(
                //   onPressed: () {},
                //   label: 'Update Patient',
                //   icon: Icons.manage_accounts_rounded,
                // ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> customShowModalSheetPharma(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Manage Pharmacists',
                  style: TextStyle(
                      fontSize: 30,
                      color: mainColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                UserAction(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/admin-add-pharmacian');
                  },
                  label: 'Add Pharmacist',
                  icon: Icons.person_add_alt_1,
                ),
                const SizedBox(
                  height: 30,
                ),
                UserAction(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/admin-view-pharmacists');
                  },
                  label: 'View Pharmacists',
                  icon: Icons.groups_2_rounded,
                ),
                const SizedBox(
                  height: 30,
                ),
                // UserAction(
                //   onPressed: () {},
                //   label: 'Update Patient',
                //   icon: Icons.manage_accounts_rounded,
                // ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> customShowModalSheetApp(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Manage Doctors',
                  style: TextStyle(
                      fontSize: 30,
                      color: mainColor,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                AppointmentAction(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/add-doctor');
                  },
                  label: 'Add a new doctor',
                  icon: Icons.person_add_alt_1,
                ),
                const SizedBox(
                  height: 30,
                ),
                AppointmentAction(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/view-doctors');
                  },
                  label: 'View doctors',
                  icon: Icons.groups_2_rounded,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        });
  }
}
