import 'package:custom_switch/custom_switch.dart';
import 'package:authentification/widgets/FilialesButton.dart';
import 'package:flutter/material.dart';
import "../../widgets/progressBar.dart";

class DetailsPage_Client extends StatefulWidget {
  final heroTag;
  final clientName;
  final clientSurname;
  var affiliation;
  int counter=0;
  

  DetailsPage_Client(
      {this.heroTag, this.clientName, this.clientSurname, this.affiliation,this.counter});

  @override
  _DetailsPage_ClientState createState() => _DetailsPage_ClientState();
}

class _DetailsPage_ClientState extends State<DetailsPage_Client> {
  Color backgroundColor;
bool status=false;
  GlobalKey _alertDialogKey;
  int counter;
Color myColor;
  List<String> _filters = ['Géolocalisation', 'Performance', 'Ordre Alphabétique']; // Option 2
  String _selectedFilter; // Option 2
   List<String> litems = ["non affecté","Filiale 1","Filiale 2","Filiale 3","Filiale 4","Filiale 5","Filiale 6","Filiale 7","Filiale 8","Filiale 9","Filiale 10","Filiale 11","Filiale 12","Filiale 13","Filiale 14"];

  @override
  

  initState() {
     

    super.initState();
    myColor = _colorFromHex("#2C3DA5");
    this.affiliation = widget.affiliation;
    this.counter=widget.counter;
     backgroundColor = _colorFromHex("#172B4D");
    
  }

  String affiliation;
  
 static Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
  popupAppuieSurUneFiliale( int index){
    String text;
    if(index==0){ text="Attention! ,êtes vous sûr de vouloir rendre le client non affecté ?";}
    else
     text="Attention! êtes vous sûr de vouloir affecter le client à la "+litems[index]+" ?";
    setState(() { 
                              return showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) {
                                    return AlertDialog(
                                        key: _alertDialogKey,
                                        contentPadding: EdgeInsets.only(
                                            left: 25, right: 25),
                                        title: Center(
                                            child:
                                                Text(text)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        

                                                     actions:[
                     RaisedButton(
                        child: Text("Annuler",
                       
                        ),
                        onPressed: (){
                            status=false;
                            Navigator.of(context).pop();
                        },
                        color: Colors.blue,
                      ),
                      
                      RaisedButton(
                        child: Text("Oui"), 
                        onPressed:() {changementAffiliation(litems[index]);
                         Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        })

                    ]
                                               
                                                
                                                );
                                  });
                            });
  }

  void _incrementCounter() {
    setState(() {
        if (widget.counter < 4)
          widget.counter = widget.counter + 1;
        else
          widget.counter = 4;
       
    });
  }

  void _deincrementCounter(){
    setState(() {
       if(widget.counter>0)
        widget.counter = widget.counter -1;
        else
        widget.counter=0;
    });
  }

 createAlertDialog(BuildContext context) {
    
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("Progress"),
              content: ProgressBar(120, 5, widget.counter / 4),
              actions: <Widget>[
                FloatingActionButton(
                  elevation: 5.0,
                  child: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                   _deincrementCounter();
                    });
                  },
                ),
                SizedBox(width: 140),
                FloatingActionButton(
                  elevation: 5.0,
                  child: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _incrementCounter();
                    });
                  },
                ) ,

                
                

              ],
            );
          });
        });
  }

 popupDesactiverSwotch( String nonAffilie){
    String text="Attention! êtes vous sûr de vouloir rendre le client non affecté? ";
    setState(() {
                              return showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                        key: _alertDialogKey,
                                        contentPadding: EdgeInsets.only(
                                            left: 25, right: 25),
                                        title: Center(
                                            child:
                                                Text(text)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        

                                                     actions:[
                      RaisedButton(
                        child: Text("Annuler",
                       
                        ),
                        onPressed: (){
                            Navigator.of(context).pop();
                        },
                        color: Colors.blue,
                      ),
                      
                      RaisedButton(
                        child: Text("Oui"), 
                        onPressed:() {changementAffiliation(nonAffilie);
                         Navigator.of(context).pop();
                          
                        })

                    ]
                                               
                                                
                                                );
                                  });
                            });
  }



Widget dropdownButtonFunction(List<String> _filters,BuildContext context)
{
  return DropdownButton(
            hint: Text('Choisissez un filtre'), // Not necessary for Option 1
            value: _selectedFilter,
            onChanged: (newValue) {
              setState(() {
                _selectedFilter = newValue;
              });

           Navigator.of(context).pop();
           buildFilialesAlertDialog(context);

            },
            items: _filters.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
          );
}

 buildFilialesAlertDialog(BuildContext context)
{
  return showDialog(           context: context,
                                  barrierDismissible: true,
                                  builder: (context) {
                                    return AlertDialog(
                                        key: _alertDialogKey,
                                        contentPadding: EdgeInsets.only(
                                            left: 25, right: 25),
                                        title: Center(
                                            child:
                                                Text("Choisissez une filiale")),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        content: Container(
                                            height: 350,
                                            width: 300,
                                            child: ListView.builder(
                                                itemCount: litems.length,
                                                itemBuilder: (_, index) {
                                                  return RaisedButton(
                                                      onPressed: () => popupAppuieSurUneFiliale(index)
                                                     /* {
                                                          changementAffiliation( litems[index]);
                                                              Navigator.of(context).pop();
                                                      }*/,

                                                      child: Text(
                                                          litems[index],
                                                          style: TextStyle(color: Colors.white),
                                                          
                                                          ),

                                                          color: backgroundColor,
                                                          
                                                          );

                                                }
                                                ),
                                                
                                                ), 

                                                     actions:[
                    RaisedButton(
                        child: Text("Annuler",
                       
                        ),
                        onPressed: (){
                            Navigator.of(context).pop();
                        },
                        color: Colors.blue,
                      ),

                       dropdownButtonFunction(_filters,context)
                      

         
                    ]
                                               
                                                
                                                );
                                  });
}

  changementAffiliation(String nom) {
    setState(() {
      this.affiliation = nom;
    });
  }

  var selectedCard = 'WEIGHT';

  Widget okButtonReturn(int i) {
    String nomFiliale = "Filiale$i";
    Widget okButton = new FilialesButton(
      id: i,
      buttonFunction: () => changementAffiliation(nomFiliale),
      buttonText: nomFiliale,
    );

    return okButton;
  }

 
  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
          child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text('Details',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18.0,
                    color: Colors.white)),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {},
                color: Colors.white,
              )
            ],
          ),
          body: buildListView(context)),
    );
  }

  ListView buildListView(BuildContext context) {
    return ListView(children: [
      Stack(children: [
        Container(
            height: MediaQuery.of(context).size.height - 82.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent),
        Positioned(
            top: 75.0,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.0),
                      topRight: Radius.circular(45.0),
                    ),
                    color: Colors.white),
                height: MediaQuery.of(context).size.height - 100.0,
                width: MediaQuery.of(context).size.width)),
        Positioned(
            top: 30.0,
            left: (MediaQuery.of(context).size.width / 2) - 100.0,
            child: Hero(
                tag: widget.heroTag,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(widget.heroTag),
                            fit: BoxFit.cover)),
                    height: 200.0,
                    width: 200.0))),
        buildPositioned(context)
      ])
    ]);
  }

  Positioned buildPositioned(BuildContext context) {
    
    return Positioned(
        top: 250.0,
        left: 25.0,
        right: 25.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.clientName,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold)),
            Text(widget.clientSurname,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(affiliation,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20.0,

                      color:  (affiliation==litems[0])? Colors.grey : Colors.green
                      
                      )),
                Container(height: 25.0, color: Colors.grey, width: 1.0),
                Container(
                  width: 125.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.0),
                      color: Color(0xFFFDFDFD)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1,
                        child: RaisedButton(
                          color:backgroundColor,
                      /*   CustomSwitch(
              activeColor: Colors.green,
              value: status,
              onChanged: (value) {
                print("VALUE : $value");
                setState(() {
                  status = value;

                   if(status){*/
                            
                            child: Text(
                               "affectation",
                               style: TextStyle(color: Colors.white),
                            ),
                                onPressed:(){
                            
                            setState(() {

                              buildFilialesAlertDialog(context);
                             
                               /*showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                        key: _alertDialogKey,
                                        contentPadding: EdgeInsets.only(
                                            left: 25, right: 25),
                                        title: Center(
                                            child:
                                                Text("Choisissez une filiale")),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        content: Container(
                                            height: 350,
                                            width: 300,
                                            child: ListView.builder(
                                                itemCount: litems.length,
                                                itemBuilder: (_, index) {
                                                  return RaisedButton(
                                                      onPressed: () => popupAppuieSurUneFiliale(index)
                                                     /* {
                                                          changementAffiliation( litems[index]);
                                                              Navigator.of(context).pop();
                                                      }*/,

                                                      child: Text(
                                                          litems[index],
                                                          style: TextStyle(color: Colors.white),
                                                          
                                                          ),

                                                          color: backgroundColor,
                                                          
                                                          );

                                                }
                                                ),
                                                
                                                ), 

                                                     actions:[
                    RaisedButton(
                        child: Text("Annuler",
                       
                        ),
                        onPressed: (){
                            Navigator.of(context).pop();
                        },
                        color: Colors.blue,
                      ),

                       dropdownButtonFunction(_filters)
                      

         
                    ]
                                               
                                                
                                                );
                                  });
                           */
                            
                          
                          
                           
                            

                            

                  

                });
              },
               
               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
            ),
                        
                      
                      )
                    ],
                  ),
                ), 

               
              ],
            ),
            Container(
              height: 150.0,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  _buildinfo(Icons.info, "Client CIN"),
                  SizedBox(height: 15.0),
                  _buildinfo(Icons.home, "Client Adresse"),
                  SizedBox(height: 15.0),
                  _buildinfo(Icons.phone, "Client Phone Number"),
                  SizedBox(height: 15.0),
                  _buildinfo(Icons.mail, "Client Mail")
                ],
              ),
            ),
            
            SizedBox(height: 20.0),
          /*  Container(
                height: 150.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _buildInfoCard('AGE', '18', 'ans'),
                    SizedBox(width: 10.0),
                    _buildInfoCard('Adresse', 'Soukra', 'Rue des Fruits'),
                    SizedBox(width: 10.0),
                    _buildInfoCard('Mail', '', 'garnaoui.khalil0@gmail.com'),
                    SizedBox(width: 10.0),
                    _buildInfoCard('Demande', 'Appratement', 'S+3')
                  ],
                )),*/

            
             Padding(padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                  child: RaisedButton(
                      child: Text("Check Progress"),
                      onPressed: () {
                        createAlertDialog(context);
                      }),),

            
                  
          ],
        ));
  }
Widget _buildinfo(IconData icon, String info) {
    return InkWell(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: [
            Icon(icon),
            SizedBox(width: 25.0),
            Text(
              info,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String cardTitle, String info, String unit) {
    return InkWell(
        onTap: () {
          selectCard(cardTitle);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color:
                  cardTitle == selectedCard ? Color(0xFF7A9BEE) : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75),
            ),
            height: 100.0,
            width: 100.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(cardTitle,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          color: cardTitle == selectedCard
                              ? Colors.white
                              : Colors.grey.withOpacity(0.7),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(info,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14.0,
                                color: cardTitle == selectedCard
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(unit,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12.0,
                              color: cardTitle == selectedCard
                                  ? Colors.white
                                  : Colors.black,
                            )),

                             
                      ],

                    ),
                  )
                 
                ]
                )
                )
                );
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }
}

class init_State {}
