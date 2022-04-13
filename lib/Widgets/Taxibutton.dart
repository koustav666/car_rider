import 'package:flutter/material.dart';

class TaxiButton extends StatelessWidget {
  final Color buttonColor;
  final String text;
  final VoidCallback onPressed;

  TaxiButton({required this.buttonColor, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RaisedButton(
      // ignore: unnecessary_new
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: buttonColor,
      onPressed: onPressed,
      textColor: Colors.white,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
        ),
      ),
    );
  }
}
