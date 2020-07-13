import 'dart:async';

import 'package:authentification/core/services/api_service.dart';
import 'package:authentification/core/services/auth_service.dart';
import 'package:authentification/core/view_models/ClientModel.dart';
import 'package:authentification/models/user_model.dart';
import 'package:authentification/screens/add_client.dart';
import 'package:authentification/screens/login.dart';
import 'package:authentification/screens/parent/listeClients.dart';
import 'package:authentification/widgets/auth_button.dart';
import 'package:authentification/models/demande.dart';
import "package:flutter_vector_icons/flutter_vector_icons.dart" as fv ;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:flutter_vector_icons/flutter_vector_icons.dart" as fv;
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../profile.dart';
import 'detailsPage_demande.dart';

class DemandesClient extends StatefulWidget {
  DemandesClient({this.user});

  UserModel user ;

  @override
  _DemandesClientState createState() => _DemandesClientState();
}

class _DemandesClientState extends State<DemandesClient> {
  _DemandesClientState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  Color backgroundColor ;
  String cin ;
  String code ;
  final dio = new Dio(); // for http requests
  List<Demande> filteredNames =
      new List<Demande>(); // names filtered by search text

  bool isSearching = false;
   final ClientModel model = locator<ClientModel>();
  Color myColor;
  List<Demande> names = new List<Demande>(); 
  UserModel user ;

  Widget _appBarTitle = new Text('Mes Demandes');
  final TextEditingController _filter = new TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();
  Icon _searchIcon = new Icon(Icons.search);
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    demandes = new List<Demande>();
    model.getOrders(widget.user.id);
    myColor = _colorFromHex("#2C3DA5");
    backgroundColor = _colorFromHex("#172B4D");
    this.user = widget.user ;
  }

  profile() async {
    await Navigator.push(context,MaterialPageRoute(builder: (_){
      return Profile(user: user);
    }));
    dynamic result = await locator<ApiService>().getUser(user?.id);
    print("parent widget");
    print(result);
    if(result==null) return ;
    setState(() {
      user = result ;
    });
  }
  Widget buildDrawer(double deviceHeight, double deviceWidth) {
    return Theme(
            data: ThemeData.dark(),
              child: Drawer(
              child: Container(
                color:  _colorFromHex("#172B4D"),
                child: Column(
                    children:<Widget> [
                    DrawerHeader(
                      child:Container(
                        height: deviceHeight*0.3,
                        width: deviceWidth*0.8,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Text("${user?.first_name[0].toUpperCase()}${user?.last_name[0].toUpperCase()}",style:TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              )),
                            ),
                            Text("Bonjour ${user?.first_name}",style:TextStyle(fontSize:20))
                          ],),
                        ) ,
                    )),
                    Container(
                     child : Align(
                     alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DrawerItem(icon: fv.MaterialCommunityIcons.account,label:"Profile",function: ()=>profile(),),
                          DrawerItem(icon: Icons.add_box,label:"Ajouter une demande",function: ()=>ajouterUnOrdre(model,context,widget),),
                          DrawerItem(icon: fv.MaterialCommunityIcons.account,label:"Obtenir vos ordres",function: ()=>getOrder(context,deviceWidth,deviceHeight),),
                          DrawerItem(icon: fv.MaterialCommunityIcons.logout,label:"Deconnexion",function:()=>deconnexion()),
                        ],
                      ),
                    ))
                    
                  ]
                ),
              ),
            ),
          );
  }

  deconnexion(){
    showDialog(
    barrierDismissible: true,
    context: context, builder: (_){
    return AlertDialog(
    content: Text("voulez-vous vraiment déconnecter ?"),
                          actions: <Widget>[
                            FlatButton(onPressed: () async {
                               await locator<AuthService>().logout();
                               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginScreen()),(Route rout)=>false);
                            }, child: Text("oui")),
                            FlatButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, child: Text("non"))
                          ],
                        );
                      });
  }

  ajouterUnOrdre(model,context,widget) async {                 
      await Navigator.push(context,MaterialPageRoute(builder: (_){
      return AddClient(parentId: user?.id,clientId: "",affiliateId: "",);
                  }));
      model.getOrders();             
}

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this.isSearching = true;
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          style: TextStyle(color: Colors.white),
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white)),
        );
      } else {
        this.isSearching = false;
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Mes Demandes');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  Widget listeDemande() {
    return ListView.builder(
      itemCount: model.demandes == null ? 0 : model.demandes.length, 
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          color: Colors.white,
          child: ListTile(
            leading: Image.asset("assets/${model?.demandes[index].gender.toUpperCase()}.png"),
            title: Text( model.demandes != null ? model.demandes[index].first_name : ""),
            subtitle: Text(model.demandes != null ? model.demandes[index].created_at : ""),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage_demande(
                        demande: model?.demandes[index],
                        
                        heroTag:  model?.demandes[index].gender.toUpperCase(),
                        name:  model?.demandes[index].first_name,
                        surname:  model?.demandes[index].last_name,
                        cin:  model?.demandes[index].cin,
                        phoneNumber:   model?.demandes[index].phone,
                        adresse:  model?.demandes[index].adress,
                        email:  model?.demandes[index].email,
                        status: model?.demandes[index].phase,
                      )));
            },
          ),
        );
      },
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List<Demande> tempList = new List<Demande>();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .first_name
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return  Card(
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.description),
            title: Text(filteredNames[index].first_name),
            subtitle: Text(filteredNames[index].created_at),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage_demande(
                        demande: filteredNames[index],
                        heroTag:  filteredNames[index].gender.toUpperCase(),
                        name:  filteredNames[index].first_name,
                        surname:  filteredNames[index].last_name,
                        cin:  filteredNames[index].cin,
                        phoneNumber:   filteredNames[index].phone,
                        adresse:  filteredNames[index].adress,
                        email:  filteredNames[index].email,
                        status: filteredNames[index].phase,
                      )));
            },
          ),
        );
      },
    );
  }

  void _getNames() async {
    List<Demande> tempList = new List<Demande>();
    print("from get Names");
    print(model.demandes);
    if(model.demandes != null) 
    {
    for (int i = 0; i < model.demandes.length; i++) {
      tempList.add(model.demandes[i]);
    }

      names = tempList;
      filteredNames = names;
    
    }
  }

  getOrder(context,deviceWidth,deviceHeight){
    showDialog(context: context,
              barrierDismissible: true,
                builder: (context){
                  return AlertDialog(
                    title:   Text("veuillez entrer le code pour avoir votre demande") ,
                    content: formField(deviceHeight, deviceWidth,label: "code",icon: Icons.code) ,
                    actions: <Widget>[
                      FlatButton(onPressed: () async {
                         dynamic result = await model.getOrderByCode(code);
                         if(model.result==null) {
                           showErrorDialog(mssj: "la demande n'est pas trouver");
                          return ;
                         }
                         showDialog(context: context,
                         builder: (context){
                             return AlertDialog(
                                  title:   Text("veuillez introduire le code cin pour cofirmer") ,
                    content: formField(deviceHeight, deviceWidth,label: "cin",icon: Icons.card_membership) ,
                    actions: <Widget>[
                      FlatButton(
                        child: Text("confirmer"),
                        onPressed: () async {
                          print(model.result);
                          print(cin);
                         if(model?.result?.cin == cin ){
                           cin = null ;
                           dynamic result =  await model.affectClientId(widget.user.id,model?.result?.id);
                           await model.getOrders(user?.id);
                           if(result==null){
                              showErrorDialog(mssj:"un prblem est survenu");
                              return ;
                           }
                           Navigator.of(context).pop();
                           showErrorDialog(mssj: "ordre ajouté avec succès");
                          
                          return ;
                         }
                        showErrorDialog(mssj: "cin n'est pas valide");
                        return ;

                      }),
                      FlatButton(
                        child: Text("annuler"),
                        onPressed: (){
                         Navigator.of(context).pop();
                      }),
                    ],
                             );
                      
                         }
                         
                         );
                      }, child: Text("Confirmer")),
                      FlatButton(onPressed: (){
                         Navigator.of(context).pop();
                      }, child: Text("Annuler")),
                    ],
                  );
                }
                );
              
  }

  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: WillPopScope (
        onWillPop: () async => false,
          child: ChangeNotifierProvider.value(
           value: model,
            child: Consumer<ClientModel>( builder:(_,model,child){
            this._getNames();
            return  Scaffold( 
            drawer: buildDrawer(deviceHeight, deviceWidth), 
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: true,
              backgroundColor: backgroundColor,
              title: _appBarTitle,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: _searchIcon,
                  onPressed: () {
                    _searchPressed();
                  },
                ),
              ],
            ),
            backgroundColor: backgroundColor,
            body: RefreshIndicator(
              onRefresh: () async {
                return await model.getOrders(widget.user.id);
              },
              child:(isSearching)
                ? Container(
                    child: _buildList(),
                  )
                :              
                  ListView(
                      children: <Widget>[
                        SizedBox(height: 25.0),
                        Padding(
                          padding: EdgeInsets.only(left: 40.0),
                          child: Row(
                            children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        new BorderRadius.all(Radius.circular(30)),
                                  ),
                                  child: Image.asset(
                                    "assets/remax-logo.png",
                                    width: deviceWidth * .6,
                                    height: deviceHeight * .1,
                                  ),
                                )
                            ],
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Container(
                          height: MediaQuery.of(context).size.height - 185.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(75.0)),
                          ),
                          child: ListView(
                            primary: false,
                            padding: EdgeInsets.only(left: 25.0),
                            children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 45.0, right: 15),
                                  child: Container(
                                    color: Colors.white,
                                    height: MediaQuery.of(context).size.height - 300.0,
                                    child: model.load ? listeDemande() : SpinKitFadingCircle(color: Colors.indigo,),
                                  ),
                                ),
                             
                            ],
                          ),
                        )
                      ],
                    )),
            floatingActionButton: GestureDetector(
              onLongPress:()=>getOrder(context,deviceWidth, deviceHeight) ,
                          child: FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (_){
                      return AddClient(clientId:user?.id,parentId: "",affiliateId:"");
                  }));
                  model.getOrders(user?.id);
                },
                child: Icon(Icons.add),
              ),
            ),
        );}),
          ),
      ),
    );
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

   Container formField(double height, double width,
      {IconData icon, String label}) {
    return Container(
      height: height * 0.10,
      width: width * 0.6,
      margin: EdgeInsets.only(top: 5.0),
      child: textFormField(label, icon),
    );
  }

  TextFormField textFormField(String label, IconData icon) {
    return TextFormField(
      onChanged: (value) {
        if(label=="code") code = value ;
        if(label=="cin") cin=value ;
      },
      validator: (value) => _validator(value, label: label ?? ""),
      decoration: inputDecoration(icon, label),
    );
  }

 dynamic _validator(String value, {String label}) {
    return value.isEmpty ? "enter $label" : null;
  }

  InputDecoration inputDecoration(IconData icon, String label) {
    return InputDecoration(
      prefixIcon: Icon(icon ?? fv.FontAwesome5Regular.stop_circle),
      hintText: label ?? "",
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(
            color: myColor,
            width: 3.0,
          )),
    );
  }

  _showClientForm(BuildContext context, double height, double width) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
              color: Colors.transparent,
              height: height * 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(75.0)),
                ),
                child: buildInputs(height, width),
              ));
        });
  }

  Widget buildInputs(double height, double width) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            formField(height, width,
                icon: fv.MaterialCommunityIcons.account, label: "Name"),
            formField(height, width,
                icon: fv.MaterialCommunityIcons.email,
                label: "remax@gmail.com"),
            mySizedBox20(),
            buildDropdownButtonFormField(width, height),
            mySizedBox20(),
            MyButton(
              fill: true,
              label: "add",
              backgroundColor: myColor,
              width: width * 0.8,
            ),
          ],
        ));
  }

  SizedBox mySizedBox20() => SizedBox(height: 20.0);

  Widget buildDropdownButtonFormField(double width, double height) {
    return Container(
      width: width * 0.8,
      height: height * 0.08,
      decoration: BoxDecoration(
          border: Border.all(
            color: myColor,
            width: 3.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: DropdownButtonFormField(
          style: TextStyle(color: Colors.white),
          items: ["sousse,benzart"].map((f) {
            return DropdownMenuItem(
              child: SizedBox(),
            );
          }).toList(),
          onChanged: (selected) {}),
    );
  }

  static Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  List<Demande> demandes;  //**You are going to full the list of demandes here */

  //** Search bar variables */
}
