import 'package:flutter/material.dart';
import 'package:emsapp/screens/Login/index.dart';
import 'package:emsapp/screens/Home/index.dart';
import 'package:emsapp/screens/StartScreen/index.dart';
import 'package:emsapp/screens/AddAlert/index.dart';
import 'package:emsapp/screens/Security/index.dart';
import 'package:emsapp/screens/AlertDetails/index.dart';
import 'package:emsapp/theme/style.dart';

import 'package:emsapp/services/users.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:emsapp/services/globals.dart' as globals;

class Routes {
  User user = new User();
  
  var routes = <String, WidgetBuilder>{
    "/LoginPage": (BuildContext context) => new LoginScreen(),
    "/HomePage": (BuildContext context) => new HomeScreen(),
    "/StartPage": (BuildContext context) => new StartScreen(),
    "/AddAlertPage": (BuildContext context) => new AddAlertScreen(),
    "/AlertDetailsPage": (BuildContext context) => new AlertDetailsScreen(),
    "/SecurityPage": (BuildContext context) => new SecurityScreen(),
  };

  Routes() {
    user.compareDeviceId().then((onValue) {
      if (onValue.toString() == "0") {
        runApp(new MaterialApp(
          title: "Flutter Flat App",
          home: new StartScreen(),
          theme: appTheme,
          routes: routes,
        ));
      } else {
        globals.badge = onValue.toString();
        runApp(new MaterialApp(
          title: "Flutter Flat App",
          home: new HomeScreen(),
          theme: appTheme,
          routes: routes,
        ));
      }
    });
  }
}
