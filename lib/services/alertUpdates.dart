import 'dart:async';

import 'picture.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';


class AlertUpdate {
  String id;
  String message;
  String time;
  String alertId;





  AlertUpdate({ this.id, this.message, this.time, this.alertId});
  factory AlertUpdate.fromJson(Map<String, dynamic> json) => _$AlertUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$AlertUpdateToJson(this);
}



AlertUpdate _$AlertUpdateFromJson(Map<String, dynamic> json) {
  return AlertUpdate(
      id: json['id'] as String,
      message: json['message'] as String,
      time: json['time'] as String,
      alertId: json['alertId'] as String);
      
}

Map<String, dynamic> _$AlertUpdateToJson(AlertUpdate instance) => <String, dynamic>{
  "id": instance.id,
  "message": instance.message,
  "time": instance.time,
  "alertId": instance.alertId,
  
};


  List<AlertUpdate> parseAlertUpdates(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<AlertUpdate>((json) => AlertUpdate.fromJson(json)).toList();
}




class AlertUpdates {





  Future<List<AlertUpdate>> getAlertUpdates(String id) async {
    var client = new http.Client();
    var url = "http://ems.wingilariverit.com/alertApi/alerts_updates/getAlertUpdate.php";

    var result = "";
    AlertUpdate alert = new AlertUpdate();
    alert.alertId = id;
    var jsonAlert = json.encode(alert);
    await client.post(url, body: jsonAlert).then((response) => result = response.body);

    List<AlertUpdate> alerts = [];
    if (result != "0") {
      alerts = parseAlertUpdates(result);
    }

    return alerts; 
  }




  



  

}