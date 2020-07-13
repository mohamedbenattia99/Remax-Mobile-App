import 'package:authentification/core/view_models/AuthModel.dart';
import 'package:authentification/locator.dart';
import 'package:authentification/screens/welcome.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'affiliate/listeClients_fils.dart';
import 'client/demandesClient.dart';
import 'parent/listeClients.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final authModel = locator<AuthModel>();
   dynamic result ;
   autoLogin() async {
    dynamic r = await authModel.autoLogin();
    result =r ;
   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogin();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthModel>.value(
          value: authModel,
          child: Scaffold(
          body: Consumer<AuthModel>(
            builder: (_,model,child){
              return !model.load ? SpinKitCircle(color:Colors.indigo) : buildScreen();
            },
            child: WelcomeScreen())),
    );
  }
  Widget buildScreen(){
   if(result==null){
     return WelcomeScreen();
   } else {
       switch(result.role){
               case "affiliate" : return ListeClients_fils(user: result);
               case "client": return DemandesClient(user:result);
               case "parent_company" : return ListeClients(user:result);
        } 
     }
   }

  }

