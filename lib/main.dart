import 'package:dates_app/admin_screens/admin_add_patient.dart';
import 'package:dates_app/admin_screens/admin_add_pharmacian.dart';
import 'package:dates_app/admin_screens/admin_view_patients.dart';
import 'package:dates_app/admin_screens/admin_view_pharmacists.dart';
import 'package:dates_app/admin_screens/admin_view_user_evaluations.dart';
import 'package:dates_app/admin_screens/success/admin_add_doctor_success.dart';
import 'package:dates_app/patient_screens/patient_add_service_evaluation.dart';
import 'package:dates_app/patient_screens/patient_home_chat_screen.dart';
import 'package:dates_app/patient_screens/patient_profile.dart';
import 'package:dates_app/patient_screens/patient_view_service_evaluations.dart';
import 'package:dates_app/admin_screens/admin_add_doctor_screen.dart';
import 'package:dates_app/pharmacist_screens/pharmacist_login.dart';
import 'package:dates_app/screens/choose_login_screen.dart';
import 'package:dates_app/doctor_screens/doctor_appointments.dart';
import 'package:dates_app/doctor_screens/doctor_home_screen.dart';
import 'package:dates_app/admin_screens/home_screen.dart';
import 'package:dates_app/patient_screens/patient_home_screen.dart';
import 'package:dates_app/admin_screens/admin_login.dart';
import 'package:dates_app/doctor_screens/doctor_login_screen.dart';
import 'package:dates_app/screens/splash_screen/splash_screen.dart';
import 'package:dates_app/screens/user_appointments/user_appointments.dart';
import 'package:dates_app/admin_screens/admin_view_doctors_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'admin_screens/admin_add_clinic_screen.dart';
import 'patient_screens/book_patient_appointments.dart';
import 'patient_screens/patient_login_screen.dart';
import 'patient_screens/patient_register_screen.dart';
import 'patient_screens/patient_view_prescription.dart';
import 'patient_screens/view_pateint_appointments_screen.dart';

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
        '/patient-add-evaluation': (context) =>
            const PatientAddServiceEvaluations(),
        '/patient-view-evaluations': (context) =>
            const PatientViewServiceEvaluations(),
        '/patient-home-chat': (context) => const PatientHomeChatScreen(),
        '/patient-view-prescription': (context) =>
            const PatientViewDescriptions(),
        '/patient-home': (context) => const PatientHomeScreen(),
        '/patient-profile': (context) => const PatientProfile(),
        '/book-patient-app': (context) => const BookPatientAppointments(),
        '/view-patient-app': (context) => const ViewPatientAppointments(),
        '/home': (context) => const HomeScreen(),
        '/admin-login': (context) => const AdminLoginScreen(),
        '/admin-add-patient': (context) => const AdminAddPatient(),
        '/admin-view-patients': (context) => const AdminViewPatients(),
        '/admin-view-evaluations': (context) =>
            const AdminViewUserEvaluations(),
        '/admin-add-doctor-success': (context) => const AdminAddDoctorSuccess(),
        // '/admin-view-evaluation-details': (context) =>
        //     const AdminViewEvaluationDetails(),
        '/admin-add-pharmacian': (context) => const AdminAddPharmacian(),
        '/admin-view-pharmacists': (context) => const AdminViewPharmacists(),
        '/user-appointments': (context) => const UserAppointmentsScreen(),
        '/add-doctor': (context) => const AddDoctorScreen(),
        '/view-doctors': (context) => const ViewDoctorsScreen(),
        '/add-clinic': (context) => const AddClinicScreen(),
        '/doctor-login': (context) => const DoctorLoginScreen(),
        '/doctor-home': (context) => const DoctorHomeScreen(),
        '/doctor-app': (context) => const DoctorAppointments(),
        '/pharmacian-login': (context) => const PharmacistLogin(),
      },
    );
  }
}
