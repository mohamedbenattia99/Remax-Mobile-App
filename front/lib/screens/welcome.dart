import "package:authentification/widgets/auth_button.dart";
import "package:flutter/material.dart";
import "package:authentification/widgets/floating_logo.dart";

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  static final Color myColor = _colorFromHex("#2C3DA5");
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          height: height,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Row(
                  children: <Widget>[
                    AnimatedLogo(
                      width: width * 0.3,
                      height: width * 0.3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: buildRichText(),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 1, child: buildText()),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: buidBottomText(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    MyButton(
                      fill: true,
                      label: "login",
                      function: (){ Navigator.pushNamed(context, '/login'); },
                      color: myColor,
                      margin: 20.0,
                      route: "/login",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    MyButton(
                      fill: false,
                      label: "signup",
                      function:()=> Navigator.pushNamed(context, '/signup'),
                      margin: 20.0,
                      route: "/signup",
                    ),
                  ],
                ),
              )
            ],
          ),
          decoration: buildBoxDecoration(),
        ),
      )),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage("assets/welcome.png"), fit: BoxFit.fill));
  }

  Text buidBottomText() {
    return Text(
      "Découver la valeur réelle de votre immobilier",
      textAlign: TextAlign.start,
      style: TextStyle(color: Colors.white, fontSize: 23.0),
    );
  }

  Text buildText() {
    return Text(
      "Trouvez le bien immobilier de vos réves",
      textAlign: TextAlign.center,
      style: TextStyle(color: myColor, fontSize: 25.0),
    );
  }

  RichText buildRichText() {
    return RichText(
      text: TextSpan(
          text: "Bienvenue à ",
          style: buildTextStyle(),
          children: <InlineSpan>[
            buildTextSpan("RE", myColor),
            buildTextSpan("/", Colors.redAccent),
            buildTextSpan("MAX", myColor),
          ]),
    );
  }

  TextStyle buildTextStyle() {
    return TextStyle(shadows: [
      Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
    ], color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23.0);
  }

  TextSpan buildTextSpan(String text, Color color) {
    return TextSpan(
        text: text,
        style: TextStyle(
          color: color,
        ));
  }

  static Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
