import 'package:cafe/AllScreens/LoginPage.dart';
import 'package:cafe/widgets/Button.dart';
import 'package:cafe/widgets/OutlineButton.dart';
import 'package:cafe/widgets/ResetNotification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackBar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15), ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  final FirebaseAuth auth =FirebaseAuth.instance;
  String email;
  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Widget build(BuildContext context) {


    return Scaffold(
      key: scaffoldKey,
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Forgot Password ?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.brown[300]),
            )),
            SizedBox(height: 30,),
            Column(
              children: [
                TextField(

                    keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      // icon: Icon(Icons.email),
                    labelText: 'Enter your mail',
                      labelStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.brown[300]
                      ),

                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(15),


                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.brown[300],),

                  ),
                  onChanged: (value){
                      setState(() {
                        email=value;
                      });
                  },
                 ),
                SizedBox(height: 20,),
                OwnButton(
                  title: 'Reset Password',
                  color: Colors.brown[300],
                  onPressed: (){
                    print(email);

                  resetPassword(email);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
    showDialog(

    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => ResetNotification());

                   print("mail has been send");
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
