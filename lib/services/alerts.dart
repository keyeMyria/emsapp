import 'dart:async';

import 'picture.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';


class Alert {
  String id;
  String title;
  String message;
  String severityLevel;
  String description;
  String scheduleAt;
  String updatedAt;
  String latitude;
  String longitude;




  Alert({ this.id, this.title, this.message, this.severityLevel, this.description, this.scheduleAt, this.updatedAt, this.latitude, this.longitude});
  factory Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);
  Map<String, dynamic> toJson() => _$AlertToJson(this);
}



Alert _$AlertFromJson(Map<String, dynamic> json) {
  return Alert(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      severityLevel: json['severityLevel'] as String,
      description: json['description'] as String,
      scheduleAt: json['scheduleAt'] as String,
      updatedAt: json['updatedAt'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String);
      
}

Map<String, dynamic> _$AlertToJson(Alert instance) => <String, dynamic>{
  "id": instance.id,
  "title": instance.title,
  "message": instance.message,
  "severityLevel": instance.severityLevel,
  "description": instance.description,
  "scheduleAt": instance.scheduleAt,
  "updatedAt": instance.updatedAt,
  "latitude": instance.latitude,
  "longitude": instance.longitude,
  
};


  List<Alert> parseAlerts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Alert>((json) => Alert.fromJson(json)).toList();
}




class Alerts {



  Future<List<Alert>> getAlerts() async {
    var client = new http.Client();
    //List<UserProfile> test = await fetchUserProfiles(client);
    var response =
      await client.get("http://ems.wingilariverit.com/alertApi/alerts/read.php");
    //final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
    List<Alert> alerts = parseAlerts(response.body);

    return alerts;
  }


  Future<Alert> getAlert(String id) async {
    var client = new http.Client();
    var url = "http://ems.wingilariverit.com/alertApi/alerts/getAlertById.php";

    //List<UserProfile> test = await fetchUserProfiles(client);
    var result = "";
    Alert alert = new Alert();
    alert.id = id;
    var jsonAlert = json.encode(alert);
    await client.post(url, body: jsonAlert).then((response) => result = response.body);

    List<Alert> alerts = parseAlerts(result);
    Alert results = alerts[0];

    return results;
  }


  Future<String> createAlert(Alert newAlert) async {
    var client = new http.Client();
    //List<UserProfile> test = await fetchUserProfiles(client);

    var url = "http://ems.wingilariverit.com/alertApi/alerts/create.php";
    

    Position position = await Geolocator().getCurrentPosition(LocationAccuracy.high);

    Alert alert = new Alert();
    alert.longitude = position.longitude.toString();
    alert.latitude = position.latitude.toString();
    alert.message = newAlert.message;
    var jsonAlert = json.encode(alert);
    var result = "test";
    await client.post(url, body: jsonAlert).then((response) => result = response.body);
    print(result);

    return "alert";
  }


  



  

}