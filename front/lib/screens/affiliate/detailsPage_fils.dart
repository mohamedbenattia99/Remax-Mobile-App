import 'dart:async';

import 'package:authentification/core/view_models/SubModel.dart';
import 'package:authentification/locator.dart';
import 'package:authentification/models/demande.dart';
import 'package:authentification/screens/edit_order.dart';
import 'package:authentification/widgets/FilialesButton.dart';
import 'package:flutter/material.dart';
import "../../widgets/progressBar.dart";
import "package:flutter_vector_icons/flutter_vector_icons.dart" as fv;

class DetailsPage_fils extends StatefulWidget {
  DetailsPage_fils(
      {this.demande,
      this.agent,
      this.image,
      this.affiliation,
      this.heroTag,
      this.cin,
      this.name,
      this.surname,
      this.phoneNumber,
      this.email,
      this.adresse,
      this.status});

  final adresse;
  final affiliation;
  String agent;
  final cin;
  final image;
  Demande demande;
  final email;
  final heroTag;
  final name;
  final phoneNumber;
  int status;
  final surname;

  @override
  _DetailsPage_filsState createState() => _DetailsPage_filsState();
}

class _DetailsPage_filsState extends State<DetailsPage_fils> {
  String affiliation;
  Color backgroundColor;
  SubModel model = locator<SubModel>();
  Color myColor;
  Demande demande;

  var selectedCard = 'WEIGHT';

  GlobalKey _alertDialogKey;
  final formKey = GlobalKey<FormState>();
  String agent;

  @override
  void initState() {
    super.initState();
    backgroundColor = _colorFromHex("#172B4D");
    myColor = _colorFromHex("#2C3DA5");
    demande = widget.demande;
  }

  static Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  changementAffiliation(String nom) {
    setState(() {
      this.affiliation = nom;
    });
  }

  Widget okButtonReturn(int i) {
    String nomFiliale = "Filiale$i";
    Widget okButton = new FilialesButton(
      id: i,
      buttonFunction: () => changementAffiliation(nomFiliale),
      buttonText: nomFiliale,
    );

    return okButton;
  }

  Future<void> showSuccessDialog(newPhase, {mssj}) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content:
                Text(mssj ?? "la demande est maintenant en phase $newPhase"),
          );
        });
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  Future<void> showErrorDialog({String mssj}) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Text(
                mssj ?? "un probléme est survenu lors de changement de phase"),
          );
        });
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  Future<void> _incrementstatus() async {
    int newPhase = widget.demande.getStatus() + 1;
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Text("vous voulez vraiment changer la phase actulle ?  "),
            actions: <Widget>[
              FlatButton(
                  onPressed: () async {
                    await model.changePhase(widget.demande.id, newPhase);
                    Navigator.of(context).pop();
                  },
                  child: Text("oui")),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("non"))
            ],
          );
        });
    setState(() {
      if (newPhase <= 4) widget.demande.setStatus(newPhase);
    });
    return;
  }

  Future<void> _deincrementstatus() async {
    int newPhase = widget.demande.getStatus() - 1;
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Text("vous voulez vraiment changer la phase actulle ?  "),
            actions: <Widget>[
              FlatButton(
                  onPressed: () async {
                    await model.changePhase(widget.demande.id, newPhase);
                    Navigator.of(context).pop();
                  },
                  child: Text("oui")),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("non"))
            ],
          );
        });
    setState(() {
      if (newPhase >= 0) widget.demande.setStatus(newPhase);
    });
    return;
  }

  createAlertDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("Progress"),
              content: ProgressBar(120, 5, widget.demande.getStatus() / 4),
              actions: <Widget>[
                FloatingActionButton(
                  elevation: 5.0,
                  child: Icon(Icons.remove),
                  onPressed: () async {
                    await _deincrementstatus();
                    setState(() {});
                    if (model.result == null) {
                      await showErrorDialog();
                      return;
                    }
                    await showSuccessDialog(widget.demande.phase);
                  },
                ),
                SizedBox(width: 140),
                FloatingActionButton(
                  elevation: 5.0,
                  child: Icon(Icons.add),
                  onPressed: () async {
                    await _incrementstatus();
                    setState(() {});
                    if (model.result == null) {
                      await showErrorDialog();
                      return;
                    }
                    await showSuccessDialog(widget.demande.phase);
                  },
                )
              ],
            );
          });
        });
    return;
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
                            image: AssetImage("assets/${widget.image}"),
                            fit: BoxFit.cover)),
                    height: 200.0,
                    width: 200.0))),
        buildPositioned(context)
      ])
    ]);
  }

//* Profile Details
  Positioned buildPositioned(BuildContext context) {
    return Positioned(
        top: 250.0,
        left: 25.0,
        right: 25.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(demande.first_name + " " + demande.last_name,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Container(
              height: 180,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  _buildinfo(Icons.info, widget.cin),
                  SizedBox(height: 12.0),
                  _buildinfo(Icons.home, widget.adresse),
                  SizedBox(height: 12.0),
                  _buildinfo(Icons.phone, demande.phone),
                  SizedBox(height: 12.0),
                  _buildinfo(Icons.mail, demande.email),
                  SizedBox(height: 12.0),
                  _buildinfo(Icons.code, demande.code.toString()),
                  SizedBox(height: 12.0),
                  _buildinfo(
                      fv.MaterialCommunityIcons.face_agent, widget.agent ?? ""),
                  Form(
                    key: formKey,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          formField(MediaQuery.of(context).size.height,
                              MediaQuery.of(context).size.width,
                              icon: fv.MaterialCommunityIcons.face_agent,
                              label: "nom de l'agent"),
                          CircleAvatar(
                            backgroundColor: myColor,
                            radius: 30.0,
                            child: IconButton(
                                icon: Icon(
                                  fv.Entypo.add_user,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();
                                    dynamic result = await model.affectAgent(
                                        widget.heroTag, agent);
                                    if (result == null) {
                                      showErrorDialog(
                                          mssj:
                                              "Un probléme est survenu lors de l'affectation de l'agent à cette demande");
                                      return;
                                    }
                                    setState(() {
                                      widget.agent = this.agent;
                                    });
                                    showSuccessDialog(0,
                                        mssj:
                                            "L'agent ${agent} a été affecté à cette demande avec sucées");
                                  }
                                }),
                          )
                        ]),
                  ),
                  RaisedButton(
                      color: myColor,
                      child: Text(
                        "Progress",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        createAlertDialog(context);
                      })
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    /*  RaisedButton(
                       color: myColor,
                        child: Text("Version 1",style: TextStyle(color:Colors.white),),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/list_etapes');
                        }),*/
                  ],
                ),
              ),
            ),
          ],
        ));
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
        setState(() {
          agent = value;
        });
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
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ],
      ),
    );
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () async {
                    dynamic result = await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) {
                      return EditOrder(user: widget.demande);
                    }));
                    if (result != null) {
                      setState(() {
                        demande = result;
                      });
                    }
                  })
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              color: backgroundColor,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Details',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18.0,
                    color: Colors.white)),
            centerTitle: true,
          ),
          body: buildListView(context)),
    );
  }
}
