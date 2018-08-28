import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  @override
  StartScreenState createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  String message =
      "Welcome to the Gila River Gaming Enterprise Alerts and Notification System. This app is for GRGE Employees ONLY and is monitored for security intrusions. In order to access the app you will need to provider your GRGE badge number and last name. This can only be synced with one device. If you change devices you may either detach your device through the app settings or ask IT to perform the task for you. If you cannot access the app with your badge and last name, please contact IT to have your credentials added to the system.";

  TabController _tabController;

  ScrollController scrollController = new ScrollController();
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
                        new Flexible(
                          
                          child: new Container(
                            padding: const EdgeInsets.only(top: 15.0, bottom: 20.0, left: 15.0, right: 15.0),
                            child: new Text(
                              message,
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontFamily: "Roboto",
                                fontSize: screenSize.height * 0.023,
                              ),
                            ),
                          ),
                        ),
                        new MaterialButton(
                          height: screenSize.height * 0.07,
                          minWidth: screenSize.width * 0.6,
                          elevation: 4.0,
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.blue,
                          onPressed: () => onPressed("/LoginPage"),
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
