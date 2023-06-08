import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'pharmacist_prescription_details.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class PharmacistPrescriptionSearch extends StatefulWidget {
  const PharmacistPrescriptionSearch({super.key});

  @override
  State<PharmacistPrescriptionSearch> createState() =>
      _PharmacistPrescriptionSearchState();
}

class _PharmacistPrescriptionSearchState
    extends State<PharmacistPrescriptionSearch> {
  String name = '';
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          name = '';
                          searchController.text = '';
                        });
                      },
                      icon: const Icon(Icons.close)),
                  hintText: 'Search For Medical File Number',
                  border: const OutlineInputBorder()),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: firebaseFirestore
                      .collection('bookings')
                      .where('prescriptions', isEqualTo: true)
                      .orderBy('startTime', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var xItem = snapshot.data!.docs[index];
                            DateTime time = xItem['startTime'].toDate();
                            if (name.isEmpty) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PharmacistPrescriptionDetails(
                                                  item: xItem)));
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: mainColor,
                                            style: BorderStyle.solid,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [customBoxShadow],
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: width * 0.7,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    xItem['patientName'],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: mainColor),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    xItem['medicalFileNumber'],
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: textColor),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                xItem['doctor'],
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor),
                                              ),
                                              Text(
                                                xItem['clinic'],
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor),
                                              ),
                                              Text(
                                                time.minute == 0
                                                    ? '${time.year}-${time.month}-${time.day} ${time.hour}:00'
                                                    : '${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor),
                                              ),
                                              Text(
                                                '${xItem['patientDiagnosis']}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.1,
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 25,
                                            color: mainColor,
                                          ),
                                        )
                                      ],
                                    )),
                              );
                            }
                            if (xItem['medicalFileNumber']
                                .toString()
                                .toLowerCase()
                                .contains(name.toLowerCase())) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PharmacistPrescriptionDetails(
                                                  item: xItem)));
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: mainColor,
                                            style: BorderStyle.solid,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [customBoxShadow],
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: width * 0.7,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    xItem['patientName'],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: mainColor),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    xItem['medicalFileNumber'],
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: textColor),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                xItem['doctor'],
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor),
                                              ),
                                              Text(
                                                xItem['clinic'],
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor),
                                              ),
                                              Text(
                                                time.minute == 0
                                                    ? '${time.year}-${time.month}-${time.day} ${time.hour}:00'
                                                    : '${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor),
                                              ),
                                              Text(
                                                '${xItem['patientDiagnosis']}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.1,
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 25,
                                            color: mainColor,
                                          ),
                                        )
                                      ],
                                    )),
                              );
                            }
                            return Container();
                          });
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class PreWidgetDetail extends StatefulWidget {
  const PreWidgetDetail({
    super.key,
    required this.item,
  });
  final QueryDocumentSnapshot item;

  @override
  State<PreWidgetDetail> createState() => _PreWidgetDetailState();
}

class _PreWidgetDetailState extends State<PreWidgetDetail> {
  String pre = '';
  setPre() async {
    // firebaseFirestore.collection('collectionPath')
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
