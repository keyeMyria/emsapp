import 'package:flutter/material.dart';
import 'package:emsapp/theme/style.dart';
import 'style.dart';
import 'package:emsapp/services/alerts.dart';
import 'package:emsapp/services/alertUpdates.dart';

import 'package:flutter/material.dart';
import 'package:map_view/figure_joint_type.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/polygon.dart';
import 'package:map_view/polyline.dart';
import 'package:url_launcher/url_launcher.dart';

class _MyColor {
  const _MyColor(this.color, this.name);

  final Color color;
  final String name;
}

class AlertDetailsScreen extends StatefulWidget {
  const AlertDetailsScreen({Key key, this.alertId}) : super(key: key);

  final int alertId;
  @override
  AlertDetailsScreenState createState() => AlertDetailsScreenState();
}

class AlertDetailsScreenState extends State<AlertDetailsScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Alerts rest = new Alerts();
  AlertUpdates alertUpdates = new AlertUpdates();
  ScrollController scrollController = new ScrollController();
  Choice _selectedChoice = choices[0];

  @override
  void initState() {
    super.initState();
    getAlert();
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

  Alert alert = new Alert();
  List<AlertUpdate> alertUpdate = [];
  getAlert() async {
    //gets alert
    Alert test = await rest.getAlert(widget.alertId.toString());

    //gets alert updates
    List<AlertUpdate> testing =
        await alertUpdates.getAlertUpdates(widget.alertId.toString());
    setState(() {
      alert = test;
      alertUpdate = testing;
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
                color: myBgColors[int.parse(alert.severityLevel)].color,
                child: AppBar(
                  title: MaterialButton(
                    onPressed: () => onPressed("/HomePage"),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Container(
                          margin:
                              EdgeInsets.only(right: screenSize.width * 0.1),
                          child: new Text(
                            alert.title,
                            style: new TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        new Container(
                          child: new Text(
                            alert.scheduleAt,
                            textAlign: TextAlign.end,
                            style: new TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
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
                  height: screenSize.height * 0.4,
                  width: screenSize.width,
                  color: Colors.black,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(
                        "Google maps placeholder",
                        style: new TextStyle(
                          fontFamily: "Roboto",
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  )),
              new Container(
                height: screenSize.height * 0.15,
                width: screenSize.width,
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 20.0, left: 15.0, right: 15.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      alert.description,
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                        fontFamily: "Roboto",
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                height: screenSize.height * 0.1,
                width: screenSize.width,
                child: ListTile(
                  title: new Text(
                    alert.message,
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      fontFamily: "Roboto",
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: new Text(""),
                  leading: Icon(
                    Icons.info,
                    color: Colors.black,
                    size: screenSize.height * 0.05,
                  ),
                ),
              ),
              new Container(
                height: screenSize.height * 0.17,
                width: screenSize.width,
                color: Colors.white,
                child: new ListView.builder(
                  itemCount: alertUpdate.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return new Container(
                        child: new Column(
                      children: <Widget>[
                        new Container(
                          child: new Text(
                            alertUpdate[index].message,
                            style: new TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        new Container(
                          child: new Text(
                            alertUpdate[index].time,
                            style: new TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ));

                    // return new Text(alerts[index].title);
                  },
                ),
              ),
              new Container(
                height: screenSize.height * 0.08,
                width: screenSize.width,
                child: new MaterialButton(
                  //height: screenSize.height * 0.07,
                  minWidth: screenSize.width,
                  elevation: 4.0,
                  // padding: const EdgeInsets.all(8.0),
                  color: Colors.blue,
                  onPressed: () => launch("tel://6236800497"),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text(
                        'REPORT AN ISSUE',
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
      ),
    );
  }
}
