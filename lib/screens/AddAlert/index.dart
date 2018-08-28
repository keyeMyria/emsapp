import 'package:flutter/material.dart';
import 'package:emsapp/theme/style.dart';
import 'style.dart';
import 'package:emsapp/services/alerts.dart';
import 'package:emsapp/services/appUser_Alerts.dart';
import 'package:emsapp/services/picture.dart';
import 'package:emsapp/services/validations.dart';
import 'package:emsapp/components/TextFields/inputField.dart';
import 'package:emsapp/components/Buttons/textButton.dart';
import 'package:emsapp/components/Buttons/roundedButton.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';


class AddAlertScreen extends StatefulWidget {
  @override
  AddAlertScreenState createState() => AddAlertScreenState();
}

class AddAlertScreenState extends State<AddAlertScreen>
    with SingleTickerProviderStateMixin {
  Validations validations = new Validations();
  TabController _tabController;
  AppAlerts rest = new AppAlerts();
  PhotoStorage photoStorage = new PhotoStorage();
  ScrollController scrollController = new ScrollController();
  // Choice _selectedChoice = choices[0];
  AppAlert alert = new AppAlert();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  onPressed(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void _select(String choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      //  _selectedChoice = choice;
      //  onPressed(_selectedChoice.page);
    });
  }

  
  var image = "";
  var photoLocation;
  uploadPhoto() async {
    photoLocation = await ImagePicker.pickImage(source: ImageSource.gallery);
    
      
  }

  submitAlert() async {
    
    image = await photoStorage.uploadPhoto(photoLocation);
    alert.image = image;

    var result = await rest.createAlert(alert);
    Navigator.pushNamed(context, "/HomePage");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final Size screenSize = MediaQuery.of(context).size;
    Validations validations = new Validations();
    return MaterialApp(
      home: Scaffold(
        body: new ListView(
          children: <Widget>[
            new Container(
              //margin: const EdgeInsets.symmetric(horizontal: 9.0),
              height: screenSize.height,
              width: screenSize.width,
              alignment: FractionalOffset.center,

              color: Colors.lightBlue,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    height: screenSize.height * 0.4,
                    width: screenSize.width * 0.8,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 20.0, left: 15.0, right: 15.0),
                          child: new Text(
                            "Alert Admin! Try to fill all the fields...",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0),
                          child: new TextField(
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                           
                              hintText: 'Message'
                            ),
                            onChanged: (String text) {
                              alert.message = text;
                            },
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(top: 25.0, bottom: 10.0, left: 10.0, right: 10.0),
                          child: new MaterialButton(
                            height: screenSize.height * 0.07,
                            minWidth: screenSize.width * 0.6,
                            elevation: 4.0,
                            padding: const EdgeInsets.all(8.0),
                            color: Colors.blue,
                            onPressed: () => uploadPhoto(),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.all(10.0),
                          child: new MaterialButton(
                            height: screenSize.height * 0.07,
                            minWidth: screenSize.width * 0.6,
                            elevation: 4.0,
                            padding: const EdgeInsets.all(8.0),
                            color: Colors.blue,
                            onPressed: () => submitAlert(),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(
                                  'Submit',
                                  style: new TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    alignment: FractionalOffset.center,
                    height: screenSize.height * 0.2,
                    width: screenSize.width,
                    child: new Text(
                      "TEAMWORKS ALERTS",
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
