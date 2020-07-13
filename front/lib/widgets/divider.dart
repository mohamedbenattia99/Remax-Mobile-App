import "package:flutter/material.dart";

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          child: Divider(
        indent: width * 0.1,
        endIndent: 10.0,
        thickness: 3.0,
      )),
      Text(
        "OU",
        style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
      ),
      Expanded(
          child: Divider(
        indent: 10.0,
        endIndent: width * 0.1,
        thickness: 3.0,
      )),
    ]);
  }
}
