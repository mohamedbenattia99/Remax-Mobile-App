import 'package:authentification/core/services/api_service.dart';
import 'package:authentification/core/services/auth_service.dart';
import 'package:authentification/core/view_models/MotherModel.dart';
import 'package:authentification/locator.dart';
import 'package:authentification/models/user_model.dart';
import 'package:authentification/screens/login.dart';
import 'package:authentification/screens/parent/affiliates_page.dart';
import 'package:authentification/screens/parent/sign_up.dart';
import 'package:authentification/models/demande.dart';
import 'package:authentification/models/demande_list.dart';
import 'package:authentification/screens/profile.dart';
import 'package:authentification/view/demande_list_view.dart';
import 'package:authentification/viewmodel/demande_list_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:dio/dio.dart";
import 'package:authentification/viewmodel/demande_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import "../../view/demande_view.dart";
import "package:flutter_vector_icons/flutter_vector_icons.dart" as fv;
import '../add_client.dart';
class ListeClients extends StatefulWidget {
   const ListeClients({this.user});
   final UserModel user ;
  @override
  _ListeClientsState createState() => _ListeClientsState();
}

class _ListeClientsState extends State<ListeClients> {
  bool opened=false;
  UserModel user ;
  _ListeClientsState() {
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

  Color backgroundColor;
  List<Demande> filteredNames =
      new List<Demande>(); // names filtered by search text

  bool isSearching = false;
  MotherModel model = locator<MotherModel>();
  Color myColor;
  List<Demande> names =  List<Demande>();

  Widget _appBarTitle =  Text('Demandes société Mère',style:TextStyle(
    fontSize: 14.0
  ));

  final TextEditingController _filter =  TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();
  Icon _searchIcon =  Icon(Icons.search);
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    demandes = new List<Demande>();
    model.getOrders();
    myColor = _colorFromHex("#172B4D");
    this.user = widget.user ;
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
        this._appBarTitle = new Text('Demandes Société Mère');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  Widget listeDemande() {
    return DemandeListView(
      demandeListViewModel: DemandeListViewModel(
        demandeList: DemandeList(demandes: model.demandes ?? []),
      ),
      tag:user.role,
      mmodel:model
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
        print(user.role + " " + "from list client");
        print(filteredNames.toString());
        return  DemandeView(
          demandeViewModel: DemandeViewModel(demande: filteredNames[index]),
          tag: user.role,
          mmodel:model
        );
      },
    );
  }

  void _getNames() async {
    if(model.demandes != null  )
   { List<Demande> tempList = new List<Demande>();
    for (int i = 0; i < model.demandes.length; i++) {
      tempList.add(model.demandes[i]);
    }
    
      names = tempList;
      filteredNames = names; 
    }
  }

  static Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  // _showClientForm(BuildContext context, double height, double width) {
  //   showModalBottomSheet(
  //       backgroundColor: Colors.transparent,
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //             color: Colors.transparent,
  //             height: height * 0.5,
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius:
  //                     BorderRadius.only(topLeft: Radius.circular(75.0)),
  //               ),
  //               child: buildInputs(height, width),
  //             ));
  //       });
  // }

  Container formField(double height, double width,
      {IconData icon, String label}) {
    return Container(
      height: height * 0.07,
      width: width * 0.8,
      margin: EdgeInsets.only(top: 20.0),
      child: textFormField(label, icon),
    );
  }

  TextFormField textFormField(String label, IconData icon) {
    return TextFormField(
      onChanged: (value) {},
      validator: (value) => _validator(value, label: label ?? ""),
      decoration: inputDecoration(icon, label),
    );
  }

  // Widget buildInputs(double height, double width) {
  //   return Form(
  //       key: _formKey,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           formField(height, width,
  //               icon: fv.MaterialCommunityIcons.account, label: "Name"),
  //           formField(height, width,
  //               icon: fv.MaterialCommunityIcons.email,
  //               label: "remax@gmail.com"),
  //           mySizedBox20(),
  //           buildDropdownButtonFormField(width, height),
  //           mySizedBox20(),
  //           MyButton(
  //             fill: true,
  //             label: "add",
  //             backgroundColor: myColor,
  //             width: width * 0.8,
  //           ),
  //         ],
  //       ));
  // }

  SizedBox mySizedBox20() => SizedBox(height: 20.0);

  // Widget buildDropdownButtonFormField(double width, double height) {
  //   return Container(
  //     width: width * 0.8,
  //     height: height * 0.08,
  //     decoration: BoxDecoration(
  //         border: Border.all(
  //           color: myColor,
  //           width: 3.0,
  //         ),
  //         borderRadius: BorderRadius.all(Radius.circular(5.0))),
  //     child: DropdownButtonFormField(
  //         style: TextStyle(color: Colors.white),
  //         items: ["sousse,benzart"].map((f) {
  //           return DropdownMenuItem(
  //             child: SizedBox(),
  //           );
  //         }).toList(),
  //         onChanged: (selected) {}),
  //   );
  // }

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
    return value.isEmpty ? "enter $label" : null;
  }

  IconButton buildIconButton(BuildContext context) {
    return IconButton(
                    icon: Icon(fv.MaterialCommunityIcons.logout),
                    color: Colors.white,
                    onPressed: deconnexion,
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

  Widget buildBody( deviceHeight ,deviceWidth){
    return 
                (isSearching)
                 ? Container(
                     child: _buildList(),
                   )
                 : ListView(
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
                                 height: MediaQuery.of(context).size.height - 300.0,
                                 child:  !model.load ? SpinKitCircle(color: Colors.indigo,): listeDemande()  ,     
                               ),
                             ),
                           ],
                         ),
                       )
                     ],
                   );
  }
  profile() async {
    await Navigator.push(context,MaterialPageRoute(builder: (_){
      return Profile(user: user);
    }));
    dynamic result = await locator<ApiService>().getUser(user.id);
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
                              child: Text("${user.first_name[0].toUpperCase()}${user.last_name[0].toUpperCase()}",style:TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              )),
                            ),
                            Text("Bonjour ${user.first_name}",style:TextStyle(fontSize: 20))
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
                          DrawerItem(icon: Icons.create ,label:"Ajouter une filiale",function:()=>ajouterUnFiliale(context)),
                          DrawerItem(function: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Affiliates())), icon: Icons.home, label: "liste filiales"),
                          DrawerItem(icon: fv.MaterialCommunityIcons.logout,label:"Déconnexion",function:()=>deconnexion()),
                        
                          
                       ],
                      ),
                    ))
                    
                  ]
                ),
              ),
            ),
          );
  }

  List<Demande> demandes; //**You are going to full the list of demandes here */

  //**Search Bar Parameters */

  //**********Seach Bar end *************/

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
          child:  SafeArea(
        child: ChangeNotifierProvider.value(
          value : model,
                child: Consumer<MotherModel>(
                  builder: (_,model,child){
                    this._getNames();
                    return   Scaffold(
            appBar: AppBar(
              backgroundColor: _colorFromHex("#172B4D"),
              title: _appBarTitle,
              actions: <Widget>[
                  IconButton(
                    icon: _searchIcon,
                    onPressed: () {
                      _searchPressed();
                    },
                  ),
              ],
            ),
            drawer: buildDrawer(deviceHeight, deviceWidth),
            backgroundColor: _colorFromHex("#172B4D"),
            body: RefreshIndicator(
              onRefresh: () async{
                return await model.getOrders();
              },
              child: buildBody(deviceHeight, deviceWidth)), 
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: ()=>ajouterUnOrdre(model,context,widget) ,
              child: Icon(Icons.add),
            ),
          );
                  }),
        ),
      ),
    );
  }

ajouterUnFiliale(context){
  Navigator.push(context, MaterialPageRoute(builder: (_){
   return SignUpScreen();
  }));
}
ajouterUnOrdre(model,context,widget) async {                 
      await Navigator.push(context,MaterialPageRoute(builder: (_){
      return AddClient(parentId: user.id,clientId: "",affiliateId: "",);
                  }));
      model.getOrders();
              
}
}
class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key key,
    @required this.function,
    @required this.icon,
    @required this.label
  }) : super(key: key);
   final Function function ;
   final IconData icon ;
   final String label ;

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      onPressed: function , icon: Icon(icon ?? Icons.ac_unit), label: Text(label ?? "",style:TextStyle(
        fontSize: 20.0
      )));
  }
}
