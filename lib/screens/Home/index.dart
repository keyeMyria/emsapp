import 'package:flutter/material.dart';
import 'package:emsapp/theme/style.dart';
import 'style.dart';

import 'package:emsapp/services/alerts.dart';
import 'package:emsapp/services/appUser_Alerts.dart';
import 'package:emsapp/screens/AlertDetails/index.dart';
import 'package:url_launcher/url_launcher.dart';


class _MyColor {
  const _MyColor(this.color, this.name);

  final Color color;
  final String name;
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Alerts rest = new Alerts();
  AppAlerts userAlerts = new AppAlerts();
  ScrollController scrollController = new ScrollController();
  Choice _selectedChoice = choices[0];
  @override
  void initState() {
    super.initState();
       
    getAlerts();
  }

  

  static const List<_MyColor> myBgColors = const <_MyColor>[
    const _MyColor(null, 'Clear'),
     const _MyColor(const Color(0xFFba3232), 'Red'),
     const _MyColor(const Color(0xFFba6f32), 'Orange'),
     const _MyColor(const Color(0xFFffff00), 'Yellow'),
     const _MyColor(const Color(0xFF915bb7), 'Purple'),
     const _MyColor(const Color(0xFF008080), 'Green'),
  ];

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

  List<Alert> alerts = [];
  List<AppAlert> userAppAlerts = [];
  getAlerts() async {
 
    List<Alert> test = await rest.getAlerts();
    List<AppAlert> testUser = await userAlerts.getAlertsByBadge();

    setState(() {
      alerts = test;
      userAppAlerts = testUser;
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  actions: <Widget>[
                    new Container(
                        alignment: Alignment.topRight,
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            new IconButton(
                              icon: new Icon(Icons.add, size: screenSize.height * 0.05),
                              onPressed: () => onPressed("/AddAlertPage"),
                            ),
                          ],
                        )),
                  ],
                ),
              ),

              
              new Container(
                height: screenSize.height * 0.81,
                width: screenSize.width,
                color: Colors.blue,
                child: DefaultTabController(
                  length: 2,
                  
                  child: Scaffold(
                    appBar: AppBar(
                      
                      bottom: TabBar(
                        tabs: [
                          Tab(
                            text: "Active Alert",
                            
                          ),
                          Tab(
                            text: "My Alerts",
                            
                          ),
                        ]
                      ),

                      
                    ),

                    body: TabBarView(
                      children: <Widget>[
                        new Container(
                          height: screenSize.height * 0.7,
                          width: screenSize.width,
                          color: Colors.white,
                          child: new ListView.builder(
                            itemCount: alerts.length,
                  
                            itemBuilder: (BuildContext ctxt, int index) {
                              return new MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                context,
                                  new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                  new AlertDetailsScreen(alertId: int.parse(alerts[index].id)),
                                 ));
                              },
                              child: new Container(
                                margin: const EdgeInsets.all(15.0),
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        alerts[index].title,
                                        style: new TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 20.0,
                                          color: myBgColors[int
                                            .parse(alerts[index].severityLevel)]
                                            .color,
                                        ),
                                      ),
                                      new Text(
                                        "Supposed description placeholder will be fixed in future"),
                                        //alerts[index].description),
                                      new Text(
                                        alerts[index].scheduleAt
                                      ),
                                      ],
                                    )
                                ),
                                );

                              // return new Text(alerts[index].title);
                            },
                            ),
                          ),

                         new Container(
                          height: screenSize.height * 0.7,
                          width: screenSize.width,
                          color: Colors.white,
                          child: new ListView.builder(
                            itemCount: userAppAlerts.length,
                  
                            itemBuilder: (BuildContext ctxt, int index) {
                              return new Container(
                                margin: const EdgeInsets.all(15.0),
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        userAppAlerts[index].message,
                                        style: new TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 20.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      
                                      ],
                                    )
                                );
                                

                              // return new Text(alerts[index].title);
                            },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              
              
              new Container(
                height: screenSize.height * 0.09,
                width: screenSize.width,
                child: new Row(
                  children: <Widget>[
                    new MaterialButton(
                      height: screenSize.height * 0.07,
                      minWidth: screenSize.width * 0.49,
                      elevation: 4.0,
                      // padding: const EdgeInsets.all(8.0),
                      color: Colors.red,
                      onPressed: () => launch("tel://6236800497"),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            '911',
                            style: new TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    new Container(
                      width: screenSize.width * 0.02,
                      color: Colors.white,
                    ),
                    new MaterialButton(
                      height: screenSize.height * 0.07,
                      minWidth: screenSize.width * 0.49,
                      elevation: 4.0,
                      // padding: const EdgeInsets.all(8.0),
                      color: Colors.green,
                      onPressed: () => onPressed("/SecurityPage"),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            'Security',
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
            ],
          ),
        ),
      ),
    );
  }
}


