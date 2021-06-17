import 'dart:convert';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:foodzone/Globalvariable.dart';

import 'package:http/http.dart' as http;

class HelperMethods{
  // static void getCurrentUserInfo() async{
  //   currentFirebaseUser = await FirebaseAuth.instance.currentUser;
  //   String userid = currentFirebaseUser.uid;
  //   DatabaseReference userRef = FirebaseDatabase.instance.reference().child('user/$userid');
  //   userRef.once().then((DataSnapshot snapshot){
  //     if(snapshot.value !=null){
  //       currentUserInfo = user.fromSnapshot(snapshot);
  //       print('my name is ${currentUserInfo.fullName}');
  //
  //     }
  //   });
  //
  //
  // }

  static sendDeleteNotification(String token, context, String orderId) async{

    print(orderId);


    Map<String, String> headerMap={
      'Content-Type': 'application/json',
      'Authorization': serverKey,
    };

    Map notificationMap ={
      'title': 'Your Order Rejected',
      'body': ""
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
  static sendAcceptNotification(String token, context, String orderId) async{

    print(orderId);


    Map<String, String> headerMap={
      'Content-Type': 'application/json',
      'Authorization': serverKey,
    };

    Map notificationMap ={
      'title': 'Your Order Accepted',
      'body': ""
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

  static getOrderHistory(){
    DatabaseReference orderHistoryRef = FirebaseDatabase.instance.reference().child('order');
    orderHistoryRef.once().then((DataSnapshot snapshot){
      if(snapshot.value != null){


        snapshot.value.forEach((key, value) => orderHistory.add(key));


        print('order history $orderHistory');
      }


    });

  }
  // static pendingOrder(){
  //   DatabaseReference orderHistoryRef = FirebaseDatabase.instance.reference().child('order');
  //   orderHistoryRef.once().then((DataSnapshot snapshot){
  //     if(snapshot.value != null){
  //       List history = [];
  //
  //       snapshot.value.forEach((key, value) => history.add(key));
  //       for(int i = 0; i<history.length;i++){
  //         DatabaseReference historyRef = FirebaseDatabase.instance.reference().child('/order/${history[i]}');
  //         historyRef.once().then((DataSnapshot snapshot){
  //           if(snapshot != null){
  //             if(snapshot.value['status'] =='Waiting'){
  //               fetchOrderDetails();
  //             }
  //           }
  //         });
  //       }
  //
  //       print('order history $history');
  //     }
  //
  //
  //   });
  //
  //
  // }

}