import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'messagebubble.dart';

class messagesbuilder extends StatelessWidget {
  const messagesbuilder({
    Key? key,
    required FirebaseFirestore store,
    required this.email,
  })  : _store = store,
        super(key: key);

  final FirebaseFirestore _store;
  final String email;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.collection("messages").orderBy('created on').snapshots(),
        builder: ((context, snapshot) {
          List<Widget> messagewidget = [];
          if (snapshot.hasData) {
            final messages = snapshot.data!.docs;

            for (var message in messages) {
              String text = message['message'];
              String sender = message['sender'];
              Widget f = messagebubble(
                  text: text,
                  sender: sender,
                  isme: sender == email,
                  time: message['created on']);
              messagewidget.add(f);
            }
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messagewidget,
            ),
          );
        }));
  }
}
