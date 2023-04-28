import 'package:dates_app/screens/login_screens/pateint_login/complete_patient_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../widgets/custom_textfield.dart';

class PatientRegisterScreen extends StatefulWidget {
  const PatientRegisterScreen({super.key});

  @override
  State<PatientRegisterScreen> createState() => _PatientRegisterScreenState();
}

class _PatientRegisterScreenState extends State<PatientRegisterScreen> {
  String? emailAddress;
  String? password;
  String? confirm;
  registerNewPatient() async {
    if (password == confirm) {
      try {
        UserCredential credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress!,
          password: password!,
        );
        print('************');
        print(credential.user);
        print('************');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          const snackBar = SnackBar(
            content: Text('The password provided is too weak.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (e.code == 'email-already-in-use') {
          const snackBar = SnackBar(
            content: Text('The account already exists for that email.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        print(e);
      }
    } else {
      const snackBar = SnackBar(
        content: Text('passwords are not the same ...'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'images/patient.png',
                  width: width * 0.4,
                  height: width * 0.4,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Patient Sign Up',
                    style: TextStyle(
                        color: textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Register New Account ...... !',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  hint: 'Enter your email address .....',
                  icon: Icons.email,
                  label: 'Email Adress',
                  onPressed: (value) {
                    emailAddress = value;
                  },
                  isSecured: false,
                ),
                CustomTextField(
                  hint: 'Enter your password .....',
                  icon: Icons.lock,
                  label: 'Password',
                  onPressed: (value) {
                    password = value;
                  },
                  isSecured: true,
                ),
                CustomTextField(
                  hint: 'Confirm your password .....',
                  icon: Icons.lock,
                  label: 'Confirm Password',
                  onPressed: (value) {
                    confirm = value;
                  },
                  isSecured: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  elevation: 5,
                  onPressed: () {
                    registerNewPatient();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CompletePatientProfileScreen(),
                      ),
                    );
                  },
                  color: mainColor,
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, letterSpacing: 1.1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
