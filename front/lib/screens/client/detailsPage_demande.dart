import 'package:authentification/widgets/RatingBarWidget.dart';
import 'package:flutter/material.dart';
import "../../widgets/progressBar.dart";
import 'package:authentification/models/demande.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailsPage_demande extends StatefulWidget {
  final heroTag;
  final cin;
  final name;
  final surname;
  final phoneNumber;
  final email;
  final adresse;
  final code ;
  final affiliation = "non affecté";
  Demande demande;
  int status;

  DetailsPage_demande(
      {this.demande,
      this.heroTag,
      this.cin,
      this.name,
      this.surname,
      this.phoneNumber,
      this.email,
      this.code,
      this.adresse,
      this.status});

  @override
  _DetailsPage_demandeState createState() => _DetailsPage_demandeState();
}

class _DetailsPage_demandeState extends State<DetailsPage_demande> {
  double _rating =2;
  Color backgroundColor;
  bool status = false;
  GlobalKey _alertDialogKey;
  Color myColor;
  List<String> _filters = [
    'Géolocalisation',
    'Performance',
    'Ordre Alphabétique'
  ]; // Option 2
  String _selectedFilter; // Option 2


  @override
  initState() {
    super.initState();
    myColor = _colorFromHex("#2C3DA5");
    this.affiliation = widget.affiliation;
    backgroundColor = _colorFromHex("#172B4D");
  }

  String affiliation;

  static Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
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
                            image: AssetImage("assets/${widget.heroTag}.png"),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(widget.name +" "+ widget.surname,
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
                        color: Colors.green)),
                Container(height: 25.0, color: Colors.grey, width: 1.0),
              
              ],
            ),
            Container(
              height: 180.0,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  _buildinfo(Icons.info, widget.cin),
                  SizedBox(height: 15.0),
                  _buildinfo(Icons.home, widget.adresse),
                  SizedBox(height: 15.0),
                  _buildinfo(Icons.phone, widget.phoneNumber),
                  SizedBox(height: 15.0),
                  _buildinfo(Icons.mail, widget.email),
                   SizedBox(height: 12.0),
                  _buildinfo(Icons.code, widget.demande.code.toString()),
                  SizedBox(height: 12.0),
                ],
              ),
            ),
            SizedBox(height: 20.0),
       

            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
              child: RaisedButton(
                color: backgroundColor,
                child: Text(
                  "Check Progress",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  createAlertDialog(context);
                },
              ),
            ),
  
   SizedBox(height: 20.0),


             RatingBar(
          initialRating: 2,
          minRating: 1,
          direction:  Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 50.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
             Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });

            print(_rating);
          },
        ),
      
                       Text(
                          "Rating: $_rating",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                     
          
         // RatingBarWidget()

          /*  RatingBar(
   initialRating: 3,
   minRating: 1,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
   itemBuilder: (context, _) => Icon(
     Icons.star,
     color: Colors.amber,
   ),
   onRatingUpdate: (rating) {
     print(rating);
   },
),*/


            
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
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ],
      ),
    );
  }

}