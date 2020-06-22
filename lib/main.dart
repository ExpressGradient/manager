import 'package:flutter/material.dart';
import './views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './views/home_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Color primaryColor = Color(0xff424242);
  final Color primaryColorDark = Color(0xff1b1b1b);
  final Color primaryColorLight = Color(0xff6d6d6d);

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("OnMessage: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("OnResume: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("OnLaunch: $message");
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Inconsolata"
      ),
      home: StreamBuilder(
        stream: _firebaseAuth.onAuthStateChanged,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            print(snapshot.data.uid);
            return HomeView(primaryColor: primaryColor, primaryColorDark: primaryColorDark, primaryColorLight: primaryColorLight);
          } else {
            print(snapshot.data);
            return LoginView(primaryColor: primaryColor, primaryColorDark: primaryColorDark, primaryColorLight: primaryColorLight);
          }
        }
      ),
      debugShowCheckedModeBanner: false
    );
  }
}

void main() => runApp(MyApp());

//TODO remove all debug logs