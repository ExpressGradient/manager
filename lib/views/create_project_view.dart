import 'package:flutter/material.dart';
import '../components/boring_form_field.dart';
import '../components/boring_button.dart';
import '../firebase_utils.dart';

class CreateProjectView extends StatefulWidget {
  CreateProjectView({this.primaryColor, this.primaryColorDark, this.primaryColorLight});
  final Color primaryColor;
  final Color primaryColorDark;
  final Color primaryColorLight;

  @override
  _CreateProjectViewState createState() => _CreateProjectViewState();
}

class _CreateProjectViewState extends State<CreateProjectView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _projectDescriptionController = TextEditingController();
  final TextEditingController _projectTeamController = TextEditingController();
  DateTime _firstTaskDate;
  DateTime _secondTaskDate;
  DateTime _thirdTaskDate;
  DateTime _finalTaskDate;

  @override
  void dispose() {
    super.dispose();
    _projectNameController.dispose();
    _projectDescriptionController.dispose();
    _projectTeamController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Project", style: TextStyle(fontSize: 30.0)),
        centerTitle: true,
        backgroundColor: this.widget.primaryColorDark
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              boringField(this.widget.primaryColorLight, 25.0, "Project Name", 30, 1, true, _projectNameController),
              boringField(this.widget.primaryColorLight, 25.0, "Project Description", 200, 5, true, _projectDescriptionController),
              boringField(this.widget.primaryColorLight, 25.0, "Project Team(Comma Separated)", 300, 1, true, _projectTeamController),
              Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
              Column(
                children: <Widget>[
                  boringButton("First Task Date", () { 
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2022)
                    ).then((newDate) {
                      setState(() => _firstTaskDate = newDate);
                    });
                  }, 25.0, 15.0, this.widget.primaryColorDark, Colors.white),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0)),
                  Text(_firstTaskDate != null ? _firstTaskDate.toString() : "Pick a date", style: TextStyle(color: Colors.white, fontSize: 25.0))
                ],
                mainAxisAlignment: MainAxisAlignment.center
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
              Column(
                children: <Widget>[
                  boringButton("Second Task Date", () { 
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2022)
                    ).then((newDate) {
                      setState(() => _secondTaskDate = newDate);
                    });
                  }, 25.0, 15.0, this.widget.primaryColorDark, Colors.white),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0)),
                  Text(_secondTaskDate != null ? _secondTaskDate.toString() : "Pick a date", style: TextStyle(color: Colors.white, fontSize: 25.0))
                ],
                mainAxisAlignment: MainAxisAlignment.center
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
              Column(
                children: <Widget>[
                  boringButton("Third Task Date", () { 
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2022)
                    ).then((newDate) {
                      setState(() => _thirdTaskDate = newDate);
                    });
                  }, 25.0, 15.0, this.widget.primaryColorDark, Colors.white),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0)),
                  Text(_thirdTaskDate != null ? _thirdTaskDate.toString() : "Pick a date", style: TextStyle(color: Colors.white, fontSize: 25.0))
                ],
                mainAxisAlignment: MainAxisAlignment.center
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
              Column(
                children: <Widget>[
                  boringButton("Final Task Date", () { 
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2022)
                    ).then((newDate) {
                      setState(() => _finalTaskDate = newDate);
                    });
                  }, 25.0, 15.0, this.widget.primaryColorDark, Colors.white),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0)),
                  Text(_finalTaskDate != null ? _finalTaskDate.toString() : "Pick a date", style: TextStyle(color: Colors.white, fontSize: 25.0))
                ],
                mainAxisAlignment: MainAxisAlignment.center
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
              Row(
                children: <Widget>[
                  boringButton("Cancel", () {
                    _projectNameController.text = "";
                    _projectDescriptionController.text = "";
                    _projectTeamController.text = "";
                    Navigator.pop(context);
                  }, 30.0, 15.0, this.widget.primaryColorLight, Colors.white),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0)),
                  boringButton("Create", () {
                    if(_formKey.currentState.validate()) {
                      createProject(_projectNameController.text, _projectDescriptionController.text, _projectTeamController.text.split(","), _firstTaskDate.toIso8601String(), _secondTaskDate.toIso8601String(), _thirdTaskDate.toIso8601String(), _finalTaskDate.toIso8601String());
                      _projectNameController.text = "";
                      _projectDescriptionController.text = "";
                      _projectTeamController.text = "";
                      Navigator.pop(context);
                    }
                  }, 30.0, 15.0, this.widget.primaryColorDark, Colors.white)
                ],
                mainAxisAlignment: MainAxisAlignment.center
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 10.0))
            ]
          )
        )
      ),
      backgroundColor: this.widget.primaryColor
    );
  }
}