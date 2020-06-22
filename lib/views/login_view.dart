import 'package:flutter/material.dart';
import '../components/boring_button.dart';
import "../firebase_utils.dart";

class LoginView extends StatelessWidget {
  LoginView({this.primaryColor, this.primaryColorLight, this.primaryColorDark});
  final Color primaryColor;
  final Color primaryColorLight;
  final Color primaryColorDark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Project Manager", style: TextStyle(color: Colors.white, fontSize: 40.0)),
            Padding(padding: const EdgeInsets.symmetric(vertical: 50.0)),
            boringButton("Sign Up With Google", () => signInManager().then((firebaseUser) => createUserRecord(firebaseUser)), 30.0, 15.0, this.primaryColorLight, Colors.white),
            Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
            boringButton("Sign In With Google", () => signInManager(), 30.0, 15.0, this.primaryColorDark, Colors.white)
          ],
          mainAxisAlignment: MainAxisAlignment.center
        )
      ),
      backgroundColor: this.primaryColor
    );
  }
}