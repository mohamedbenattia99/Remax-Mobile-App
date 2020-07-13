import 'package:authentification/core/view_models/MotherModel.dart';
import 'package:authentification/core/view_models/SubModel.dart';
import "package:flutter/material.dart";
import "demande_view.dart";
import "../viewmodel/demande_list_view_model.dart";

class DemandeListView extends StatefulWidget{

  DemandeListViewModel demandeListViewModel;
  MotherModel mmodel ;
  SubModel smodel ;
 String tag ;
  DemandeListView({demandeListViewModel,this.tag,this.mmodel,this.smodel}){
    this.demandeListViewModel=demandeListViewModel;
  }
   @override
  _DemandeListViewState createState() => _DemandeListViewState();
  }
  
  class _DemandeListViewState extends State<DemandeListView> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(itemBuilder: (context,index){
      
      return DemandeView(
        demandeViewModel: this.widget.demandeListViewModel.demandeViewModels[index] ,tag: widget.tag,mmodel:widget.mmodel,smodel:widget.smodel ,
   
        ); 
    }  
  
  ,
  itemCount: this.widget.demandeListViewModel.demandeViewModels.length,

  );
  }}
