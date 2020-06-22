import 'package:flutter/material.dart';

Container boringField(Color boringColor, double textSize, String label, int maxLength, int maxLines, bool isRequired, TextEditingController textController) => Container(
  child: TextFormField(
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white
        ),
      ),
      labelText: label,
      labelStyle: TextStyle(
        fontSize: textSize,
        color: Colors.white
      )
    ),
    cursorColor: Colors.white,
    style: TextStyle(
      fontSize: textSize,
      color: Colors.white
    ),
    maxLength: maxLength,
    maxLines: maxLines,
    controller: textController,
    validator: (value) {
      if(value.isEmpty && isRequired) return "Please Enter Some Text";
      return null;
    }
  ),
  margin: const EdgeInsets.all(10.0),
  padding: const EdgeInsets.all(10.0),
  color: boringColor
);