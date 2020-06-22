import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './boring_button.dart';

Container boringCard(DocumentSnapshot document, BuildContext context) => Container(
  child: Material(
    color: Color(0xff1b1b1b),
    child: InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("More Info", style: TextStyle(fontSize: 30.0)),
          content: Column(
            children: <Widget>[
              Text("TeamMates: ${document['teamMates']}", style: TextStyle(fontSize: 25.0)),
              Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
              Text("First Task Date: ${document['firstTaskDate']}", style: TextStyle(fontSize: 25.0)),
              Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
              Text("Second Task Date: ${document['secondTaskDate']}", style: TextStyle(fontSize: 25.0)),
              Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
              Text("Third Task Date: ${document['thirdTaskDate']}", style: TextStyle(fontSize: 25.0)),
              Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
              Text("Final Task Date: ${document['finalTaskDate']}", style: TextStyle(fontSize: 25.0)),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
          ),
          actions: <Widget>[
            boringButton("Ok", () => Navigator.pop(context), 25.0, 10.0, Color(0xff1b1b1b), Colors.white)
          ]
        ),
        barrierDismissible: true
      ),
      child: Container(
        child: Column(
          children: <Widget>[
            Text("Project: ${document['projectName']}", style: TextStyle(color: Colors.white, fontSize: 30.0)),
            Text("Description: ${document['projectDescription']}", style: TextStyle(color: Colors.white, fontSize: 25.0)),
          ]
        ),
        padding: const EdgeInsets.all(20.0)
      ),
    ),
  ),
  margin: const EdgeInsets.all(15.0)
);