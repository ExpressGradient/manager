import 'package:flutter/material.dart';

RaisedButton boringButton(String label, dynamic onPressedCallback, double labelSize, double paddingValue, Color buttonColor, Color labelColor) => RaisedButton(
  child: Text(label, style: TextStyle(fontSize: labelSize, color: labelColor)),
  onPressed: () => onPressedCallback(),
  padding: new EdgeInsets.all(paddingValue),
  color: buttonColor
);