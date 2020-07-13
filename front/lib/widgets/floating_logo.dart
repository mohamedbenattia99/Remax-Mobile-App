import 'package:flare_flutter/flare_actor.dart';
import "package:flutter/material.dart";

class AnimatedLogo extends StatelessWidget {
  AnimatedLogo({Key key, this.height, this.width}) : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: FlareActor(
        "assets/ball.flr",
        fit: BoxFit.cover,
        animation: "animate",
      ),
    );
  }
}
