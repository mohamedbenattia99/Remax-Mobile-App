import 'dart:async';

import 'package:authentification/core/services/api_service.dart';
import 'package:authentification/core/services/auth_service.dart';
import 'package:authentification/models/user_model.dart';
import "package:flutter/material.dart";

import '../locator.dart';

class Profile extends StatefulWidget {
  Profile({
    @required this.user,
  });

  Map<String, dynamic> data = {};

  UserModel user;

  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic> changePass = {};
  final Color myColor = Color(0xFF172B4D);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: myColor,
      centerTitle: true,
      title: Text("Profile"),
    );
  }

  Widget builTabView(height, width) {
    return Expanded(
      child: TabBarView(children: [firstView(), secondView(height, width)]),
    );
  }

  Widget firstView() {
    return Column(
      children: <Widget>[
        ItemProfile(
          icon: true,
          widget: widget,
          first: "Prénom",
          second: widget.user.first_name,
          valueData: "first_name",
        ),
        myDivider(),
        ItemProfile(
          icon: true,
          widget: widget,
          first: "nom",
          second: widget.user.last_name,
          valueData: "last_name",
        ),
        myDivider(),
        ItemProfile(
          icon: true,
          widget: widget,
          first: "phone",
          second: widget.user.phone,
          valueData: "phone",
        ),
        myDivider(),
        ItemProfile(
          icon: true,
          widget: widget,
          first: "email",
          second: widget.user.email,
          valueData: "email",
        ),
        myDivider(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.8,
            color: Colors.indigo,
            child: FlatButton(
                onPressed: () async {
                  print(widget.data);
                  dynamic result = await locator<ApiService>()
                      .updateUser(widget.user.id, widget.data);
                  if (result == null) {
                    showErrorDialog(mssj: "un problème est survenu");
                    return;
                  }
                  setState(() {
                    widget.user = result;
                  });
                  showErrorDialog(mssj: "Les informations sont à jour");
                },
                child: Text("confirmer",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold)))),
      ],
    );
  }

  Widget secondView(height, width) {
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              formField(height, width,
                  field: "current_password",
                  label: "mot de passe actuel",
                  icon: Icons.vpn_key),
              myDivider(),
              formField(height, width,
                  field: "password",
                  label: "mot de passe",
                  icon: Icons.vpn_key),
              myDivider(),
              formField(height, width,
                  field: "password_confirmation",
                  label: "confirmer le mot de passe",
                  icon: Icons.vpn_key)
            ],
          ),
        ),
        myDivider(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.8,
            color: Colors.indigo,
            child: FlatButton(
                onPressed: () async {
                  print(widget.data);
                  if (_formKey.currentState.validate()) {
                    changePass["id"] = widget.user.id;
                    dynamic result =
                        await locator<AuthService>().changePassword(changePass);

                    if (result is String) if (result.contains("invalid")) {
                      showErrorDialog(mssj: "verifier le mot de passe actuel");
                      return;
                    }
                    showErrorDialog(mssj: "Les informations sont à jour");
                  }
                },
                child: Text("changer Le mot de passe",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold)))),
      ],
    );
  }

  Container formField(double height, double width,
      {IconData icon, String label, String field}) {
    return Container(
      height: height * 0.07,
      width: width * 0.8,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.025),
      child: textFormField(label, icon, field),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  TextFormField textFormField(String label, IconData icon, String field) {
    return TextFormField(
      obscureText: obscureText,
      textAlignVertical: TextAlignVertical.center,
      onChanged: (value) {
        setState(() {
          changePass[field] = value;
        });
      },
      validator: (value) => _validator(value, field: field ?? ""),
      decoration: inputDecoration(icon, label),
    );
  }

  dynamic _validator(String value, {String field}) {
    switch (field) {
      case "password":
        return value.length >= 5 ? null : "le mot de passe est non valide ";
      case "password_confirmation":
        return changePass["password"] == value
            ? null
            : "le mot de passe n'est pas identique ";
      default:
        return null;
    }
  }

  bool obscureText = true;
  InputDecoration inputDecoration(IconData icon, String label) {
    return InputDecoration(
      labelStyle: TextStyle(fontSize: 13.0),
      labelText: label ?? "",
      suffixIcon: IconButton(
          icon: Icon(icon, color: Colors.indigo),
          onPressed: () => setState(() {
                obscureText = !obscureText;
              })),
      errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(
            color: myColor,
            width: 3.0,
          )),
    );
  }

  Widget buildBody(double height, double width) {
    return SingleChildScrollView(
      child: Container(
        height: height * 1.2,
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.025),
        width: width * 0.9,
        child: buildBodyCard(height, width),
      ),
    );
  }

  Card buildBodyCard(double height, double width) {
    return Card(
      child: Column(
        children: <Widget>[
          buildHeader(height),
          TabBar(indicatorColor: myColor, labelColor: myColor, tabs: [
            Tab(
              text: "General",
            ),
            Tab(
              text: "securité",
            )
          ]),
          myDivider(),
          builTabView(height, width),
        ],
      ),
    );
  }

  Divider myDivider() => Divider(
        thickness: 1,
        height: MediaQuery.of(context).size.height * 0.005,
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
                mssj ?? "un problème est survenu lors de changement de phase"),
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
                  "${widget.user.first_name[0].toUpperCase()}${widget.user.last_name[0].toUpperCase()}",
                  style: TextStyle(
                      fontSize: height * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.001,
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
        body: DefaultTabController(
            initialIndex: 0, length: 2, child: buildBody(height, width)));
  }
}

class ItemProfile extends StatefulWidget {
  ItemProfile({
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
  final Profile widget;

  @override
  _ItemProfileState createState() => _ItemProfileState();
}

class _ItemProfileState extends State<ItemProfile> {
  String field;

  bool _toggle = false;

  @override
  void initState() {
    super.initState();
    print(widget.second);
    field = widget.second;
  }

  Container buildEdit(double width, double height) {
    return Container(
      width: width * 0.8,
      height: height * 0.04,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: TextFormField(
              autovalidate: changed,
              validator: (value) =>
                  value.isEmpty ? "le champ ne doit pas étre vide" : null,
              onChanged: (value) {
                if (value.isEmpty) {
                  changed = false;
                  return;
                }
                changed = true;
                setState(() => field = value);
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
                      if (changed) {
                        setState(() {
                          widget.widget.data[widget.valueData] = field;
                          widget.second = field;
                          _toggle = false;
                        });
                      }
                    }),
              )),
        ],
      ),
    );
  }

  bool changed = true;
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
        //if (widget.icon)
        Expanded(
          flex: 1,
          child: IconButton(
              onPressed: () {
                setState(() {
                  _toggle = true;
                });
              },
              icon: Icon(Icons.more_vert,
                  size: MediaQuery.of(context).size.height * 0.035)),
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
