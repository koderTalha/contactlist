import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onpressed;
  final String childtext;
  final Color? bgcolor;
  final double? btnwidth;
  final double? btnheight;


  const CustomButton({
    required this.onpressed,
    required this.childtext,
    this.bgcolor,
    this.btnwidth,
    this.btnheight,
});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(

          backgroundColor: bgcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )
        ),
        child: Text(childtext),
    );
  }
}
