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
import 'dart:async';


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

  MapView mapView = new MapView();
  static var apiKey = "AIzaSyAxGHVmvf8XmsN5axn7RHm0aO8lNZKsWYQ";
  CameraPosition cameraPosition;
  var compositeSubscription = new CompositeSubscription();
  var staticMapProvider = new StaticMapProvider(apiKey);
  Uri staticMapUri;

  bool _loading;
  @override
  void initState() {
    _loading = true;

    super.initState();

    getAlert().then((result) {
      setState(() {
        _loading = false;
        MapView.setApiKey(apiKey);
        cameraPosition = new CameraPosition(Locations.portland, 2.0);
        staticMapUri = staticMapProvider.getStaticUri(Locations.portland, 12,
            width: 900, height: 400, mapType: StaticMapViewType.roadmap);
      });
    });
  }

  showMap() {
    var staticMapProvider = new StaticMapProvider(apiKey);
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition: new CameraPosition(
                new Location(45.5235258, -122.6732493), 14.0),
            title: "Recently Visited"),
        toolbarActions: [new ToolbarAction("Close", 1)]);
  }

  _handleDismiss() async {
    double zoomLevel = await mapView.zoomLevel;
    Location centerLocation = await mapView.centerLocation;
    List<Marker> visibleAnnotations = await mapView.visibleAnnotations;
    print("Zoom Level: $zoomLevel");
    print("Center: $centerLocation");
    print("Visible Annotation Count: ${visibleAnnotations.length}");
    var uri = await staticMapProvider.getImageUriFromMap(mapView,
        width: 900, height: 400);
    setState(() => staticMapUri = uri);
    mapView.dismiss();
    compositeSubscription.cancel();
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

  Alert alert = new Alert();
  List<AlertUpdate> alertUpdate = [];
  getAlert() async {
    //gets alert
    Alert test = await rest.getAlert(widget.alertId.toString());

    //gets alert updates
    List<AlertUpdate> testing =
        await alertUpdates.getAlertUpdates(widget.alertId.toString());

    for (var i = 0; i < testing.length; i++) {
      if (testing[i].message == null) {
        testing[i].message = "No Message";
      }
    }
    setState(() {
      if (test.message == null) {
        test.message == "No Message";
      }

      if (test.title == null) {
        test.title == "No Title";
      }

      if (test.scheduleAt == null) {
        test.title == "No Time Known";
      }

      if (test.severityLevel == null) {
        test.severityLevel == "3";
      }

      if (test.latitude == null || test.longitude == null) {
        test.latitude == "90.0";
        test.longitude == "0.0";
      }

      alert = test;

      alertUpdate = testing;
    });
  }

  Widget description() {
    if (alert.description == null) {
      return new Text(
        "No Description Available",
        textAlign: TextAlign.left,
        style: new TextStyle(
          fontFamily: "Roboto",
          color: Colors.black,
          fontSize: 18.0,
        ),
      );
    } else {
      return new Text(
        alert.description,
        textAlign: TextAlign.left,
        style: new TextStyle(
          fontFamily: "Roboto",
          color: Colors.black,
          fontSize: 18.0,
        ),
      );
    }
  }

  Widget buildUpdates() {
    final Size screenSize = MediaQuery.of(context).size;
    if (alertUpdate.length == 0) {
      return new Text(
        "No Updates",
      );
    } else {
      return new ListView.builder(
        reverse: true,
        itemCount: alertUpdate.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 20.0),
              child: new Column(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.all(10.0),
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
        },
      );
    }
  }

  Widget _buildDetails() {
    final Size screenSize = MediaQuery.of(context).size;
    if (_loading) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return new SingleChildScrollView(
          child: new Container(
        height: screenSize.height,
        width: screenSize.width,
        child: new Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Container(
              height: screenSize.height * 0.1,
              width: screenSize.width,
              color: myBgColors[int.parse(alert.severityLevel)].color,
              child: MaterialButton(
                minWidth: screenSize.width,
                onPressed: () => onPressed("/HomePage"),
                child: new Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Container(
                      width: screenSize.width * 0.4,
                      margin: EdgeInsets.only(
                          top: screenSize.width * 0.1,
                          bottom: screenSize.width * 0.1),
                      child: new Text(
                        alert.title,
                        //textAlign: TextAlign.start,
                        style: new TextStyle(
                          fontFamily: "Roboto",
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    new Container(
                      width: screenSize.width * 0.45,
                      margin: EdgeInsets.only(
                          top: screenSize.width * 0.1,
                          bottom: screenSize.width * 0.1,
                          left: screenSize.width * 0.05),
                      child: new Text(
                        alert.scheduleAt,
                        textAlign: TextAlign.start,
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
            ),
            new Container(
              color: Colors.blueAccent,
              height: screenSize.height * 0.3,
              child: new Stack(
                children: <Widget>[
                  new Center(
                      child: new Container(
                    child: new Text(
                      "Maps Template Holder",
                      textAlign: TextAlign.center,
                    ),
                    padding: const EdgeInsets.all(20.0),
                  )),
                  new InkWell(
                      /*
                      child: new Center(
                        child: new Image.network(staticMapUri.toString()),
                      ),
                      
                    onTap: showMap(),
                    */
                      )
                ],
              ),
            ),

            new Container(
              height: screenSize.height * 0.15,
              width: screenSize.width,
              color: Colors.white,
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 20.0, left: 15.0, right: 15.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[description()],
              ),
            ),
            new Container(
              height: screenSize.height * 0.15,
              width: screenSize.width,
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 20.0, left: 15.0, right: 15.0),
              child: ListTile(
                title: new Text(
                  alert.message,
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.black,
                    fontSize: 15.0,
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

            //builds alert updates widget
            new Container(
              height: screenSize.height * 0.22,
              width: screenSize.width,
              color: Colors.white,

              // decoration:
              //    new BoxDecoration(border: new Border.all(color: Colors.grey)),
              child: buildUpdates(),
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
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(body: _buildDetails()),
    );
  }
}

class CompositeSubscription {
  Set<StreamSubscription> _subscriptions = new Set();

  void cancel() {
    for (var n in this._subscriptions) {
      n.cancel();
    }
    this._subscriptions = new Set();
  }

  void add(StreamSubscription subscription) {
    this._subscriptions.add(subscription);
  }

  void addAll(Iterable<StreamSubscription> subs) {
    _subscriptions.addAll(subs);
  }

  bool remove(StreamSubscription subscription) {
    return this._subscriptions.remove(subscription);
  }

  bool contains(StreamSubscription subscription) {
    return this._subscriptions.contains(subscription);
  }

  List<StreamSubscription> toList() {
    return this._subscriptions.toList();
  }
}
