import 'package:flutter/material.dart';
import 'package:emsapp/theme/style.dart';
import 'style.dart';
import 'package:url_launcher/url_launcher.dart';

class SecurityScreen extends StatefulWidget {
  @override
  SecurityScreenState createState() => SecurityScreenState();
}

class SecurityScreenState extends State<SecurityScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  ScrollController scrollController = new ScrollController();
  Choice _selectedChoice = choices[0];
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

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
      onPressed(_selectedChoice.page);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: new Container(
          //margin: const EdgeInsets.symmetric(horizontal: 9.0),
          height: screenSize.height,
          width: screenSize.width,
          alignment: FractionalOffset.center,

          child: new Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Container(
                height: screenSize.height * 0.1,
                width: screenSize.width,
                color: Colors.cyan,
                child: AppBar(
                  title: MaterialButton(
                    onPressed: () => onPressed("/HomePage"),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(
                          "TEAMWORKS ALERTS",
                          style: new TextStyle(
                            fontFamily: "Roboto",
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
              ),
              new Container(
                
                height: screenSize.height * 0.9,
                width: screenSize.width,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: new MaterialButton(
                        onPressed: () => launch("tel://6236800497"),
                        child: ListTile(
                         
                          isThreeLine: true,
                          title: Text("Wild Horse Pass Hotel & Casino"),
                          subtitle: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                "1 800-946-4452",
                                style: new TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 16.0,
                                  color: Colors.blue,
                                ),
                              ),
                              new Text(
                                "Contemporary Rooms & Suites in a casino property with 8 restaurants, a heated pool, & a nightclub.",
                                style: new TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                          leading: new Container(
                            height: screenSize.height * 0.1,
                            width: screenSize.height * 0.1,
                            color: Colors.greenAccent,
                            alignment: Alignment.center,
                            child: new Text(
                              "WHP",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: new MaterialButton(
                        onPressed: () => launch("tel://6236800497"),
                        child: ListTile(
                          
                          isThreeLine: true,
                          title: Text("Vee Quiva Hotel and Casino"),
                          subtitle: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                "1 800-946-4452",
                                style: new TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 16.0,
                                  color: Colors.blue,
                                ),
                              ),
                              new Text(
                                "Vibrant casino hotel offering a grill restaurant & an outdoor pool, plus live entertainment.",
                                style: new TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                          leading: new Container(
                            height: screenSize.height * 0.1,
                            width: screenSize.height * 0.1,
                            color: Colors.grey,
                            alignment: Alignment.center,
                            child: new Text(
                              "VQ",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: new MaterialButton(
                        onPressed: () => launch("tel://6236800497"),
                        child: ListTile(
                          
                          isThreeLine: true,
                          title: Text("Lone Butte Casino"),
                          subtitle: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                "1 800-946-4452",
                                style: new TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 16.0,
                                  color: Colors.blue,
                                ),
                              ),
                              new Text(
                                "A steakhouse & loung complements the gaming at this hot spot for bingo cards, slots, & other games.",
                                style: new TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                          leading: new Container(
                            height: screenSize.height * 0.1,
                            width: screenSize.height * 0.1,
                            color: Colors.purpleAccent,
                            alignment: Alignment.center,
                            child: new Text(
                              "LB",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: new MaterialButton(
                      //  onPressed: () => launch("tel://6236800497"),
                        child: ListTile(
                       
                          isThreeLine: true,
                          title: Text("Lone Buttes Distribution Center"),
                          subtitle: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                "No Phone Number Found",
                                style: new TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 16.0,
                                  color: Colors.blue,
                                ),
                              ),
                              new Text(
                                "No Description Available.",
                                style: new TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                          leading: new Container(
                            height: screenSize.height * 0.1,
                            width: screenSize.height * 0.1,
                            color: Colors.orangeAccent,
                            alignment: Alignment.center,
                            child: new Text(
                              "LBDC",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
