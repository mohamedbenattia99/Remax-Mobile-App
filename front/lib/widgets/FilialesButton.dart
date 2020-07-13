import 'package:flutter/material.dart';
class FilialesButton extends StatelessWidget {
  final int id;
  final Function(int) onPressed;
  final String buttonText;
  final Function buttonFunction;

  const FilialesButton({this.id, this.onPressed, this.buttonText,this.buttonFunction});


 

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: (){ buttonFunction(this.buttonText);},
       // backgroundColor: Colors.blue,
        child: new Text(this.buttonText,
           )
    );
  }
}