import 'dart:async';

import 'package:authentification/core/services/api_service.dart';
import 'package:authentification/core/view_models/MotherModel.dart';
import 'package:authentification/core/view_models/SubModel.dart';
import 'package:authentification/locator.dart';
import 'package:flutter/material.dart';
import "../viewmodel/demande_view_model.dart";
import "../screens/affiliate/detailsPage_fils.dart";
import "../screens/parent/detailsPage.dart";
import "../widgets/progressBar.dart";
class DemandeView extends StatefulWidget {
  @override
  DemandeViewModel demandeViewModel;
  String tag ;
  final MotherModel mmodel ;
  final SubModel smodel ;
  
  DemandeView({demandeViewModel,this.tag,this.mmodel,this.smodel}) {
    this.demandeViewModel = demandeViewModel;
  }
  _DemandeViewState createState() => _DemandeViewState();
}

class _DemandeViewState extends State<DemandeView> {
  final api = locator<ApiService>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(Radius.circular(10)),
        ),
        child: InkWell(
          onLongPress: () async {
            showDialog(context: context,
            builder: (context){
              return AlertDialog(
                content: Text("vous voulez vraiment supprimer cette demande ?"),
                actions: <Widget>[
                  FlatButton(onPressed: () async {
                    dynamic result = await api.deleteOrder(widget.demandeViewModel.demande.id);
                    if(result==null){
                      showErrorDialog(operation: "suppression de demande");
                      return ;
                    } 
                      
                    if(widget.tag == "affiliate"){
                      await widget.smodel.getOrders(widget.demandeViewModel.demande.id);
                      Navigator.of(context).pop();
                    } else {
                      await widget.mmodel.getOrders();
                      Navigator.of(context).pop();
                    }
                  }, child: Text("Confirmer")),
                  FlatButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text("Annuler"))
                ],
              );
            });
          },
          onTap: () async {
            print("from mtaa jardak l hero ${widget.tag}");
            if (this.widget.tag == "affiliate"){
             await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage_fils(
                        demande: this.widget.demandeViewModel.demande,
                        heroTag: this.widget.demandeViewModel.demande.id,
                        image:"${this.widget.demandeViewModel.demande.gender.toUpperCase()}.png",
                        name: this.widget.demandeViewModel.demande.first_name,
                        surname: this.widget.demandeViewModel.demande.last_name,
                        cin: this.widget.demandeViewModel.demande.cin,
                        affiliation: this.widget.demandeViewModel.demande.affiliateName ,
                        phoneNumber:
                            this.widget.demandeViewModel.demande.phone,
                        adresse: this.widget.demandeViewModel.demande.adress,
                        email: this.widget.demandeViewModel.demande.email,
                        agent: this.widget.demandeViewModel.demande.agent,
                        status: this.widget.demandeViewModel.demande.phase,
                      )));
                        print(widget.demandeViewModel.demande.id);
                       widget.smodel.getOrders(widget.demandeViewModel.demande.affiliate_id); 
                      
                       return ; 
            }
            
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        demande: this.widget.demandeViewModel.demande,
                        heroTag: this.widget.demandeViewModel.demande.id,
                        image:"${this.widget.demandeViewModel.demande.gender.toUpperCase()}.png",
                        agent: this.widget.demandeViewModel.demande.agent,
                        affiliation: this.widget.demandeViewModel.demande.affiliateName,
                        name: this.widget.demandeViewModel.demande.first_name,
                        surname: this.widget.demandeViewModel.demande.last_name,
                        cin: this.widget.demandeViewModel.demande.cin,
                        phoneNumber:
                            this.widget.demandeViewModel.demande.phone,
                        adresse: this.widget.demandeViewModel.demande.adress,
                        email: this.widget.demandeViewModel.demande.email,
                        status: this.widget.demandeViewModel.demande.phase,
                      )));
                      print("from model view");
                       widget.mmodel.getOrders();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: [
                    Hero(
                        tag: this.widget.demandeViewModel.demande.id,
                        child: Image(
                            image: AssetImage(
                              "assets/${widget.demandeViewModel.demande.gender.toUpperCase()}.png"
                                ),
                            fit: BoxFit.cover,
                            height: 75.0,
                            width: 75.0)),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[ 
                                          //  Row(
                         // crossAxisAlignment: CrossAxisAlignment.start,
                         // children: [
                            Text("${this.widget.demandeViewModel.demande.first_name} ",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)),
                            Text(this.widget.demandeViewModel.demande.last_name,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)),
                        //  ]),
                          Text(
                            widget.demandeViewModel.demande.affiliateName ?? "non assigné" ,
                            style: TextStyle(color: widget.demandeViewModel.demande.affiliateName=='non assigné' ?  Colors.grey[700] : Colors.green ),)
                          ]
                    )
                  ],
                )
              ),
              
              Container(child: ProgressBar(
                  50, 5, this.widget.demandeViewModel.demande.getStatus() / 4),
                  margin: EdgeInsets.only(right: 10.0),)
              
            ],
          ),
        ),
      ),
    );
  }
  Future<void> showErrorDialog({String mssj,String operation}) async {
      showDialog(context: context,
    barrierDismissible: true,
    builder: (_) {
      return AlertDialog(
        backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Text(mssj ?? "un problème est survenu lors de ${operation ?? "l'operation"}"),
      );
    });
    
    
   }
}
