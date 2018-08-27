import 'dart:async';

import 'picture.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:emsapp/services/globals.dart' as globals;

class AppAlert {
  String id;
  String badgeNo;
  String latitude;
  String longitude;
  String message;
  String image;
  String isRead;
  String isApproved;
  String time;




  AppAlert({ this.id, this.badgeNo, this.latitude, this.longitude, this.message, this.image, this.isRead, this.isApproved, this.time});
  factory AppAlert.fromJson(Map<String, dynamic> json) => _$AppAlertFromJson(json);
  Map<String, dynamic> toJson() => _$AppAlertToJson(this);
}



AppAlert _$AppAlertFromJson(Map<String, dynamic> json) {
  return AppAlert(
      id: json['id'] as String,
      badgeNo: json['badgeNo'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      message: json['message'] as String,
      image: json['image'] as String,
      isRead: json['isRead'] as String,
      isApproved: json['isApproved'] as String,
      time: json['time'] as String);
      
}

Map<String, dynamic> _$AppAlertToJson(AppAlert instance) => <String, dynamic>{
  "id": instance.id,
  "badgeNo": instance.badgeNo,
  "latitude": instance.latitude,
  "longitude": instance.longitude,
  "message": instance.message,
  "image": instance.image,
  "isRead": instance.isRead,
  "isApproved": instance.isApproved,
  "time": instance.time,
  
};


  List<AppAlert> parseAppAlerts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<AppAlert>((json) => AppAlert.fromJson(json)).toList();
}




class AppAlerts {



  Future<List<AppAlert>> getAlertsByBadge() async {
    var client = new http.Client();
    //List<UserProfile> test = await fetchUserProfiles(client);
    AppAlert alert = new AppAlert();
    alert.badgeNo = globals.badge;
    
    var url = "http://ems.wingilariverit.com/alertApi/appUser_alerts/getAlertByBadge.php";
    
    var jsonAlert = json.encode(alert);
    var result = "test";
    await client.post(url, body: jsonAlert).then((response) => result = response.body);

    List<AppAlert> alerts = [];
    if(result == 0) {
      alerts = [];
    }
    else {
      alerts = parseAppAlerts(result);
    }
      
    
    return alerts;
  }




  Future<AppAlert> getAlert() async {
    var client = new http.Client();
    //List<UserProfile> test = await fetchUserProfiles(client);
    var response =
      await client.get("http://ems.wingilariverit.com/alertApi/alerts/read.php");
    //final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
    List<AppAlert> alerts = parseAppAlerts(response.body);
    AppAlert alert = alerts[0];
    print(alerts.toString());
    return alert;
  }


  Future<String> createAlert(AppAlert newAlert) async {
    var client = new http.Client();
    //List<UserProfile> test = await fetchUserProfiles(client);

    var url = "http://ems.wingilariverit.com/alertApi/appUser_alerts/create.php";
    

    Position position = await Geolocator().getCurrentPosition(LocationAccuracy.high);

    AppAlert alert = new AppAlert();
    alert.longitude = position.longitude.toString();
    alert.latitude = position.latitude.toString();
    alert.message = newAlert.message;
    alert.badgeNo = globals.badge;
    alert.time = new DateTime.now().toString();
    alert.isRead = "0";
    alert.isApproved = "0";
    var jsonAlert = json.encode(alert);
    var result = "test";
    await client.post(url, body: jsonAlert).then((response) => result = response.body);
    print(result);

    return "alert";
  }


  



  

}