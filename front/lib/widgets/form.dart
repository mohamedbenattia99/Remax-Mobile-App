import "package:flutter/material.dart";
import 'package:validators/validators.dart' as validators;
import "package:flutter_vector_icons/flutter_vector_icons.dart" as fv;

class MyFormField extends StatefulWidget {
  IconData icon ;
  Map<String,dynamic> info ;
  String label ;
  bool hide ;
   String field ;
  MyFormField({this.icon,this.label,this.field,this.hide});
 
  @override
  _MyFormFieldState createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  Color myColor = Color(0xFF2C3DA5) ;
  bool obscureText = false ;
  bool changed = false ;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height ;
    double width = MediaQuery.of(context).size.width ;
    return formField(height, width,icon: widget.icon,label: widget.label,hide: widget.hide);
  }
  Container formField(double height, double width,
      {IconData icon, String label,String field,bool hide}) {
    return Container(
      height: height * 0.10,
      width: width * 0.8,
      margin: EdgeInsets.only(top: 5.0),
      child: textFormField(label, icon,field,hide ?? false),
    );
  }

  TextFormField textFormField(String label, IconData icon,String field,bool hide) {
    return TextFormField(
      autovalidate: changed,
      keyboardType: keybordType(label) ,
      obscureText: hide,
      onChanged: (value){
       setState((){if(field!="")
       widget.info[field]=value ;
       changed = true ;
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
      suffixIcon: label=="Password" ?  IconButton(icon: Icon(icon,color:Colors.indigo), onPressed: ()=>setState((){
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
      case "confirmer mot de passe" : return value == widget.info["password"] ? null : "le mot de passe n'est pas identique" ; break ;
      case "mot de passe": return validators.isAlphanumeric(value) ? null : "le mot de passe est non valide ";
      case "remax@gmail.com": return validators.isEmail(value) ? null : "l'email est non valide ";
      case "Phone": return value.length == 8 ? null : "le numéro est non valide ";
      case "cin": return value.length == 8 ? null : "le cin est non valide ";
      default : return value.length >= 4 ? null : "4 char minimum"; 
    }
  }
}