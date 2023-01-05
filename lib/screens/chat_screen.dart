import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/constants.dart';
import '../widgets/messagebuilder.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final fieldText = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  late String text;
  late var loggedinuser;
  late String email;
  var flist = [];

  void getuserid() {
    if (_auth.currentUser != null) {
      loggedinuser = _auth.currentUser;
      email = loggedinuser.email;
      print(email);
    }
  }

  void messagestream() async {
    await _store
        .collection("messages")
        .orderBy('created on')
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        print(doc.data());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getuserid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  _auth.signOut();
                  Navigator.restorablePushNamed(context, LoginScreen.id);
                }),
          ],
          title: Text('⚡️Chat'),
          backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            messagesbuilder(
              store: _store,
              email: email,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        text = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                      controller: fieldText,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _store.collection('messages').add(
                        {
                          'created on': DateTime.now().millisecondsSinceEpoch,
                          'message': text,
                          'sender': email
                        },
                      );
                      fieldText.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
