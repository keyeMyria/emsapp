import 'dart:async';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_udid/flutter_udid.dart';


class UserProfile {
  String id;
  String lastName;
  String firstName;
  String badge;
  String location;
  String department;
  String deviceId;
  String departmentId;
  String status;
  String doh;
  String shift;
  String jobTitle;
  String lastLogin;


  

  UserProfile({ this.id, this.lastName, this.firstName, this.badge, this.location, this.department, this.deviceId, this.departmentId, this.status, this.doh, this.shift, this.jobTitle, this.lastLogin});
  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}



UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile(
      id: json['id'] as String,
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      badge: json['badge'] as String,
      location: json['location'] as String,
      department: json['department'] as String,
      deviceId: json['deviceId'] as String,
      departmentId: json['departmentId'] as String,
      status: json['status'] as String,
      doh: json['doh'] as String,
      shift: json['shift'] as String,
      jobTitle: json['jobTitle'] as String,
      lastLogin: json['lastLogin'] as String
      );
      
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) => <String, dynamic>{
  "id": instance.id,
  "lastName": instance.lastName,
  "firstName": instance.firstName,
  "badge": instance.badge,
  "location": instance.location,
  "department": instance.department,
  "deviceId": instance.deviceId,
  "departmentId": instance.departmentId,
  "status": instance.status,
  "doh": instance.doh,
  "shift": instance.shift,
  "jobTitle": instance.jobTitle,
  "lastLogin": instance.lastLogin,
  
};


  List<UserProfile> parseUserProfile(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<UserProfile>((json) => UserProfile.fromJson(json)).toList();
}

















class User {

  String deviceId = "unknown device id";

  Future<List<UserProfile>> getProfiles() async {
    var client = new http.Client();
    //List<UserProfile> test = await fetchUserProfiles(client);
    var response =
      await client.get("http://ems.wingilariverit.com/alertApi/alerts/read.php");
    //final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
    List<UserProfile> alerts = parseUserProfile(response.body);
    print(alerts.toString());
    return alerts;
  }


  Future<UserProfile> getProfile() async {
    var client = new http.Client();
    //List<UserProfile> test = await fetchUserProfiles(client);
    var response =
      await client.get("http://ems.wingilariverit.com/alertApi/alerts/read.php");
    //final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
    List<UserProfile> alerts = parseUserProfile(response.body);
    UserProfile alert = alerts[0];
    print(alerts.toString());
    return alert;
  }

  Future<String> login(UserProfile user) async {

    var results = '';
    var exists = await checkUser(user);

    if (exists.toString() == '0') {
      results = "Badge Number or last name does not exist.";

    }

    else {
      var device = await checkDeviceId(user);
      print(device);
      if (device.toString() == "0") {
        
        results = "The account is registered to another device.";
        print(results);
      }

      else {
        var client = new http.Client();
        //List<UserProfile> test = await fetchUserProfiles(client);
        var url = "http://ems.wingilariverit.com/alertApi/app_users/create.php";
        UserProfile currentUser = new UserProfile();

        currentUser.badge = user.badge;
        currentUser.lastName = user.lastName;
        currentUser.lastLogin = new DateTime.now().toString();
        currentUser.deviceId = await getDeviceId();
        var jsonUser = json.encode(currentUser);
        var result = "test";
        await client.post(url, body: jsonUser).then((response) => result = response.body);
        print(results);
        results = "Login Successful";
      }
    }

    return results; 
  }

  Future<String> checkUser(UserProfile user) async {
    var client = new http.Client();
    //List<UserProfile> test = await fetchUserProfiles(client);
    var url = "http://ems.wingilariverit.com/alertApi/app_users/checkUser.php";
    UserProfile currentUser = new UserProfile();

    currentUser.badge = user.badge;
    currentUser.lastName = user.lastName;
    var jsonUser = json.encode(currentUser);
    var result = "test";
    await client.post(url, body: jsonUser).then((response) => result = response.body);

    return result; 
  }

  Future<String> checkDeviceId(UserProfile user) async {
    var client = new http.Client();
    //List<UserProfile> test = await fetchUserProfiles(client);
    var url = "http://ems.wingilariverit.com/alertApi/app_users/deviceId.php";
    UserProfile currentUser = new UserProfile();

    currentUser.badge = user.badge;
    currentUser.lastName = user.lastName;
    var jsonUser = json.encode(currentUser);
    var result = "test";
    await client.post(url, body: jsonUser).then((response) => result = response.body);

    return result; 
  }


  Future<String> getDeviceId() async {
    String udid = await FlutterUdid.consistentUdid;
    return udid;
  }


  Future<String> compareDeviceId() async {
    var client = new http.Client();
    //List<UserProfile> test = await fetchUserProfiles(client);
    var url = "http://ems.wingilariverit.com/alertApi/app_users/compareDevice.php";
    UserProfile currentUser = new UserProfile();

    currentUser.deviceId = await getDeviceId();
    var jsonUser = json.encode(currentUser);
    var result = "test";
    await client.post(url, body: jsonUser).then((response) => result = response.body);
    
    var results = "";
    if (result == "0") {
      results = "0";

    }
    else {
      List<UserProfile> alerts = parseUserProfile(result);
      UserProfile alert = alerts[0];
      results = alert.badge.toString();
    }

    return results; 
  }






  

}