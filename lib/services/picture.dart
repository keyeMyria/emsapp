import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';


class UserData {
  String displayName;
  String email;
  String uid;
  String password;

  UserData({this.displayName, this.email, this.uid, this.password});
}

class PhotoStorage {

  //final FirebaseStorage storage;

  Future<String> uploadPhoto(var image) async {


    var link = "testing";
   
     
    StorageUploadTask putFile = FirebaseStorage.instance.ref().child("AlertImages/").putFile(image);
    final url = (await putFile.future).downloadUrl;
    
    link = url.toString();

    return link;
    
    
    
  }

  Future<String> getPhoto() async {

    //var data = await FirebaseStorage.instance.ref().child("ProfileImages/").getData(99999999);
   // var text = new String.fromCharCodes(data);
    //return text;

    return "f";
  }

  
}
