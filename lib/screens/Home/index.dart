import 'package:flutter/material.dart';
import 'package:emsapp/theme/style.dart';
import 'style.dart';
import 'dart:async';
import 'package:emsapp/services/alerts.dart';
import 'package:emsapp/services/appUser_Alerts.dart';
import 'package:emsapp/screens/AlertDetails/index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  bool _loading;

  @override
  void initState() {
    _loading = true;
    super.initState();

    getAlerts().then((result) {
      setState(() {
        _loading = false;
      });
    });
  }

  static const List<_MyColor> myBgColors = const <_MyColor>[
    const _MyColor(null, 'Clear'),
    const _MyColor(const Color(0xFFba3232), 'Red'),
    const _MyColor(const Color(0xFFba6f32), 'Orange'),
    const _MyColor(const Color(0xFF959F05), 'Yellow'),
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

  Widget _buildHeader(context, mode) {
    return new ClassicIndicator(mode: mode);
  }

  Widget _buildFooter(context, mode) {
    // the same with header
    return new ClassicIndicator(mode: mode);
  }

  RefreshController _refreshController = new RefreshController();
  void _onRefresh(bool up) {
    if (up) {
      //headerIndicator callback
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {
        _refreshController.sendBack(true, RefreshStatus.failed);
      });
    } else {
      //footerIndicator Callback
    }
  }

  List<Alert> alerts = [];
  List<AppAlert> userAppAlerts = [];
  getAlerts() async {
    List<Alert> test = await rest.getAlerts();
    List<AppAlert> testUser = await userAlerts.getAlertsByBadge();
    for (var i = 0; i < test.length; i++) {
      if (test[i].description == null) {
        test[i].description = "No Description";
      }
    }
    setState(() {
      alerts = test;
      userAppAlerts = testUser;
    });
  }

  void call911() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Container(
            child: new Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: new Icon(
                    Icons.warning,
                  ),
                ),
                new Text("Call 911"),
              ],
            ),
          ),
          content: new Text("Only Call in Case of Emergency"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                launch("tel://6236800497");
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPage() {
    final Size screenSize = MediaQuery.of(context).size;
    if (_loading) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return new Container(
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
                            icon: new Icon(Icons.add,
                                size: screenSize.height * 0.05),
                            onPressed: () => onPressed("/AddAlertPage"),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            new Container(
              height: screenSize.height * 0.82,
              width: screenSize.width,
              color: Colors.blue,
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: new PreferredSize(
                    preferredSize: Size.fromHeight(kToolbarHeight),
                    child: new Container(
                      color: Colors.blue,
                      child: TabBar(tabs: [
                        Tab(
                          text: "Active Alert",
                        ),
                        Tab(
                          text: "My Alerts",
                        ),
                      ]),
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      new Container(
                          height: screenSize.height * 0.7,
                          width: screenSize.width,
                          child: new SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            //onRefresh: _onRefresh,
                            child: new ListView.builder(
                              itemCount: alerts.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return new Container(
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new MaterialButton(
                                        minWidth: screenSize.width,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    new AlertDetailsScreen(
                                                        alertId: int.parse(
                                                            alerts[index].id)),
                                              ));
                                        },
                                        child: new Container(
                                            width: screenSize.width,
                                            margin: const EdgeInsets.only(
                                                top: 15.0,
                                                bottom: 15.0,
                                                right: 10.0,
                                                left: 10.0),
                                            child: new Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(
                                                  alerts[index].title,
                                                  style: new TextStyle(
                                                    fontFamily: "Roboto",
                                                    fontSize: 20.0,
                                                    color: myBgColors[int.parse(
                                                            alerts[index]
                                                                .severityLevel)]
                                                        .color,
                                                  ),
                                                ),
                                                new Text(
                                                    alerts[index].description),
                                                new Text(
                                                    alerts[index].scheduleAt),
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )),
                      new Container(
                        height: screenSize.height * 0.7,
                        width: screenSize.width,
                        color: Colors.blueGrey[50],
                        child: new ListView.builder(
                          itemCount: userAppAlerts.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return new Container(
                                height: screenSize.height * 0.08,
                                width: screenSize.width,
                                margin: const EdgeInsets.only(bottom: 15.0),
                                color: Colors.white,
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      margin: const EdgeInsets.all(10.0),
                                      child: new Text(
                                        userAppAlerts[index].message,
                                        style: new TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 20.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            new Container(
              height: screenSize.height * 0.08,
              width: screenSize.width,
              child: new Row(
                children: <Widget>[
                  new MaterialButton(
                    height: screenSize.height * 0.08,
                    minWidth: screenSize.width * 0.49,
                    elevation: 4.0,
                    // padding: const EdgeInsets.all(8.0),
                    color: Colors.red,
                    onPressed: () => call911(),
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
                    height: screenSize.height * 0.08,
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(body: _buildPage()),
    );
  }
}
