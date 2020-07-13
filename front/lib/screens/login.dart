import 'dart:async';

import 'package:authentification/core/view_models/AuthModel.dart';
import 'package:authentification/locator.dart';
import 'package:authentification/screens/client/demandesClient.dart';
import 'package:authentification/screens/parent/listeClients.dart';
import 'package:validators/validators.dart' as validators;
import 'package:authentification/screens/affiliate/listeClients_fils.dart';
import 'package:authentification/widgets/auth_button.dart';
import 'package:authentification/widgets/floating_logo.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:flutter_vector_icons/flutter_vector_icons.dart" as fv;
import "package:authentification/widgets/divider.dart";
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final  _fomrKey = GlobalKey<FormState>();
  AuthModel model = locator<AuthModel>();
  String _email ;
  String _password ;
  static final myColor = _colorFromHex("#2C3DA5");

  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(child: buildLoginBody(height, width)),
    );
  }

  SingleChildScrollView buildLoginBody(double height, double width) {
    return SingleChildScrollView(
      child: Container(
        height: height,
        color: Colors.white,
        child: Column(
          children: <Widget>[buildWelcome(height), buildInputs(height, width)],
        ),
      ),
    );
  }

  Expanded buildInputs(double height, double width) {
    return Expanded(
      flex: 6,
      child: Form(
          key: _fomrKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              mySizedBox20(),
              formField(height, width,
                  icon: fv.MaterialCommunityIcons.email,
                  label: "remax@gmail.com"),
              formField(height, width,
                  icon: fv.MaterialCommunityIcons.key, label: "Password"),
              mySizedBox20(),
              ChangeNotifierProvider(
                create: (context)=>model ,
                    child: Consumer<AuthModel>( builder:(_,model,__)=>  model.load ? MyButton(
                  function: login,
                  fill: true,
                  label: "login",
                  backgroundColor: myColor,
                  width: width * 0.8,
                  height: height*0.07,
                ) : SpinKitCircle(color: myColor )
              )),
              SizedBox(
                height: 20.0,
              ),
              MyDivider(width: width),
              mySizedBox20(),
              MyButton(
                function: ()=>Navigator.pushNamed(context, '/signup'),
                fill: false,
                label: "signup",
                color: myColor,
                borderColor: myColor,
                width: width * 0.8,
                borderWidth: 3.0,
                route: "/signup",
              )
            ],
          )),
    );
  }
   
  login() async {
    if(_fomrKey.currentState.validate()){
     _fomrKey.currentState.save();
      dynamic result = await model.login(_email, _password);
      print("from login widget"  );
      
       if(result==null) {
         showErrorDialog(
           mssj: "un problém est survenu lors de connexion."
         ) ;
         return ;
       } 
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(_){
             switch(model.result.role){
               case "affiliate" : return ListeClients_fils(user: model.result);
               case "client": return DemandesClient(user:model.result);
               case "parent_company" : return ListeClients(user:model.result);
             } 
        }));
      
    }
  }
  Future<void> showErrorDialog({String mssj}) async {
      showDialog(context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Text( mssj ?? "un problém est survenu lors de changement de phase"),
      );
    });
    Timer(Duration(seconds: 2), (){
      
      Navigator.of(context).pop();
    });
   }
  SizedBox mySizedBox20() => SizedBox(height: 20.0);
dynamic _validator(String value, {String label}) {
    switch(label){
      case "Password": return validators.isAlphanumeric(value) ? null : "le mot de passe est non valide ";
      case "remax@gmail.com": return validators.isEmail(value.trim()) ? null : "l'email est non valide ";
      case "Phone": return value.length == 8 ? null : "le numéro est non valide ";
      case "cin": return value.length == 8 ? null : "le cin est non valide ";
      default : return value.length >= 4 ? null : "4 char minimum"; 
    }
  }
  // Container buildForgotPassword(double width) {
  //   return Container(
  //     width: width * 0.8,
  //     child: Text(
  //       "Forgot Password?",
  //       textAlign: TextAlign.right,
  //       style: TextStyle(
  //         color: myColor,
  //       ),
  //     ),
  //   );
  // }

  Expanded buildWelcome(double height) {
    return Expanded(
        flex: 2,
        child: Container(
            height: height * 0.2,
            width: double.infinity,
            decoration: buildBoxDecoration(),
            child: Stack(alignment: Alignment.center, children: <Widget>[
              welcomeText(),
              buildLogo(),
            ])));
  }

  Positioned buildLogo() {
    return Positioned(
      bottom: -5,
      left: 0,
      child: Row(children: <Widget>[
        AnimatedLogo(
          width: 50.0,
          height: 50.0,
        ),
        buildRichText(),
      ]),
    );
  }

  Container formField(double height, double width,
      {IconData icon, String label}) {
    return Container(
      height: height * 0.11,
      width: width * 0.8,
      margin: EdgeInsets.only(top: 20.0),
      child: textFormField(label, icon),
    );
  }

  TextFormField textFormField(String label, IconData icon) {
    return TextFormField(
      obscureText: label == "Password" ? obscureText : false,
      textAlignVertical: TextAlignVertical.center,
      onChanged: (value) {
        setState(() {
          if(label=="Password"){
            _password = value ;
            return ;
          }
          _email = value ;
        });
      },
      validator: (value) => _validator(value, label: label ?? ""),
      decoration: inputDecoration(icon, label),
    );
  }

  InputDecoration inputDecoration(IconData icon, String label) {
    return InputDecoration(
      labelText: label ?? "",
      suffixIcon: label=="Password" ?  IconButton(icon: Icon(icon,color:Colors.indigo), onPressed: ()=>setState((){
        obscureText=!obscureText ;
      })):Icon(icon ?? fv.FontAwesome5Regular.stop_circle,color:Colors.indigo),
       errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(
            color: myColor,
            width: 3.0,
          )),
    );
  }

  

  dynamic _passwordValidator(String value) {
    return value.isEmpty ? "enter password" : null;
  }

  Text welcomeText() => Text(
        "Welcome Back",
        style: TextStyle(color: Colors.white, fontSize: 30.0),
      );

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        image: DecorationImage(
      alignment: Alignment.topCenter,
      fit: BoxFit.fill,
      image: AssetImage("assets/login.png"),
    ));
  }

  TextStyle buildTextStyle() {
    return TextStyle(shadows: [
      Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
    ], color: myColor, fontWeight: FontWeight.bold, fontSize: 23.0);
  }

  TextSpan buildTextSpan(String text, Color color) {
    return TextSpan(
        text: text,
        style: TextStyle(
          color: color,
        ));
  }

  RichText buildRichText() {
    return RichText(
      text:
          TextSpan(text: "RE", style: buildTextStyle(), children: <InlineSpan>[
        buildTextSpan("/", Colors.redAccent),
        buildTextSpan("MAX", myColor),
      ]),
    );
  }

  static Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
