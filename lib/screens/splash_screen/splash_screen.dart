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
  // createAdminAccount() async {
  //   try {
  //     final credential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: 'admin@taibahu.edu.sa',
  //       password: '123456789',
  //     );
  //     await firebaseFirestore
  //         .collection('admins')
  //         .doc(credential.user!.uid)
  //         .set({
  //       'email': 'admin@taibahu.edu.sa',
  //       'password': '123456789',
  //       'type': 'admin'
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // checkIfAdminFound() async {
  //   try {
  //     final credential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: 'admin@taibahu.edu.sa',
  //       password: '123456789',
  //     );
  //     await firebaseFirestore
  //         .collection('admins')
  //         .doc(credential.user!.uid)
  //         .set({
  //       'email': 'admin@taibahu.edu.sa',
  //       'password': '123456789',
  //       'type': 'admin'
  //     });
  //     Future.delayed(const Duration(seconds: 3), () {
  //       Navigator.pushReplacementNamed(context, '/choose-login');
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       delay();
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // delay() async {
  //   Future.delayed(const Duration(seconds: 3), () async {
  //     if (user != null) {
  //       DocumentSnapshot dsPatient = await FirebaseFirestore.instance
  //           .collection('patients')
  //           .doc(user!.uid)
  //           .get();
  //       DocumentSnapshot dsAdmin = await FirebaseFirestore.instance
  //           .collection('admins')
  //           .doc(user!.uid)
  //           .get();
  //       DocumentSnapshot dsDoctor = await FirebaseFirestore.instance
  //           .collection('doctors')
  //           .doc(user!.uid)
  //           .get();
  //       if (dsPatient.exists) {
  //         Navigator.pushReplacementNamed(context, '/patient-home');
  //       } else if (dsAdmin.exists) {
  //         // print('Adminnnnnnnnnnn');
  //         Navigator.pushReplacementNamed(context, '/home');
  //       } else if (dsDoctor.exists) {
  //         print('doctorrrrrrrrrrr');
  //       } else {
  //         FirebaseAuth.instance.signOut();
  //         Navigator.pushReplacementNamed(context, '/choose-login');
  //         // Navigator.pushReplacementNamed(context, '/complete-patient-profile');
  //       }
  //     } else {
  //       try {
  //         final credential =
  //             await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //           email: 'admin@taibahu.edu.sa',
  //           password: '123456789',
  //         );
  //         await firebaseFirestore
  //             .collection('admins')
  //             .doc(credential.user!.uid)
  //             .set({
  //           'email': 'admin@taibahu.edu.sa',
  //           'password': '123456789',
  //           'type': 'admin'
  //         });
  //         Navigator.pushReplacementNamed(context, '/choose-login');
  //       } on FirebaseAuthException catch (e) {
  //         if (e.code == 'weak-password') {
  //           print('The password provided is too weak.');
  //         } else if (e.code == 'email-already-in-use') {
  //           print('The account already exists for that email.');
  //         }
  //       } catch (e) {
  //         print(e);
  //       }
  //       // Navigator.pushReplacementNamed(context, '/choose-login');
  //     }
  //   });
  // }

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
    // createAdminAccount();
    // checkUser();
    // Future.delayed(const Duration(seconds: 2), () {
    //   Navigator.pushReplacementNamed(context, '/choose-login');
    // });
    saveAdmin();
  }

  // checkUser() async {
  //   Future.delayed(const Duration(seconds: 3), () async {
  //     if (user != null) {
  //       if (user!.email == 'admin@taibahu.edu.sa') {
  //         Navigator.pushReplacementNamed(context, '/choose-login');
  //       } else {
  //         DocumentSnapshot dsPatient = await FirebaseFirestore.instance
  //             .collection('patients')
  //             .doc(user!.uid)
  //             .get();
  //         DocumentSnapshot dsDoctor = await FirebaseFirestore.instance
  //             .collection('doctors')
  //             .doc(user!.uid)
  //             .get();
  //         if (dsPatient.exists) {
  //           Navigator.pushReplacementNamed(context, '/patient-home');
  //         } else if (dsDoctor.exists) {
  //           FirebaseAuth.instance.signOut;
  //           print('doctorrrrryyyyy');
  //           Navigator.pushReplacementNamed(context, '/choose-login');
  //         }
  //       }
  //     } else {
  //       Navigator.pushReplacementNamed(context, '/choose-login');
  //     }
  //   });
  // }

//    register(String email, String password) async {
//     FirebaseApp app = await FirebaseApp.configure(
//         name: 'Secondary', options: await FirebaseApp.instance.options);
//     return FirebaseAuth.fromApp(app)
//         .createUserWithEmailAndPassword(email: email, password: password);
// }
//////////////////
  // register(String email, String password) async {
  //   FirebaseApp app = await Firebase.initializeApp(
  //       name: 'Secondary', options: Firebase.app().options);
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException {
  //     // Do something with exception. This try/catch is here to make sure
  //     // that even if the user creation fails, app.delete() runs, if is not,
  //     // next time Firebase.initializeApp() will fail as the previous one was
  //     // not deleted.
  //   }

  //   await app.delete();
  //   // return Future.sync(() => userCredential);
  // }
  ////////////////////

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
