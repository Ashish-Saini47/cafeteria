import 'package:cafe/AllScreens/MainPage.dart';
import 'package:cafe/AllScreens/TeaPage.dart';
import 'package:cafe/Globalvariable.dart';
import 'package:cafe/Methods/HelperMethods.dart';

import 'package:cafe/datamodels/user.dart';
import 'package:cafe/widgets/Button.dart';
import 'package:cafe/widgets/OrderNotification.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class TeaOrder extends StatefulWidget {
  @override
  _TeaOrderState createState() => _TeaOrderState();
}

class _TeaOrderState extends State<TeaOrder> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackBar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15), ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var staffIdController = TextEditingController();
  var roomController = TextEditingController();

  String roomNo;

  @override
  Widget build(BuildContext context) {


    DatabaseReference userRef = FirebaseDatabase.instance.reference().child('user/${currentFirebaseUser.uid}');
    userRef.once().then((DataSnapshot snapshot){
      if(snapshot.value != null){
        currentUserInfo = user.fromSnapshot(snapshot);
        print('my name is ${currentUserInfo.fullName}');


      }
    });





      String fullName =  currentUserInfo.fullName;
      String phone = currentUserInfo.phone;

      nameController.text=fullName;
      phoneController.text=phone;



    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    // color: Colors.grey,
                    // height: 100,
                    // width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 20),
                      child: Row(

                          children:[
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> Tea()));

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5.0,
                                      spreadRadius: 0.5,
                                      offset: Offset(
                                        0.7,
                                        0.7,
                                      ),
                                    )
                                  ],

                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: Icon(Icons.arrow_back, color: Colors.black87,),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Text(
                                'Tea Order Details',

                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,),
                              ),
                            )

                          ]


                      ),

                    ),
                  ),
                  SizedBox(height: 40,),

                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Text(
                                    'Name :',
                                    style: TextStyle(fontWeight:FontWeight.bold, fontSize: 16),
                                  ),
                                  Container(
                                    width: 180,
                                    child: TextField(
                                      controller: nameController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(

                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.0,
                                        ),

                                      ),

                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Phone :',
                                    style: TextStyle(fontWeight:FontWeight.bold, fontSize: 16),
                                  ),

                                  Container(
                                    width: 180,
                                    child: TextField(
                                      controller: phoneController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: "",
                                        labelStyle: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10.0,
                                        ),


                                      ),

                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            SizedBox(height: 10,),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Room NO:',
                                    style: TextStyle(fontWeight:FontWeight.bold, fontSize: 16),
                                  ),

                                  Container(
                                    width: 180,
                                    child: TextField(
                                      controller: roomController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: "Room Number",
                                        labelStyle: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10.0,
                                        ),


                                      ),

                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                            SizedBox(height: 10,),


                           //tea
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ' Total NO\'s Tea',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  Text(teaCount.toString(),
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            //black tea

                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ' Total NO\'s Black Tea',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  Text(blackTeaCount.toString(),
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),

                            // lemon
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ' Total NO\'s Lemon Tea',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  Text(lemonTeaCount.toString(),
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),

                            // coffee
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ' Total NO\'s Coffee',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  Text(coffeeCount.toString(),
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),

                            // withoutSugar
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ' Total NO\'s Without Sugar Tea',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  Text(withOutSugarCount.toString(),
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),

                            // green tea
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ' Total NO\'s Green Tea',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  Text(greenTeaCount.toString(),
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),


                            SizedBox(height: 20,),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Payment:',
                                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                  ),
                                  Text(teaFares().toString(),
                                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),

                            SizedBox(height:25,),

                            OwnButton(
                              title: 'Place Order',
                              color: Colors.brown[300],
                              onPressed: (){

                                roomNo =roomController.text;
                                if(nameController.text ==null){
                                  showSnackBar('Enter your Name');
                                  return;
                                }
                                else if (phoneController.text ==null){
                                  showSnackBar('Enter your phone number');
                                  return;
                                }
                                else if(roomController.text.length < 0){
                                  showSnackBar('Enter your room number');
                                  return;
                                }

                                else{
                                  int tempAmt = amount -teaFares();
                                  if(tempAmt>0){
                                    amount = amount -teaFares();
                                    DatabaseReference amtRef = FirebaseDatabase.instance.reference().child('user/${currentFirebaseUser.uid}/amount');
                                    amtRef.set(amount);

                                  saveTea(roomNo);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));
                                  showDialog(context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context)=>OrderNotification());
                                  }

                                  reset();
                                }

                              },
                            ),
                            SizedBox(height: 10,)
                          ],

                        ),
                      ),
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
  void reset(){
    teaCount = 0;
    coffeeCount = 0;
    greenTeaCount = 0;
    blackTeaCount = 0;
    lemonTeaCount = 0;
    greenTeaCount = 0;
  }
  void saveTea(roomNo){
    DatabaseReference teaRef = FirebaseDatabase.instance.reference().child('order').push();


    Map teaDetails ={
      'green_tea':greenTeaCount,
      'tea':teaCount,
      'black_tea':blackTeaCount,
      'coffee':coffeeCount,
      'without_sugar':withOutSugarCount,
      'lemon_tea':lemonTeaCount,
      'payment':teaFares().toString(),
      'room':roomController.text,
      'name':nameController.text,
'user_id': currentFirebaseUser.uid,
      'phone':phoneController.text,
      'status':'Waiting',
      'created_at':DateTime.now().toString(),
    };

    teaRef.set(teaDetails);



    DatabaseReference tokenRef = FirebaseDatabase.instance.reference().child('/cafe/7HwxFcg8aMdQJ1Nx9AygnkJcH3W2/token');
    tokenRef.once().then((DataSnapshot snapshot){
      if(snapshot.value != null){
        String token= snapshot.value.toString();
        HelperMethods.sendNotification(token, context, (teaRef.key).toString());

      }
      else{
        return;
      }

    });



  }
  int teaFares(){
    int teaCounts= teaCount + blackTeaCount + lemonTeaCount + withOutSugarCount +coffeeCount;
    int teaPayment = greenTeaCount*10 + teaCounts*5;
    return teaPayment;

  }

}




