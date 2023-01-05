import 'package:flutter/material.dart';
import 'screens/chalega.dart';
import 'screens/baithahua.dart';
import 'screens/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'services/otpscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        routes: {
          // '/': ((context) => LoginScreen()),
          '/': ((context) => LoginScreen()),
          LoginScreen.id: ((context) => LoginScreen()),
          MyHomePage.pageid: (context) => MyHomePage(title: 'homie'),
          chalega.pageid: (context) => chalega(),
          baitha.pageid: (context) => baitha(),
        });
  }
}
