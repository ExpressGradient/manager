import 'package:flutter/material.dart';

Drawer boringDrawer(BuildContext context, Color boringColor, List<Widget> boringContent) => Drawer(
  child: Container(
    child: ListView(
      children: boringContent,
    ),
    padding: const EdgeInsets.all(20.0),
    color: boringColor
  )
);