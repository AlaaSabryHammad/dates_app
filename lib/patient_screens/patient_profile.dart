import 'package:dates_app/constants.dart';
import 'package:flutter/material.dart';

class PatientProfile extends StatelessWidget {
  const PatientProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 70, right: 20, left: 20),
          child: Column(
            children: [
              Container(
                width: 135,
                height: 135,
                decoration:
                    BoxDecoration(color: mainColor, shape: BoxShape.circle),
                child: Center(
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(65),
                        child: Image.asset(
                          'images/girl.png',
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Reem Alaa',
                style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                'reem.alaa@taibahu.edu.sa',
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              Text(
                'Age : 22',
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: 135,
                height: 135,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: mainColor, width: 2, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [customBoxShadow],
                    color: Colors.white),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 50,
                        color: mainColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Update profile Info.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: 135,
                height: 135,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: mainColor, width: 2, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [customBoxShadow],
                    color: Colors.white),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_copy,
                        size: 50,
                        color: mainColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'View Medical File',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: 135,
                height: 135,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: mainColor, width: 2, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [customBoxShadow],
                    color: Colors.white),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock,
                        size: 50,
                        color: mainColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Reset Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
