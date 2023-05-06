import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dates_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.receiverDocument});
  final QueryDocumentSnapshot receiverDocument;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text(widget.receiverDocument['name']),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: firebaseFirestore
                        .collection('messages')
                        .where('sender',
                            isEqualTo: firebaseAuth.currentUser!.email)
                        .where('receiver',
                            isEqualTo: widget.receiverDocument['email'])
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var item = snapshot.data!.docs[index];
                              return Text(item['text']);
                            });
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageController,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    )),
                    TextButton(
                      onPressed: () async {
                        await firebaseFirestore.collection('messages').add({
                          'text': messageController.text,
                          'time': FieldValue.serverTimestamp(),
                          'sender': firebaseAuth.currentUser!.email,
                          'receiver': widget.receiverDocument['email']
                        });
                        messageController.clear();
                      },
                      child: const Text(
                        'SEND',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
