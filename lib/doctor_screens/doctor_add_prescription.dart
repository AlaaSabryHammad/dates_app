import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/constants.dart';
import 'package:dates_app/models/prescription_model.dart';
import 'package:flutter/material.dart';

class DoctorAddPrescription extends StatefulWidget {
  const DoctorAddPrescription({super.key, required this.item});
  final QueryDocumentSnapshot item;
  @override
  State<DoctorAddPrescription> createState() => _DoctorAddPrescriptionState();
}

class _DoctorAddPrescriptionState extends State<DoctorAddPrescription> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List prescriptionList = [];
  String? item;
  String? description;
  toMap(Prescription pre) {
    return {'item': pre.item, 'desc': pre.desc};
  }

  getPrescription() {
    firebaseFirestore
        .collection('bookings')
        .doc(widget.item.id)
        .get()
        .then((value) {
      setState(() {
        prescriptionList = value.data()!['prescription'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPrescription();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: () {
            customShowModalSheetServiceEvaluation(context);
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Add Prescription',
                  style: mainHeaderStyle,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(
                color: mainColor,
                thickness: 2,
              ),
              prescriptionList.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Text('add prescription ....'),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: prescriptionList.length,
                          itemBuilder: (context, index) {
                            var item = prescriptionList[index];
                            return PrescriptionCard(
                              delete: () {
                                setState(() {
                                  prescriptionList.removeAt(index);
                                });
                              },
                              itemDesc: item['item'],
                              itemName: item['desc'],
                            );
                          }),
                    ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: 120,
                color: mainColor,
                onPressed: () {
                  if (prescriptionList.isEmpty) {
                    var snackBar = const SnackBar(
                        content: Text('Add atleast one Item ...'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    // List xx = prescriptionList.map((e) => toMap(e)).toList();
                    firebaseFirestore
                        .collection('bookings')
                        .doc(widget.item.id)
                        .update({
                      'prescription': prescriptionList,
                      'status': 'completed'
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Save Prescription',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> customShowModalSheetServiceEvaluation(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'New Item',
                    style: TextStyle(
                        fontSize: 30,
                        color: mainColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    onChanged: (value) {
                      item = value;
                    },
                    decoration:
                        const InputDecoration(hintText: 'write item name ....'),
                  ),
                  TextField(
                    onChanged: (value) {
                      description = value;
                    },
                    decoration: const InputDecoration(
                        hintText: 'write description ....'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    minWidth: 120,
                    color: mainColor,
                    onPressed: () {
                      setState(() {
                        prescriptionList
                            .add({'item': item, 'desc': description});
                      });
                      Navigator.pop(context);
                    },
                    child: const Text(
                      ' Add Item',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class PrescriptionCard extends StatelessWidget {
  const PrescriptionCard({
    super.key,
    required this.delete,
    required this.itemName,
    required this.itemDesc,
  });
  final VoidCallback delete;
  final String itemName, itemDesc;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(10),
          width: width - 50,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [customBoxShadow],
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Item Name',
                    style: TextStyle(
                        color: textColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    itemName,
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Item Description',
                    style: TextStyle(
                        color: textColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    itemDesc,
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            onPressed: delete,
            icon: const Icon(Icons.delete),
          ),
        ),
      ],
    );
  }
}
