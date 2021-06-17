
// @dart=2.7
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodzone/Allscreens/LoginPage.dart';
import 'package:foodzone/Allscreens/MainPage.dart';
import 'package:foodzone/Allscreens/RegistrationPage.dart';

import 'Globalvariable.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? const FirebaseOptions(
      appId: '1:297855924061:ios:c6de2b69b03a5be8',
      apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
      projectId: 'flutter-firebase-plugins',
      messagingSenderId: '297855924061',
      databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
    )
        : const FirebaseOptions(
      appId: '1:754524556544:android:c15baff46b184d56a8b7e5',
      apiKey: 'AIzaSyAKN5K31GaKq6MCy7zumzjl-ID3TcbZq0Q',
      messagingSenderId: '754524556544',
      projectId: 'cafe-91e9f',
      databaseURL: 'https://cafe-91e9f-default-rtdb.firebaseio.com/',
    ),
  );

  currentFirebaseUser = await FirebaseAuth.instance.currentUser;



  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'TextFont',
        primarySwatch: Colors.blue,
      ),
    initialRoute: (currentFirebaseUser != null)?MainPage.id : LoginPage.id,
    routes: {
    RegistrationPage.id:(context) => RegistrationPage(),
    LoginPage.id:(context) => LoginPage(),
    MainPage.id:(context) => MainPage(),},
    );
  }
}
