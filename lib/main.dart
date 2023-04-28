import 'package:dates_app/screens/appointments/patient_appointments/book_patient_appointments.dart';
import 'package:dates_app/screens/choose_login_screen/choose_login_screen.dart';
import 'package:dates_app/screens/home_screen/home_screen.dart';
import 'package:dates_app/screens/home_screen/patient_home_screen/patient_home_screen.dart';
import 'package:dates_app/screens/login_screens/pateint_login/complete_patient_profile_screen.dart';
import 'package:dates_app/screens/login_screens/pateint_login/patient_login_screen.dart';
import 'package:dates_app/screens/login_screens/pateint_login/patient_register_screen.dart';
import 'package:dates_app/screens/splash_screen/splash_screen.dart';
import 'package:dates_app/screens/user_appointments/user_appointments.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/choose-login': (context) => const ChooseLoginScreen(),
        '/patient-login': (context) => const PatientLoginScreen(),
        '/patient-register': (context) => const PatientRegisterScreen(),
        '/complete-patient-profile': (context) =>
            const CompletePatientProfileScreen(),
        '/patient-home': (context) => const PatientHomeScreen(),
        '/book-patient-app': (context) => const BookPatientAppointments(),
        '/home': (context) => const HomeScreen(),
        '/user-appointments': (context) => const UserAppointmentsScreen()
      },
    );
  }
}
