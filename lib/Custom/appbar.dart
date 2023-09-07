import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {

  final String title;
  final double? elevation;
  final Color? barcolor;
  final bool? centretitle;

  CustomAppBar({
    required this.title,
    this.elevation,
    this.barcolor,
    this.centretitle
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: barcolor,
        elevation: elevation,
        centerTitle: centretitle,
      ),
    );
  }
}
