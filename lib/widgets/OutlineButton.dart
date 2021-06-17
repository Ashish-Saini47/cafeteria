import 'package:flutter/material.dart';

class OwnOutlineButton extends StatelessWidget {

  final String title;
  final Function onPressed;
  final Color color;



  OwnOutlineButton({this.title, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(

      borderSide: BorderSide(color: color),
      shape:new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(25.0),

      ) ,
      onPressed: onPressed,
      color: color,
      textColor: color,
      child: Container(
        height: 50.0,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
