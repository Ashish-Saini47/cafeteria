import 'dart:async';

import 'package:cafe/AllScreens/MainPage.dart';
import 'package:cafe/Globalvariable.dart';
import 'package:cafe/widgets/BrandDivider.dart';
import 'package:cafe/widgets/ProgressDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MailVerification extends StatefulWidget {

  final String name;
  final String email;
  final String phone;
  final String password;
  MailVerification({
    this.email,
    this.phone,
    this.password,
    this.name
});

  @override
  _MailVerificationState createState() => _MailVerificationState();
}

class _MailVerificationState extends State<MailVerification> {

  final FirebaseAuth auth =FirebaseAuth.instance;
  User user;
  Timer timer;



  @override
  void initState() {
    // TODO: implement initState
    user = auth.currentUser;
    user.sendEmailVerification();
    timer = Timer.periodic((Duration(seconds: 30)), (timer) {
    checkMailVerification();

    });

    super.initState();
  }
Future<void> checkMailVerification() async {
    user=auth.currentUser;
    await user.reload();
    if(user.emailVerified){
      print('user is verified');
    timer.cancel();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainPage()));
    }
}

  // void registerUser() async{
  //
  //
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) => ProgressDialog(status: "Registering you in",),
  //   );
  //
  //
  //   final User user = (await _auth.createUserWithEmailAndPassword(
  //       email:widget.email,
  //       password: widget.password).catchError((ex){
  //     Navigator.pop(context);
  //
  //     FirebaseAuthException thisEx = ex;
  //     // showSnackBar(thisEx.message);
  //   })).user;
  //   if(user != null){
  //     DatabaseReference newUserRef = FirebaseDatabase.instance.reference().child('user/${user.uid}');
  //     Map userMap={
  //       'fullname':widget.name,
  //       'email':widget.email,
  //       'phone':widget.phone,
  //
  //
  //     };
  //     newUserRef.set(userMap);
  //
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));
  //
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: Center(child: Image.asset('images/email.png', height: 200, width: 200,))),
          
            Text('Email Confirmation', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.lightGreen),),

            SizedBox(height: 10,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal:20 ),
              child: RichText(
                  textAlign: TextAlign.center,
                  text:TextSpan(

                children: [

                  TextSpan(
                      text: "We have sent email to ",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextSpan(
                    text: user.email,

                    style:TextStyle(color: Colors.lightGreen, fontSize: 16)
                  ),
                  TextSpan(
                      text: ' to confirm the validity of your email address. After receiving the email follow the link provided to complete your registration',

                      style:TextStyle(color: Colors.grey, fontSize: 16)
                  ),



                ]
              ) ),
            ),

            SizedBox(height: 80,),
            BrandDivider(),
            SizedBox(height: 30,),
            FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> MailVerification()));

            },
                child:RichText(
                    textAlign: TextAlign.center,
                    text:TextSpan(
                        children: [
                          TextSpan(
                              text: "If you not got any mail. ",
                              style: TextStyle(color: Colors.grey, fontSize: 15)),
                          TextSpan(
                              text: 'Resend confirmation Mail',

                              style:TextStyle(color: Colors.blueAccent, fontSize: 15)
                          ),

                        ]
                    )), ),

            // Text('If you not got any mail Resend confirmation Mail', style: TextStyle(color: Colors.blueAccent, fontSize: 15),
            // textAlign: TextAlign.center,),
            SizedBox(height: 100,)

          ],
        ),
      ),
    );
  }
}
