import 'dart:async';
import 'package:authentification/core/services/api_service.dart';
import 'package:authentification/core/view_models/MotherModel.dart';
import 'package:authentification/locator.dart';
import 'package:authentification/models/user_model.dart';
import 'package:authentification/screens/edit_order.dart';
import 'package:authentification/screens/profile.dart';
import 'package:authentification/widgets/FilialesButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../../widgets/progressBar.dart";
import 'package:authentification/models/demande.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {this.demande,
      this.heroTag,
      this.cin,
      this.name,
      this.surname,
      this.phoneNumber,
      this.affiliation,
      this.email,
      this.agent,
      this.image,
      this.adresse,
      this.status});

  final adresse;
  final String agent;
  final image;
  final affiliation;
  final cin;
  final Demande demande;
  final email;
  final heroTag;
  final name;
  final phoneNumber;
  final int status;
  final surname;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Demande demande;
  final MotherModel model = locator<MotherModel>();
  String affiliation;
  Color backgroundColor;
  @override
  void initState() {
    super.initState();
    myColor = _colorFromHex("#2C3DA5");
    this.affiliation = widget.affiliation;
    backgroundColor = _colorFromHex("#172B4D");
    model.getAffiliates();
    demande = Demande(
        widget.cin,
        widget.name,
        widget.surname,
        widget.phoneNumber,
        widget.email,
        widget.adresse,
        widget.image,
        "",
        widget.heroTag);
  }

  Positioned buildPositioned(BuildContext context) {
    return Positioned(
        top: 250.0,
        left: 25.0,
        right: 25.0,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(demande.first_name + " " + demande.last_name,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),

              //buildInfoList(),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    firstRow(context),
                    _buildinfo(Icons.info, demande?.cin),
                    SizedBox(height: 15.0),
                    _buildinfo(Icons.home, widget.adresse),
                    SizedBox(height: 15.0),
                    _buildinfo(Icons.phone, demande?.phone),
                    SizedBox(height: 15.0),
                    _buildinfo(Icons.mail, demande?.email),
                    SizedBox(height: 12.0),
                    _buildinfo(Icons.code, widget.demande.code.toString()),
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                          color: backgroundColor,
                          child: Text(
                            "Voir Progrés",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            createAlertDialog(context);
                          },
                        ),
                        RaisedButton(
                          color: Colors.redAccent,
                          child: Text(
                            "désaffecter",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: this.affiliation.toLowerCase() ==
                                  "non assigné"
                              ? null
                              : () async {
                                  bool confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          content: Text(
                                              "Voulez vous vraimer supprimer l'affectation pour cette demande ?"),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                                child: Text("Oui")),
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: Text("Non"))
                                          ],
                                        );
                                      });
                                  if (confirm) {
                                    dynamic result = await locator<ApiService>()
                                        .editOrder(widget.heroTag,
                                            info: {'affiliate_id': null});
                                    if (result == null) {
                                      showErrorDialog();
                                      return;
                                    }
                                    setState(() {
                                      this.affiliation = "non assigné";
                                    });
                                  }
                                },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Row firstRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(this.affiliation ?? "",
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20.0,
                color: (affiliation == (model.result != null ? "aa" : ""))
                    ? Colors.grey
                    : Colors.green)),
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
                    color: backgroundColor,
                    child: Text(
                      "affectation",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        buildFilialesAlertDialog(context);
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),
              )
            ],
          ),
        ),
      ],
    );
  }

  Container buildInfoList() {
    print(widget.demande.code);
    return Container(
      height: 200.0,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _buildinfo(Icons.info, demande?.cin),
          SizedBox(height: 15.0),
          _buildinfo(Icons.home, widget.adresse),
          SizedBox(height: 15.0),
          _buildinfo(Icons.phone, demande?.phone),
          SizedBox(height: 15.0),
          _buildinfo(Icons.mail, demande?.email),
          SizedBox(height: 12.0),
          _buildinfo(Icons.code, widget.demande.code.toString()),
          SizedBox(height: 12.0),
        ],
      ),
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
              info ?? "",
              overflow: TextOverflow.ellipsis,
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
                ])));
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }

  List<Affiliate> litems;

  Color myColor;
  var selectedCard = 'WEIGHT';
  bool status = false;

  GlobalKey _alertDialogKey;
  List<String> _filters = [
    'Géolocalisation',
    'Performance',
    'Ordre Alphabétique'
  ]; // Option 2

  String _selectedFilter; // Option 2

  static Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  popupAppuieSurUneFiliale(int index) {
    String text;
    if (index == 0) {
      text =
          "Attention! ,êtes vous sûr de vouloir rendre le client non affecté ?";
    } else
      text = "Attention! êtes vous sûr de vouloir affecter le client à la " +
          (model.result != null ? model.result[index].affiliate_name : "") +
          " ?";

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              key: _alertDialogKey,
              contentPadding: EdgeInsets.only(left: 25, right: 25),
              title: Center(child: Text(text ?? "")),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              actions: [
                RaisedButton(
                  child: Text(
                    "Annuler",
                  ),
                  onPressed: () {
                    status = false;
                    Navigator.of(context).pop();
                  },
                  color: Colors.blue,
                ),
                RaisedButton(
                    child: Text("Oui"),
                    onPressed: () {
                      changementAffiliation(model.affiliates != null
                          ? model.affiliates[index]
                          : []);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("Progress"),
              content: ProgressBar(120, 5, widget.status / 4),
              actions: <Widget>[
                FlatButton(
                  child: Text("ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
        });
  }

  popupDesactiverSwotch(String nonAffilie) {
    String text =
        "Attention! êtes vous sûr de vouloir rendre le client non affecté? ";
    setState(() {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
                key: _alertDialogKey,
                contentPadding: EdgeInsets.only(left: 25, right: 25),
                title: Center(child: Text(text ?? "")),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                actions: [
                  RaisedButton(
                    child: Text(
                      "Annuler",
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.blue,
                  ),
                  RaisedButton(
                      child: Text("Oui"),
                      onPressed: () {
                        changementAffiliation(nonAffilie);
                        Navigator.of(context).pop();
                      })
                ]);
          });
    });
  }

  Widget dropdownButtonFunction(List<String> _filters, BuildContext context) {
    return DropdownButton(
      hint: Text('Choisissez un filtre'), // Not necessary for Option 1
      value: _selectedFilter,
      onChanged: (newValue) {
        setState(() {
          print(newValue);
          model.order(newValue,
              longitude: widget.demande.longitude,
              latitude: widget.demande.latitude);
          _selectedFilter = newValue;
        });
        Navigator.of(context).pop();
        buildFilialesAlertDialog(context);
      },
      items: _filters.map((location) {
        return DropdownMenuItem(
          child: new Text(location ?? ""),
          value: location,
        );
      }).toList(),
    );
  }

  buildFilialesAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return ChangeNotifierProvider.value(
            value: model,
            child: Consumer<MotherModel>(
                builder: (_, model, child) => AlertDialog(
                        key: _alertDialogKey,
                        contentPadding: EdgeInsets.only(left: 25, right: 25),
                        title: Center(child: Text("Choisissez une filiale")),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        content: Container(
                          height: 350,
                          width: 300,
                          child: ListView.builder(
                              itemCount: model.affiliates != null
                                  ? model.affiliates.length
                                  : 0,
                              itemBuilder: (_, index) {
                                return RaisedButton(
                                  onPressed: () =>
                                      popupAppuieSurUneFiliale(index)
                                  /* {
                              changementAffiliation( litems[index]);
                                Navigator.of(context).pop();                             }*/
                                  ,
                                  child: Text(
                                    model.affiliates != null
                                        ? model.affiliates[index]
                                                .affiliate_name ??
                                            ""
                                        : "",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: backgroundColor,
                                );
                              }),
                        ),
                        actions: [
                          RaisedButton(
                            child: Text(
                              "Annuler",
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.blue,
                          ),
                          dropdownButtonFunction(_filters, context)
                        ])),
          );
        });
  }

  showErrorDialog() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Text(
              "un problém est survenu lors de l'affectation",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
          );
        });
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  changementAffiliation(dynamic nom) async {
    dynamic result = await model.affectClient(demande?.id, nom.affiliate_name);
    print("from dialog ");
    print(result);
    if (result == null) {
      showErrorDialog();
    }
    ;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: myColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Text(
              "Cette Demande Est Affecté avec seccée au filiale ${nom.affiliate_name}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
          );
        });
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
    setState(() {
      this.affiliation = nom.affiliate_name;
    });
  }

  Widget okButtonReturn(int i) {
    String nomFiliale = "Filiale$i";
    Widget okButton = new FilialesButton(
      id: i,
      buttonFunction: () => changementAffiliation(nomFiliale),
      buttonText: nomFiliale ?? "",
    );

    return okButton;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: buildAppBar(context),
          body: buildListView(context)),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
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
              fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.white)),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.more_horiz),
          onPressed: () async {
            Demande result = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) {
              print(widget.heroTag);
              return EditOrder(
                  user: Demande(
                      demande?.cin,
                      demande?.first_name,
                      demande?.last_name,
                      demande?.phone,
                      demande?.email,
                      widget.adresse,
                      demande?.image,
                      "",
                      demande?.id));
            }));
            print(result.first_name);
            if (result != null)
              setState(() {
                demande = result;
              });
          },
          color: Colors.white,
        )
      ],
    );
  }
}
