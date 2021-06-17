import 'package:cafe/AllScreens/LoginPage.dart';
import 'package:cafe/AllScreens/MailVerification.dart';
import 'package:cafe/AllScreens/MainPage.dart';
import 'package:cafe/widgets/Button.dart';
import 'package:cafe/widgets/ProgressDialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class RegistrationPage extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackBar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15), ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  final FirebaseAuth _auth =FirebaseAuth.instance;

  var fullNameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  void registerUser() async{


    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: "Registering you in",),
    );


    final User user = (await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text).catchError((ex){
      Navigator.pop(context);

      FirebaseAuthException thisEx = ex;
      showSnackBar(thisEx.message);
    })).user;
    if(user != null){
      DatabaseReference newUserRef = FirebaseDatabase.instance.reference().child('user/${user.uid}');
      Map userMap={
        'fullname':fullNameController.text,
        'email':emailController.text,
        'phone':phoneController.text,
        'amount':1000,

      };
      newUserRef.set(userMap);

      Navigator.push(context, MaterialPageRoute(builder: (context)=> MailVerification()));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height:50,),
                Image(
                  alignment: Alignment.center,
                  height: 200.0,
                  width: 200.0,
                  image:
                  AssetImage('images/logo.png'),
                ),
                // SizedBox(height: 40,),
                Text("Register As Staff Member",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: fullNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),


                        ),

                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10,),

                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),


                        ),

                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10,),

                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone No.",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),


                        ),

                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10,),

                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),


                        ),

                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 40,),

                      OwnButton(
                        title:'REGISTER',
                        color: Colors.brown[300],
                        onPressed: () async{

                          var connectivityResult= await Connectivity().checkConnectivity();
                          if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
                            showSnackBar("No internet Connection");
                          }

                          if(fullNameController.text.length<3 ){
                            showSnackBar("Pls provide a vaild user name");
                            return;
                          }
                          if(phoneController.text.length<10 ){
                            showSnackBar("Pls provide a vaild phone no.");
                            return;
                          }
                          if(!emailController.text.contains("@") ){
                            showSnackBar("Pls provide a valid email Address");
                            return;
                          }
                          if(passwordController.text.length<8 ){
                            showSnackBar("Pls provide a Eight digit password");
                            return;
                          }

                          registerUser();

                        },
                      ),
                    ],
                  ),
                ),

                FlatButton(
                    onPressed: (){


                    },
                    child: Text('Already have an account, login here')
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
