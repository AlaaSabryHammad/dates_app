import 'package:dates_app/constants.dart';
import 'package:dates_app/screens/home_screen/widgets/custom_icon.dart';
import 'package:dates_app/screens/home_screen/widgets/user_action.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 90, left: 30, right: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Home Page',
              style: TextStyle(
                  color: mainColor, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 60,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIcon(
                        onPressed: () {
                          customShowModalSheet(context);
                        },
                        label: 'Manage Users',
                        icon: Icons.groups_2_rounded,
                      ),
                      CustomIcon(
                        onPressed: () {
                          print('object');
                        },
                        label: "Review Users' Evaluations",
                        icon: Icons.analytics_rounded,
                      ),
                    ],
                  ),
                  CustomIcon(
                    onPressed: () {
                      print('object');
                    },
                    label: 'Log out',
                    icon: Icons.logout_rounded,
                  ),
                ],
              ),
            ),
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
              children: [
                Text(
                  'Manage Users',
                  style: TextStyle(
                      fontSize: 30,
                      color: mainColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                UserAction(
                  onPressed: () {},
                  label: 'Add User',
                  icon: Icons.person_add_alt_1,
                ),
                const SizedBox(
                  height: 30,
                ),
                UserAction(
                  onPressed: () {},
                  label: 'Delete User',
                  icon: Icons.person_remove_alt_1_rounded,
                ),
                const SizedBox(
                  height: 30,
                ),
                UserAction(
                  onPressed: () {},
                  label: 'Update User',
                  icon: Icons.manage_accounts_rounded,
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
