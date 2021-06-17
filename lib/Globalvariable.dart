
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodzone/DataModels/OrderDetails.dart';
// int teaCount = 0;
//
// int coffeeCount = 0;
//
// int blackTeaCount = 0;
//
// int greenTeaCount = 0;
//
// int withOutSugarCount = 0;
//
// int lemonTeaCount = 0;
// int snacksCount=0;
User currentFirebaseUser;
// user currentUserInfo;
List<OrderDetails> order = [];
List orderHistory=[];


String serverKey = 'key=AAAAr60rDQA:APA91bGCaaYYNLlamXWlGHZz1WbK4140i9Ny2g6s94NsLAbh2mBSpE9v4pMJgza1H_Nt8rfSxq8Otm0mKm6Qiaz3OWSHtd1MPyLZo4Lb5pogAq4X_8XqHUTUqq13oykPC989VWbZiPhp';