import 'package:cafe/AllScreens/LunchOrder.dart';
import 'package:cafe/AllScreens/MainPage.dart';
import 'package:cafe/Globalvariable.dart';
import 'package:cafe/Methods/HelperMethods.dart';
import 'package:cafe/widgets/Button.dart';
import 'package:cafe/widgets/OrderNotification.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LunchPage extends StatefulWidget {
  @override
  _LunchPageState createState() => _LunchPageState();
}

class _LunchPageState extends State<LunchPage> {

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

  var lunchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

      String fullName =   currentUserInfo.fullName;
      String phone =   currentUserInfo.phone;

      nameController.text=fullName;
      phoneController.text=phone;


    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> LunchOrder()));

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
                            'LUNCH',

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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Phone Number :',
                                style: TextStyle(fontWeight:FontWeight.bold, fontSize: 16),
                              ),

                              Container(
                                width: 180,
                                child: TextField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(

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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ' Total NO\'s Lunch',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(lunchCount.toString(),
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
                              Text((lunchCount*40).toString(),
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),

                        SizedBox(height:25,),

                        OwnButton(
                          title: 'Place Order',
                          color: Colors.brown[300],
                          onPressed: (){

                            if(nameController.text == null){
                              showSnackBar('Enter your Name');
                              return;
                            }
                            if(phoneController.text == null){
                              showSnackBar('Enter your Phone Number');
                              return;
                            }

    int tempAmt = amount - lunchCount*40;
    if(tempAmt>0) {
      amount = amount - lunchCount * 40;
      DatabaseReference amtRef = FirebaseDatabase.instance.reference().child(
          'user/${currentFirebaseUser.uid}/amount');

      amtRef.set(amount);
                            orderLunch();

                            Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));
                            showDialog(context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context)=>OrderNotification());
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
        ),
      ),
    );
  }
  int lunchFares(){
    var lunchCount = int.parse(lunchController.text);
    print(lunchCount);
    return(lunchCount*40);}

    void orderLunch(){
    DatabaseReference lunchRef = FirebaseDatabase.instance.reference().child('order').push();
    Map lunchDetails = {
      'name':nameController.text,
      'phone':phoneController.text,
      'user_id':currentFirebaseUser.uid,
      'NoOfLunch':lunchCount,

      'lunchPayment':lunchCount*40,
      'status':'Waiting',
    'created_at': DateTime.now().toString(),

    };


    DatabaseReference tokenRef = FirebaseDatabase.instance.reference().child('/cafe/7HwxFcg8aMdQJ1Nx9AygnkJcH3W2/token');
    tokenRef.once().then((DataSnapshot snapshot){
      if(snapshot.value != null){
        String token= snapshot.value.toString();
        HelperMethods.sendNotification(token, context, (lunchRef.key).toString());

      }
      else{
        return;
      }
    });

      lunchRef.set(lunchDetails);
    lunchCount=0;
    }

}
