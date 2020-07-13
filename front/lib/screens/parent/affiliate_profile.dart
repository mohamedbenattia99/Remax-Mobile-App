import 'dart:async';

import 'package:authentification/core/services/api_service.dart';
import 'package:authentification/models/user_model.dart';
import "package:flutter/material.dart";

import '../../locator.dart';

class AffiliateProfile extends StatefulWidget {
  AffiliateProfile({
    @required this.user,
  });

  Map<String, dynamic> data = {};

  Affiliate user;

  @override
  State<StatefulWidget> createState() {
    return _AffiliateProfileState();
  }
}

class _AffiliateProfileState extends State<AffiliateProfile> {
  Affiliate user;
  final Color myColor = Color(0xFF172B4D);
  @override
  void initState() {
    super.initState();
    this.user = widget.user;
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: myColor,
      centerTitle: true,
      title: Text("Filiale ${user.affiliate_name}"),
    );
  }

  Widget buildBody(double height, double width) {
    return SingleChildScrollView(
      child: Container(
        height: height * 1.2,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: height * 0.025),
        width: width,
        child: buildBodyCard(height),
      ),
    );
  }

  bool changed = false;
  Card buildBodyCard(double height) {
    return Card(
      child: Form(
        onChanged: () {
          changed = true;
        },
        onWillPop: () async {
          if (!changed) return Future.value(true);
          return await showDialog<bool>(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: Text("Voulez vous vraiment quitter cette page ?"),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child:
                            Text("oui", style: TextStyle(color: Colors.red))),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child:
                            Text("non", style: TextStyle(color: Colors.green))),
                  ],
                );
              });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 20),
            ItemAffiliateProfile(
                icon: true,
                widget: widget,
                first: "Prénom",
                second: user.first_name,
                valueData: "first_name"),
            myDivider(),
            ItemAffiliateProfile(
              icon: true,
              widget: widget,
              first: "nom",
              second: user.last_name,
              valueData: "last_name",
            ),
            myDivider(),
            ItemAffiliateProfile(
              icon: true,
              first: "Nom filiale",
              second: user.affiliate_name,
              widget: widget,
              valueData: "affiliate_name",
            ),
            myDivider(),
            ItemAffiliateProfile(
              icon: true,
              first: "Performance",
              second: user.performance.toString(),
              widget: widget,
              valueData: "performance",
            ),
            myDivider(),
            ItemAffiliateProfile(
              icon: true,
              widget: widget,
              first: "phone",
              second: user.phone,
              valueData: "phone",
            ),
            myDivider(),
            ItemAffiliateProfile(
              icon: true,
              widget: widget,
              first: "email",
              second: user.email,
              valueData: "email",
            ),
            myDivider(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.indigo,
                child: FlatButton(
                    onPressed: widget.data.keys.length == 0
                        ? null
                        : () async {
                            print(user.id);
                            dynamic result = await locator<ApiService>()
                                .updateAffiliate(widget.user.id, widget.data);
                            changed = true;
                            print("from profile widget aff");
                            print(result);
                            if (result == null) {
                              showErrorDialog(mssj: "un problém est survenu");
                              changed = true;
                              return;
                            }
                            setState(() {
                              user = result;
                            });
                            showErrorDialog(
                                mssj: "Les informations sont à jour");
                            changed = false;
                          },
                    child: Text("confirmer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold)))),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Divider myDivider() => Divider(
        thickness: 1,
        height: 10.0,
      );
  // }
  Future<void> showErrorDialog({String mssj}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Text(
                mssj ?? "un problém est survenu lors de changement de phase"),
          );
        });
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: myColor,
        appBar: buildAppBar(),
        body: buildBody(height, width));
  }
}

class ItemAffiliateProfile extends StatefulWidget {
  ItemAffiliateProfile({
    Key key,
    @required this.icon,
    @required this.first,
    @required this.second,
    @required this.widget,
    this.valueData,
  }) : super(key: key);

  final String first;
  final bool icon;
  String second;
  final String valueData;
  final AffiliateProfile widget;

  @override
  _ItemAffiliateProfileState createState() => _ItemAffiliateProfileState();
}

class _ItemAffiliateProfileState extends State<ItemAffiliateProfile> {
  String field;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  bool _toggle = false;
  TextInputType kType(label) {
    switch (label) {
      case "Performance":
        return TextInputType.number;
      case "email":
        return TextInputType.emailAddress;
      case "phone":
        return TextInputType.phone;
      default:
        return TextInputType.text;
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.second);
    field = widget.second;
  }

  bool changed = true;
  Container buildEdit(double width, double height) {
    return Container(
      width: width * 0.8,
      height: height * 0.06,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Form(
              child: TextFormField(
                autovalidate: true,
                validator: (value) =>
                    value.isEmpty ? "ce champ ne doit pas etre vide" : null,
                keyboardType: kType(widget.first),
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty)
                      changed = false;
                    else {
                      changed = true;
                      field = value;
                    }
                  });
                },
                initialValue: field,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                )),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                child: IconButton(
                    icon: Icon(Icons.done),
                    onPressed: !changed
                        ? null
                        : () {
                            setState(() {
                              if (changed) {
                                if (widget.valueData == "performance") {
                                  widget.widget.data[widget.valueData] =
                                      field.toString();
                                  widget.second = field;
                                  _toggle = false;
                                }
                                widget.widget.data[widget.valueData] = field;
                                widget.second = field;
                                _toggle = false;
                              }
                            });
                          }),
              )),
        ],
      ),
    );
  }

  Container buildContainer(double width, double height) {
    return Container(
      width: width * 0.85,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.first,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(field ?? "",
                    style: TextStyle(
                      fontSize: 18.0,
                    )),
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    _toggle = true;
                  });
                },
                icon: Icon(Icons.more_vert, size: 25.0)),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return _toggle ? buildEdit(width, height) : buildContainer(width, height);
  }
}
