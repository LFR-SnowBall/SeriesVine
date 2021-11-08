import 'package:flutter/material.dart';

class SeriesVineButtons extends StatelessWidget {
  final text;
  final Function onPressed;
  final bgColor;

  SeriesVineButtons(
      {Key? key, bgColor, required this.text, required this.onPressed})
      : this.bgColor = bgColor ?? Colors.blue,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //button

    final buttonStyle = TextButton.styleFrom(
      backgroundColor: this.bgColor,
      primary: Colors.white,
      shape: StadiumBorder(),
    );

    return Container(
        margin: EdgeInsets.only(bottom: 10, right: 5, left: 5),
        child: TextButton(
          style: buttonStyle,
          child: Container(
            width: 150,
            height: 65,
            child: Center(
              child: Text(
                this.text,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
              ),
            ),
          ),
          onPressed: () => this.onPressed(),
        ));
  }
}
