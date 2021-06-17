import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisSize: MainAxisSize.min,
          children:[

            Center(child: Text('No Internet', style: TextStyle(fontSize: 25, color: Colors.brown),)),

            SizedBox(height: 50,),
            Center(child: Image.asset('images/internet.png', height: 250, width: 250,)),
            SizedBox(height: 50,),
            Text('Please check your connection again, or connect to Wifi', style: TextStyle(fontSize: 15, color: Colors.brown),)
            ]

          ),
        ),
      ),
    );
  }
}
