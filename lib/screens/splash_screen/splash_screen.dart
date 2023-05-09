import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  saveAdmin() async {
    await FirebaseFirestore.instance
        .collection('admins')
        .where('email', isEqualTo: 'admin@taibahu.edu.sa')
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        FirebaseApp app = await Firebase.initializeApp(
            name: 'Secondary', options: Firebase.app().options);
        try {
          UserCredential userCredential =
              await FirebaseAuth.instanceFor(app: app)
                  .createUserWithEmailAndPassword(
                      email: 'admin@taibahu.edu.sa', password: '123456789');
          await firebaseFirestore
              .collection('admins')
              .doc(userCredential.user!.uid)
              .set({
            'email': 'admin@taibahu.edu.sa',
            'password': '123456789',
            'type': 'admin'
          });
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, '/choose-login');
          });
        } on FirebaseAuthException {
          // Do something with exception. This try/catch is here to make sure
          // that even if the user creation fails, app.delete() runs, if is not,
          // next time Firebase.initializeApp() will fail as the previous one was
          // not deleted.
        }
        await app.delete();
      }

      //
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/choose-login');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    saveAdmin();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(1, 1), blurRadius: 5)
              ]),
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  'images/logo.png',
                  width: width * 0.4,
                  height: width * 0.4,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'TAIBAH CARE',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
