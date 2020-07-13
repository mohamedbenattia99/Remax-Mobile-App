import 'dart:async';

import 'package:authentification/core/view_models/MotherModel.dart';
import 'package:authentification/locator.dart';
import 'package:authentification/models/gender.dart';
import "package:flutter/material.dart";
import 'package:validators/validators.dart' as validators;
import 'package:authentification/widgets/auth_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:flutter_vector_icons/flutter_vector_icons.dart" as fv;
import 'package:provider/provider.dart';
import "../core/services/api_service.dart";
import "../models/gov.dart";

class AddClient extends StatefulWidget {
  final String clientId ;
  final String parentId ;
  final String affiliateId ;
  AddClient({this.clientId,this.parentId,this.affiliateId});
  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final  _fomrKey = GlobalKey<FormState>();
  String _myValue ;
  final MotherModel model = locator<MotherModel>();
  Map<String,dynamic> info ; 
  static final myColor = _colorFromHex("#2C3DA5");
  String currentValue1;  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    info = {};
    getGov();
    info["phase"]="0";
    info["completed"]="0";
  }
   String gender ;
   String governorat ;
   String munic ;
   List<Municipality> munics = [];
  List<Gov> govs = [];
 
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
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text("ajout demande"),
      ),
      body: 
         Center(child: buildSignUpBody(height, width)),
      
    );
  }
   TextInputType keybordType(label){
     switch(label){
       case "remax@gmail.com": return TextInputType.emailAddress;
       case "phone": return TextInputType.phone;
       case "cin": return TextInputType.phone;
       case "zip code":return TextInputType.phone;
       default : return TextInputType.text;
     }
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


  

  Widget buildSignUpBody(double height, double width) {
    return SingleChildScrollView(
          child: Container(
        
        width: width*0.9,
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
          children: <Widget>[
            formField(height, width,
                icon: fv.MaterialCommunityIcons.account, label: "first name",tag:"first_name"),
            formField(height, width,
                icon: fv.MaterialCommunityIcons.account, label: "last name",tag:"last_name"),
            
                 formField(height, width,
                icon: fv.MaterialCommunityIcons.id_card, label: "cin",tag:"cin"),
            formField(height, width,
                icon: fv.MaterialCommunityIcons.email,
                label: "remax@gmail.com",tag:"email"),
            formField(height, width,
                icon: fv.MaterialCommunityIcons.phone,
                label: "phone",tag:"phone"),
            buildDropdownButtonFormField<Gender>(width, height, [Gender("Male"),Gender("Female")], "genre",field: "gender",callFunction: false,defaultValue: "Male" ),
            
            formField(height, width,
                icon: fv.MaterialCommunityIcons.phone,
                label: "zip_code",tag:"zip_code"),
            
             
                 buildDropdownButtonFormField<Gov>(width, height, govs, "governorat",field: "governorate",callFunction: true,defaultValue: "Not assigned" ),
                 mySizedBox20(),
                 buildDropdownButtonFormField<Municipality>(width, height, munics, "municipalité",field: "municipality",callFunction: false,defaultValue: "Not assigned" ),
                 mySizedBox20(),
                      formField(height, width,
                icon: Icons.my_location,
                label: "addresse",tag:"address"),
            ChangeNotifierProvider.value(
              value: model,
               child: Consumer<MotherModel>(
               builder:(_,model,___)=> model.bload ? MyButton(
                fill: true,
                function: add,
                label: "Add",
                backgroundColor: myColor,
                width: width * 0.9,
              ):SpinKitCircle(color: myColor,)
             ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ));
  }
  add() async {
    if(_fomrKey.currentState.validate())
    {
      print("hello");
      _fomrKey.currentState.save();
      dynamic result =  await model.addClient(info,cid:widget.clientId,pid:widget.parentId,aid:widget.affiliateId);
      print(result);
      if(result == null ){
        showErrorDialog(mssj:"un problème est survenu lors de l'ajout de la demande");
        return ;
      } else {
    showErrorDialog(mssj:"La demande a été ajoutée avec succés");
    print("from add widget");
    changed = false ;
    print(model.result);
      }
  }}
  SizedBox mySizedBox20() => SizedBox(height: 10.0);

 

  Container formField(double height, double width,
      {IconData icon, String label,String tag}) {
    return Container(
      height: height * 0.10,
      width: width * 0.9,
      margin: EdgeInsets.only(top: 5.0),
      child: textFormField(label, icon,tag),
    );
  }

  TextFormField textFormField(String label, IconData icon,String tag) {
    return TextFormField(
      autovalidate: changed,
      keyboardType: keybordType(label) ,
      onChanged: (value){
        setState(() {
          info[tag]=value ;
        });
      },
      validator: (value) => _validator(value, label: label ?? ""),
      decoration: inputDecoration(icon, label),
    );
  }          

  InputDecoration inputDecoration(IconData icon, String label) {
    return InputDecoration(
      prefixIcon: Icon(icon ?? fv.FontAwesome5Regular.stop_circle),
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
      case "Password": return validators.isAlphanumeric(value) && value.length >=8 ? null : "le mot de passe est non valide ";
      case "remax@gmail.com": return validators.isEmail(value) ? null : "l'email est non valide ";
      case "phone": return value.length == 8 ? null : "le numéro est non valide ";
      case "cin": return value.length == 8 ? null : "le cin est non valide ";
      case  "zip_code" : return value.length == 4 ? null : " 4 chiffres" ;
      case "city":return value.length >= 4 ? null :"4 char minimun";
      default : return value.length >= 4 ? null : "4 char minimum"; 
    }
  }
  // dynamic _passwordValidator(String value) {
  //   return value.isEmpty ? "enter $" : null;
  // }
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
  Text welcomeText() => Text(
        "Create Account",
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
