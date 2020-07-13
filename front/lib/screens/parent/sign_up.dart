import 'dart:async';

import 'package:authentification/core/services/api_service.dart';
import 'package:authentification/core/view_models/AuthModel.dart';
import 'package:authentification/locator.dart';
import 'package:authentification/models/gender.dart';
import 'package:authentification/models/gov.dart';
import 'package:validators/validators.dart' as validators;

import 'package:authentification/widgets/auth_button.dart';
import 'package:authentification/widgets/floating_logo.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:flutter_vector_icons/flutter_vector_icons.dart" as fv;
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final  _fomrKey = GlobalKey<FormState>();
   String gender ;
   String governorat ;
   String munic ;
   List<Municipality> munics = [];
  List<Gov> govs = [];
  Map<String,dynamic> info ={};
  AuthModel model = locator<AuthModel>();
  bool next  = false ;
   final api = locator<ApiService>();
  getGov() async {
    dynamic govs = await api.getGov();
    print("fril get gov widget");
    if(govs!=null)
    setState(() {
        this.govs = govs ;
    });
  }
  bool obscureText = true;
  @override
  void initState() {
    super.initState();
    getGov();
  }

  static final myColor = _colorFromHex("#2C3DA5");
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("ajout filiale"),
        centerTitle: true,
        backgroundColor: myColor,
      ),
      body: SafeArea(
        child: buildSignUpBody(height, width),
      ),
    );
  }

  Widget buildSignUpBody(double height, double width) {
    return SingleChildScrollView(
          child: Container(
        width: double.infinity,
        color: Colors.white,
        child: buildInputs(height, width),
      ),
    );
  }
 bool changed = false ;
  Widget buildInputs(double height, double width) {
    return Form(
      onChanged: (){
                  changed = true ;
                },
                onWillPop: () async {
                  if(!changed) return Future.value(true);
                   return await showDialog<bool>(context: context,builder: (_){
                     return AlertDialog(
                       content: Text("Voulez vous vraiment quitter cette page ?") ,
                       actions: <Widget>[
                         FlatButton(onPressed: (){
                           Navigator.of(context).pop(true);
                         },child:Text("oui",style:TextStyle(color: Colors.red))),
                          FlatButton(onPressed: (){
                           Navigator.of(context).pop(false);
                         },child:Text("non",style:TextStyle(color: Colors.green))),
                       ],
                     );
                   });
                },
        key: _fomrKey,
        child: Column(
          
          children:  <Widget>[
            formField(height, width,
                icon: fv.MaterialCommunityIcons.account, label: "First name",field:"first_name"),
            formField(height, width,
                icon: fv.MaterialCommunityIcons.account, label: "Last name",field:"last_name"),
            formField(height, width,
                icon: fv.MaterialCommunityIcons.account,
                label: "name",field:"affiliate_name"),
            formField(height, width,
                icon: fv.MaterialCommunityIcons.email,
                label: "remax@gmail.com",field:"email"),
            formField(height, width,
                icon: fv.MaterialCommunityIcons.phone, label: "Phone",field:"phone"),
            formField(height, width,
                icon: fv.MaterialCommunityIcons.key, label: "mot de passe",field:"password"),
             formField(height, width,
                icon: fv.MaterialCommunityIcons.key, label: "confirmer mot de passe",field:""),
             buildDropdownButtonFormField<Gender>(width, height, [Gender("Male"),Gender("Female")], "genre",field: "gender",callFunction: false,defaultValue: "Male" ),
             mySizedBox20(),
            formField(height, width,
                icon: fv.MaterialCommunityIcons.email,
                label: "zip code",field:"zip_code"),
            
             buildDropdownButtonFormField<Gov>(width, height, govs, "governorat",field: "governorate",callFunction: true,defaultValue: "Not assigned" ),
             mySizedBox20(),
             buildDropdownButtonFormField<Municipality>(width, height, munics, "municipalité",field: "municipality",callFunction: false,defaultValue: "Not assigned" ),
             formField(height, width,
                icon: fv.MaterialCommunityIcons.email,
                label: "adresse",field:"address"),
            SizedBox(height:10.0),
            
               ChangeNotifierProvider.value(
                value: model,
                child: Consumer<AuthModel>( builder:(_,model,___)=> model.load ? MyButton(
                function:signup ,
                fill: true,
                label: "ajouter",
                backgroundColor: myColor,
                width: width * 0.9,
                  ) : SpinKitCircle( color: myColor, ),
               
            )),
            SizedBox(height: 20.0,)
          ] 
        ));
  }
  signup() async{
    if(_fomrKey.currentState.validate()){    
print("from signup widget -----------------");
 dynamic result =await model.signUpAffiliate(info);
 if(result==null){
   showErrorDialog(mssj: "un problém est survenu lors d'ajout de filiale");
   return ;
 } 
 showDialog(context: context,
 builder: (_){
   return AlertDialog(
      content: Text("filiale crée avec succés"),
   );
 });
 changed = false ;
 Timer(Duration(seconds: 2), ()=>Navigator.of(context).pop());

}
  }

Future<void> showErrorDialog({String mssj}) async {
      showDialog(context: context,
    barrierDismissible: true,
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
 
  
  String gov ;
  getValue(value){
    switch(value){
      case "governorate" : return gov ;
      case "gender":return gender ;
      case "municipality":return munic ;
    }
  }
  setValue(value,selected){
   switch(value){
     case "governorate" : return gov=selected ;
      case "gender":return gender=selected ;
      case "municipality":return munic=selected ;
   }
  }
  Widget buildDropdownButtonFormField<T>(double width,double height,List<T> table,String hint , {String defaultValue,String field,bool callFunction}) {
    return Container(
      width: width * 0.9,
      height: height*0.09,
      decoration: BoxDecoration(
          border: Border.all(
            color: myColor,
            width: 3.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child:DropdownButton<String>(
        
        iconEnabledColor: myColor,
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(fv.MaterialCommunityIcons.chevron_down_circle),
        ),
        hint : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(getValue(field) ?? hint,style:TextStyle(
            color: myColor,
            fontSize: 18.0
          )),
        ),
         //itemHeight: height*0.07,
         isExpanded: true,
          style: TextStyle(color: Colors.white),
          items: table?.map((f) {
            return DropdownMenuItem<String>(
              value: f.toString(),
              child: Center(
                child: Container(
                margin: EdgeInsets.all(8.0),
                width: width*0.7,
                height: height*0.06,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(f.toString(),style: TextStyle(color:myColor,fontSize: 20.0),),
                )),
              ),
            );
          })?.toList(),
          onChanged: (selected) async {  
            setState(() {
              if(callFunction){
                  munics = govs.firstWhere((f)=>f.toString()==selected).munics ;
              }
              setValue(field, selected);
              info[field]=selected ?? defaultValue;
            });
              
          })
    );
  }

  SizedBox mySizedBox20() => SizedBox(height: 10.0);
  Container buildForgotPassword(double width) {
    return Container(
      width: width * 0.8,
      child: Text(
        "Forgot Password?",
        textAlign: TextAlign.right,
        style: TextStyle(
          color: myColor,
        ),
      ),
    );
  }

  Expanded buildWelcome(double height) {
    return Expanded(
        flex: 2,
        child: Container(
            height: height * 0.1,
            width: double.infinity,
            child: Stack(alignment: Alignment.center, children: <Widget>[
             buildLogo(),
            ])));
  }

  Positioned buildLogo() {
    return Positioned(
      bottom: -8,
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
      {IconData icon, String label,String field}) {
    return Container(
      height: height * 0.10,
      width: width * 0.9,
      margin: EdgeInsets.only(top: 5.0),
      child: textFormField(label, icon,field),
    );
  }

  TextFormField textFormField(String label, IconData icon,String field) {
    return TextFormField(
      autovalidate: changed,
      keyboardType: keybordType(label) ,
      obscureText: label.contains("passe") ? obscureText : false,
      onChanged: (value){
        setState(() {
          if(field!="")
       info[field]=value ;
        });
       
      },
      validator: (value) => _validator(value, label: label ?? ""),
      decoration: inputDecoration(icon, label),
    );
  }
 TextInputType keybordType(label){
     switch(label){
       case "remax@gmail.com": return TextInputType.emailAddress;
       case "Phone": return TextInputType.phone;
       case "cin": return TextInputType.phone;
       default : return TextInputType.text;
     }
  }
  InputDecoration inputDecoration(IconData icon, String label) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      suffixIcon: label.contains("pass") ?  IconButton(icon: Icon(icon,color:Colors.indigo), onPressed: ()=>setState((){
        obscureText=!obscureText ;
      })):Icon(icon ?? fv.FontAwesome5Regular.stop_circle,color:Colors.indigo),
      labelText: label ?? "",
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(
            color: myColor,
            width: 3.0,
          )),
    );
  }

   dynamic _validator(String value, {String label}) {
    switch(label){
      case "confirmer mot de passe" : return value == info["password"] ? null : "le mot de passe n'est pas identique" ; break ;
      case "mot de passe": return validators.isAlphanumeric(value) ? null : "le mot de passe est non valide ";
      case "remax@gmail.com": return validators.isEmail(value) ? null : "l'email est non valide ";
      case "Phone": return value.length == 8 ? null : "le numéro est non valide ";
      case "cin": return value.length == 8 ? null : "le cin est non valide ";
      case "zip code":return value.length == 4 ? null :  "4 chiffres" ;
      default : return value.length >= 4 ? null : "4 char minimum"; 
    }
  }

  dynamic _passwordValidator(String value) {
    return value.isEmpty ? "enter password" : null;
  }

  Text welcomeText() => Text(
        "Ajout Filiale",
        style: TextStyle(color: Colors.white, fontSize: 30.0),
      );

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        image: DecorationImage(
      alignment: Alignment.topCenter,
      fit: BoxFit.fill,
      image: AssetImage("assets/signup.png"),
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
