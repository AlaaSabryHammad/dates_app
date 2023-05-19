import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../constants.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class PharmacistPrescriptionSearch extends StatefulWidget {
  const PharmacistPrescriptionSearch({super.key});

  @override
  State<PharmacistPrescriptionSearch> createState() =>
      _PharmacistPrescriptionSearchState();
}

class _PharmacistPrescriptionSearchState
    extends State<PharmacistPrescriptionSearch> {
  bool? isCompleted;
  PageController pageController = PageController(initialPage: 0);
  List<Widget> appScreens = [const PrescriptionSearch(), const PatientSearch()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'View Prescriptions',
                style: TextStyle(
                  color: mainColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                      pageController.animateToPage(0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.linear);
                    },
                    child: Text(
                      'Prescriptions',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color:
                              selectedIndex == 0 ? Colors.blue : Colors.grey),
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                      pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.linear);
                    },
                    child: Text(
                      'Patients',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color:
                              selectedIndex == 1 ? Colors.blue : Colors.grey),
                    )),
              ],
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  selectedIndex = value;
                },
                children: appScreens,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrescriptionSearch extends StatefulWidget {
  const PrescriptionSearch({super.key});

  @override
  State<PrescriptionSearch> createState() => _PrescriptionSearchState();
}

class _PrescriptionSearchState extends State<PrescriptionSearch> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: '',
              border: OutlineInputBorder(),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: firebaseFirestore
                  .collection('bookings')
                  .where('prescription', isNotEqualTo: null)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var item = snapshot.data!.docs[index];
                        return Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(10),
                              width: width - 50,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: mainColor,
                                      width: 2,
                                      style: BorderStyle.solid),
                                  boxShadow: [customBoxShadow]),
                              child: Text(
                                item.get('patientName'),
                              ),
                            ),
                            Positioned(
                                left: 10,
                                right: 10,
                                bottom: 10,
                                child: LinearPercentIndicator(
                                  lineHeight: 14.0,
                                  percent: 0.3,
                                  backgroundColor: textColor,
                                  progressColor: mainColor,
                                ))
                          ],
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PatientSearch extends StatefulWidget {
  const PatientSearch({super.key});

  @override
  State<PatientSearch> createState() => _PatientSearchState();
}

class _PatientSearchState extends State<PatientSearch> {
  List<Map> patients = [];
  getPatients() async {
    await firebaseFirestore.collection('patients').get().then((value) {
      for (var item in value.docs) {
        setState(() {
          patients.add({
            'email': item.get('email'),
            'name': '${item.get("fname")} ${item.get("lname")}',
            'id': item.get('medicalFileNumber')
          });
        });
      }
    });
  }

  getResultSearch(String value) async {
    for (var item in patients) {
      String ss = item['id'];
      if (ss.contains(value)) {
        setState(() {
          patients.add(item);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPatients();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              onChanged: (value) {
                getResultSearch(value);
              },
              decoration: const InputDecoration(
                hintText: 'search with patient medical file number',
                border: OutlineInputBorder(),
              ),
            ),
            patients.isEmpty
                ? Expanded(
                    child: Center(
                    child: Text(
                      'No Patients',
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ))
                : Expanded(
                    child: ListView.builder(
                        itemCount: patients.length,
                        itemBuilder: (context, index) {
                          var item = patients[index];
                          return Text(item['name']);
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
