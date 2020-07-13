import "package:flutter/material.dart";

class MyButton extends StatelessWidget {
  const MyButton({
    Key key,
    @required this.fill,
    this.borderColor,
    this.function,
    this.width,
    this.height,
    this.borderWidth,
    @required this.label,
    this.margin,
    this.route,
    this.backgroundColor,
    this.color,
  }) : super(key: key);
  final bool fill;
  final double width;
  final double height;
  final String label;
  final double borderWidth;
  final Color color;
  final double margin;
  final Color backgroundColor;
  final Color borderColor;
  final String route;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: margin ?? 0.0,
        ),
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
            border: !fill
                ? Border.all(
                    width: borderWidth ?? 1.0,
                    color: borderColor ?? Colors.white)
                : null,
            color: fill ? backgroundColor ?? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(5.0)),
        child: FlatButton(
            onPressed: function,
            child: Text(
              label,
              style: TextStyle(
                color: color ?? Colors.white,
              ),
            )));
  }
}
