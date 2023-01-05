import 'package:flutter/material.dart';
import 'package:startupx/services/loginservices.dart';
import '../widgets/lrbutton.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'welcomepage.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'Login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _saving = false;
  final _auth = FirebaseAuth.instance;
  late String email = '';
  String password = '';
  late var newuser;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.black,
      inAsyncCall: _saving,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: textfield_email_inputdecoration_lr),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: textfield_password_inputdecoration_lr),
              SizedBox(
                height: 24.0,
              ),
              lrbutton(login_button_color, (() async {
                loginservices login = loginservices(_auth, context, email);
                setState(() {
                  _saving = true;
                });
                await login.login_with_phonenumber();
                User? newuser = _auth.currentUser;
              }), 'sendotp'),
              lrbutton(login_button_color, (() async {
                loginservices login = loginservices(_auth, context, email);
                setState(() {
                  _saving = true;
                });
                await login.login_with_phonenumber();
                User? newuser = _auth.currentUser;
                setState(() {
                  _saving = false;
                });

                if (newuser != null) {
                  setState(() {
                    _saving = false;
                  });

                  Navigator.restorablePushNamed(context, MyHomePage.pageid);
                } else {
                  Navigator.restorablePushNamed(context, LoginScreen.id);
                }
              }), 'Login'),
            ],
          ),
        ),
      ),
    );
  }
}
