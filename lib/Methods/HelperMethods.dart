import 'dart:convert';

import 'package:cafe/Globalvariable.dart';
import 'package:cafe/datamodels/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HelperMethods{
  static void getCurrentUserInfo() async{
    currentFirebaseUser = await FirebaseAuth.instance.currentUser;
    String userid = currentFirebaseUser.uid;
    DatabaseReference userRef = FirebaseDatabase.instance.reference().child('user/$userid');
    userRef.once().then((DataSnapshot snapshot){
      if(snapshot.value !=null){
        currentUserInfo = user.fromSnapshot(snapshot);
        userName = currentUserInfo.fullName;
        print('my name is ${currentUserInfo.fullName}');

      }
    });


  }
  static void getAmount() async{
    DatabaseReference amtRef = await FirebaseDatabase.instance.reference().child('user/${currentFirebaseUser.uid}');
    amtRef.once().then((DataSnapshot snapshot){
      if(snapshot != null){
        amount= snapshot.value['amount'];
        print(amount);
      }
    });
  }
  static sendNotification(String token, context, String orderId) async{

print(orderId);


    Map<String, String> headerMap={
      'Content-Type': 'application/json',
      'Authorization': serverKey,
    };

    Map notificationMap ={
      'title': 'NEW Order REQUEST',
      'body': "New Order"
    };

    Map dataMap ={
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'order_id': orderId,

    };

    Map bodyMap = {
      'notification':notificationMap,
      'data': dataMap,
      'priority': 'high',
      'to':token,
    };
    String uri ='https://fcm.googleapis.com/fcm/send';
    Uri url =Uri.parse(uri);
    var response = await http.post(
      url,
      headers: headerMap,
      body: jsonEncode(bodyMap),

    );

    print(response.body);

  }




}
