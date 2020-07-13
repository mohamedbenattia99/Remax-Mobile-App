
import 'package:flutter/material.dart';
import "package:percent_indicator/circular_percent_indicator.dart";

class ProgressBar extends StatefulWidget {
  double index=0;
  double radius;
  double linewidth;
  var status = new List(4);
  ProgressBar(double radius,double linewidth,double index){
    this.index=index;
    this.radius=radius;
    this.linewidth=linewidth;
    this.status=["Rien fait","Etape 1","Etape 2","Etape 3", "Etape4"];

  }
  @override
  _ProgressBarState createState() => _ProgressBarState();
}


class _ProgressBarState extends State<ProgressBar> {
 
 
    Color    backgroundColor= _colorFromHex("#172B4D");
  @override
 
  static Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  Widget build(BuildContext context) {
     double x=widget.index*100;
     String p=(x.round()).toString()+"%";
     int s=(widget.index*4).round();
     Color _setColor(){
      if(s<4)
      return backgroundColor;
      else
      return Colors.green;
     }
    return new CircularPercentIndicator(
                radius: widget.radius,
                lineWidth: widget.linewidth,
                animateFromLastPercent:true,
                animation: true,
                percent: widget.index,
                center: new Text(
                  p,
                  style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                footer: new Text(
                  widget.status[s],
                  style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: _setColor(),
              );
  }
}