import 'package:cafe/AllScreens/MainPage.dart';
import 'package:cafe/AllScreens/snacksorder.dart';
import 'package:cafe/Globalvariable.dart';
import 'package:cafe/widgets/Button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnacksPage extends StatefulWidget {
  @override
  _SnacksPageState createState() => _SnacksPageState();
}

class _SnacksPageState extends State<SnacksPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String todaySnacks='';

  void showSnackBar(String title){
    final snackBar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15), ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
  void getSnacks(){
    DatabaseReference snacksTodayRef = FirebaseDatabase.instance.reference().child('/today\'s_order');
    snacksTodayRef.once().then((DataSnapshot snapshot){
      if(snapshot.value != null){
        setState(() {
          todaySnacks=snapshot.value;
        });
        print('snapshot is not null');
      }
      else{
        print('snapshot is null');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      getSnacks();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));

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
                          'SNACKS',

                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,),
                        ),
                      )

                    ]


                ),

              ),
            ),
            SizedBox(height: 40,),
            Container(
              child: Column(
                children: [
                  Text(
                    'Today\'s Snacks Is',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(todaySnacks.toString(), style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.redAccent),),

                ],
              ),

            ),
            SizedBox(height: 20,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 30 ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            Text(
                              'SNACKS',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 95,),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(snacksCount>0){
                                    snacksCount--;
                                  }
                                });

                              },
                              child: Container(

                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: Icon(Icons.remove),
                                ),
                              ),
                            ),

                            SizedBox(width: 10,),
                            Container(
                              child: Text(snacksCount.toString()),
                            ),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: (){

                                setState(() {
                                  snacksCount++;
                                });

                              },
                              child: Container(

                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),



                          ],
                        ),
                      ),
                      SizedBox(height: 10,),


                    ],
                  ),

                )
            ),
            Padding(
              padding:  EdgeInsets.all(18.0),
              child: OwnButton(
                title: 'PLACE YOUR ORDER',
                color: Colors.brown[300],
                onPressed: (){
                  if(snacksCount==0){
                    showSnackBar('Add some Snacks first');
                    return;
                  }

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SnacksOrder()));

                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
