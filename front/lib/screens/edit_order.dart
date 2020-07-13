import 'dart:async';

import 'package:authentification/core/services/api_service.dart';
import 'package:authentification/models/demande.dart';
import 'package:authentification/models/user_model.dart';
import "package:flutter/material.dart";

import '../locator.dart';

class EditOrder extends StatefulWidget {
  EditOrder({
    @required this.user,
  });

  Map<String, dynamic> data = {};

  Demande user;

  @override
  State<StatefulWidget> createState() {
    return _EditOrderState();
  }
}

class _EditOrderState extends State<EditOrder> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final Color myColor = Color(0xFF172B4D);
  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: myColor,
      centerTitle: true,
      title: Text("EditOrder"),
    );
  }

  Widget buildBody(double height, double width) {
    return SingleChildScrollView(
      child: Container(
        height: height * 0.8,
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.025),
        width: width * 0.9,
        child: buildBodyCard(height),
      ),
    );
  }

  bool changed = false;
  Card buildBodyCard(double height) {
    print("keeeeeeeeeeeeeeeeeeeeeeeeys");
    print(widget.data.keys);
    return Card(
      child: Form(
        key: _formState,
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
          children: <Widget>[
            buildHeader(height),
            myDivider(),
            ItemEditOrder(
              icon: true,
              widget: widget,
              first: "Prénom",
              second: widget.user?.first_name,
              valueData: "first_name",
            ),
            myDivider(),
            ItemEditOrder(
              icon: true,
              widget: widget,
              first: "nom",
              second: widget.user.last_name,
              valueData: "last_name",
            ),
            myDivider(),
            ItemEditOrder(
              icon: true,
              widget: widget,
              first: "phone",
              second: widget.user.phone,
              valueData: "phone",
            ),
            myDivider(),
            ItemEditOrder(
              icon: true,
              widget: widget,
              first: "email",
              second: widget.user.email,
              valueData: "email",
            ),
            myDivider(),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.indigo,
                child: FlatButton(
                    onPressed: widget.data.keys.length == 0
                        ? null
                        : () async {
                            print(widget.data);
                            dynamic result = await locator<ApiService>()
                                .editOrder(widget.user.id, info: widget.data);
                            if (result == null) {
                              showErrorDialog(mssj: "un problém est survenu");
                              return;
                            }
                            setState(() {
                              widget.user = result;
                            });

                            Navigator.of(context).pop(result);
                          },
                    child: Text("confirmer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold)))),
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

  Container buildHeader(double height) {
    return Container(
        height: height * 0.2,
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: myColor,
              radius: height * 0.05,
              child: Text(
                  "${widget.user?.first_name[0].toUpperCase()}${widget.user.last_name[0].toUpperCase()}",
                  style: TextStyle(
                      fontSize: height * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ));
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

class ItemEditOrder extends StatefulWidget {
  ItemEditOrder({
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
  final EditOrder widget;

  @override
  _ItemEditOrderState createState() => _ItemEditOrderState();
}

class _ItemEditOrderState extends State<ItemEditOrder> {
  String field;

  bool _toggle = false;

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
            child: TextFormField(
              autovalidate: true,
              validator: (value) =>
                  value.isEmpty ? "ce champ est obligatoire" : null,
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
          Expanded(
              flex: 1,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                child: IconButton(
                    icon: Icon(Icons.done),
                    onPressed: () {
                      setState(() {
                        if (changed) {
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
      child: Row(children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.first,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(field ?? "",
                style: TextStyle(
                  fontSize: 13.0,
                )),
          ),
        ),
        // if(widget.icon)
        Expanded(
          flex: 1,
          child: IconButton(
              onPressed: () {
                setState(() {
                  _toggle = true;
                });
              },
              icon: Icon(Icons.more_vert, size: 25.0)),
        ),
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
