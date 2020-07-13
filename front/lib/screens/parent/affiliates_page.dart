
import 'package:authentification/core/services/api_service.dart';
import 'package:authentification/core/view_models/MotherModel.dart';
import 'package:authentification/locator.dart';
import 'package:authentification/models/user_model.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import './affiliate_profile.dart';

class Affiliates extends StatefulWidget {
  @override
  _AffiliatesState createState() => _AffiliatesState();
}

class _AffiliatesState extends State<Affiliates> {
  String _performance  ;
  List<Affiliate> affiliates ;
  final model = locator<MotherModel>();
  @override
  void initState() {
    super.initState();
    model.getAffiliates();
  }
  @override
  Widget build(BuildContext context) {  
    print(_performance);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
           PopupMenuButton<String>(
             icon: Icon(Icons.sort),
             onSelected: (f){
                  model.order(f);  
             },
             itemBuilder: (_)=>["Performance","Ordre Alphabétique"].map((f){
             return PopupMenuItem<String>(
               value: f,
               child: Text(f));
           }).toList())
        ],
        backgroundColor: Colors.indigo,
        title: Text("liste filiales"),
      ),
          body:  Builder(
                      builder : (ctx)=> Container(
              padding: EdgeInsets.symmetric(vertical:9.0,horizontal: 5.0),
              child: ChangeNotifierProvider.value(
                value: model,
                child: Consumer<MotherModel>(
        builder: (_,snapshot,__){
                return snapshot.load ? ListView.builder(
                itemCount: model.affiliates?.length,
                itemBuilder: (_,index){
                  Affiliate item = model.affiliates[index];
                     return Dismissible(
                       direction: DismissDirection.startToEnd,
                       background: Container(
                         padding: EdgeInsets.all(8.0),
                         margin: EdgeInsets.all(4.0),
                         width: double.infinity,
                         color: Colors.red,
                         child:Align(
                           
                           alignment: Alignment.centerLeft,
                           child: Icon(
                             Icons.delete,
                             color: Colors.white,
                           ),
                         ),
                       ),
                       
                       key: ValueKey(item.id),
                       confirmDismiss: (_) async {
                          return await showDialog<bool>(context: context,builder: (_)=>AlertDialog(
                            content: Text("voulez vous vraiment supprimer cette filiale de la liste ?"),
                            actions: <Widget>[
                              FlatButton(onPressed: () async {
                                dynamic result = await  locator<ApiService>().deleteAffiliate(item.id);
                                if(result==null){
                                    
                                  return Navigator.of(context).pop(false);
                                }
                                return Navigator.of(context).pop(true);
                              }, child: Text("oui",style: TextStyle(color:Colors.red),)),
                               FlatButton(onPressed: (){
                                Navigator.of(context).pop(false);
                              }, child: Text("non",style: TextStyle(color:Colors.green),))
                            ],
                          ));
                       },
                       onDismissed: (_) async{
                          
                          
                       },
                   child: Card(
                   child: ListTile(
                   title: Text(item.affiliate_name),
                   leading: CircleAvatar(
                       backgroundColor: Colors.indigo,
                       child: Text(item.performance.toString()),
                   ),
                   onTap: () async {
                       await Navigator.of(context).push(MaterialPageRoute(builder: (_){
                         return AffiliateProfile(user: item,);
                       }));
                       model.getAffiliates();
                   },
                 ),
                       ),
                     );
                    }) : Center(
                  child: SpinKitCircle(
                    color: Colors.indigo,
                  ),
                ) ;
        },
      ),
              ),
            ),
          ),
    );
  }

  Future<bool> showD(Affiliate item){
  return showDialog<bool>(context: context,builder: (_){
                    return AlertDialog(
                        title: Text("Details"),
                        content: Text("Voulez vous vraiment changer la performance de ${item.affiliate_name} ? \n la nouvelle Valeur Sera ${_performance}"),
                        actions: <Widget>[
                          FlatButton(onPressed: (){
                            Navigator.of(context).pop(true);
                          }, child:Text("oui") ),
                          FlatButton(onPressed: (){
                            Navigator.of(context).pop(false);
                          }, child: Text("non"))
                        ],
                    );
                  });
  }
}