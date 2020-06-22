import 'package:flutter/material.dart';
import '../components/boring_drawer.dart';
import '../firebase_utils.dart';
import './create_project_view.dart';
import '../components/boring_list.dart';

class HomeView extends StatelessWidget {
  HomeView({this.primaryColor, this.primaryColorLight, this.primaryColorDark});
  final Color primaryColor;
  final Color primaryColorLight;
  final Color primaryColorDark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(fontSize: 30.0)),
        centerTitle: true,
        backgroundColor: this.primaryColorDark
      ),
      drawer: boringDrawer(
        context, this.primaryColor,
        [
          FlatButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.notifications, color: Colors.white),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0)),
                Text("Notifications", style: TextStyle(color: Colors.white, fontSize: 25.0))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            padding: const EdgeInsets.all(10.0),
            onPressed: () {}
          ),
          FlatButton(
            child: Text("Sign Out", style: TextStyle(color: Colors.white, fontSize: 25.0)),
            onPressed: () => signOutManager()
          )
        ]
      ),
      backgroundColor: this.primaryColor,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 35.0),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateProjectView(primaryColor: this.primaryColor, primaryColorDark: this.primaryColorDark, primaryColorLight: this.primaryColorLight)));
        },
        backgroundColor: this.primaryColorDark,
      ),
      body: Center(
        child: Container(
          child: BoringList(),
        )
      )
    );
  }
}