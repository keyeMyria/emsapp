import 'package:flutter/material.dart';
import 'package:emsapp/theme/style.dart';
import 'style.dart';
import 'package:emsapp/services/alerts.dart';
import 'package:emsapp/services/users.dart';
import 'package:emsapp/services/globals.dart' as globals;

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Alerts rest = new Alerts();
  ScrollController scrollController = new ScrollController();

  User user = new User();
  String badge = "";
  String lName = "";
  // Choice _selectedChoice = choices[0];
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

  login() async {
    UserProfile currentUser = new UserProfile();
    currentUser.badge = badge;
    currentUser.lastName = lName;
    var results = await user.login(currentUser);
    if (results == "Badge Number or last name does not exist.") {
      
      message = results + contact;
      _showDialog();
      
    }
    else if(results == "The account is registered to another device.") {
      message = results + contact;
      _showDialog();
    }

    else {
      globals.badge = currentUser.badge;
      Navigator.pushNamed(context, "/HomePage");
    }
    

  }

  var message = "";
  var contact = " Please contact the security department at 800-946-4452 to have the account un-registered to its current device.";
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Login Failed"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _select(String choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      //  _selectedChoice = choice;
      //  onPressed(_selectedChoice.page);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final Size screenSize = MediaQuery.of(context).size;
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
                    height: screenSize.height * 0.55,
                    width: screenSize.width * 0.8,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 20.0, left: 15.0, right: 15.0),
                          child: new Text(
                            "Enter your GRGE Badge No. and Last Name Below",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        new Container(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 20.0, left: 15.0, right: 15.0),
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Badge No.'
                            ),
                            onChanged: (String text) {
                              badge = text;
                            },
                          ),
                        ),
                        new Container(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 20.0, left: 15.0, right: 15.0),
                          child: new TextField(
                            onChanged: (String text) {
                              lName = text;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Last Name'
                            ),
                          ),
                        ),
                        new MaterialButton(
                          height: screenSize.height * 0.07,
                          minWidth: screenSize.width * 0.6,
                          elevation: 4.0,
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.blue,
                          onPressed: () => login(),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Text(
                                'Get Started',
                                style: new TextStyle(
                                  fontFamily: "Roboto",
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
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
                      "LOGIN SCREEN ALERTS",
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
