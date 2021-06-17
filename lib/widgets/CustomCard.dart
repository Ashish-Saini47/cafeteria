import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




class CustomCard extends StatefulWidget {

  final orderId;
  CustomCard({
    this.orderId,
});

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  String userName ="";
  String phone ="";
  String roomNo ="";
  String noOfTea ="";
  String noOfGreenTea ="";
  String noOfBlackTea ="";
  String noOfLemonTea ="";
  String noOfCoffee ="";
  String noOfWithout ="";
  String noOfLunch ="";
  String noOfDinner ="";
  String noOfSnacks ="";
  String payment ="";
  String status ="";
  String created = "";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.user),
                    SizedBox(width: 10,),
                    Text(
                      (userName != null)?(userName).toString():'',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),



              ],
            ),
            SizedBox(height: 15,),
            Text("Order Details", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            Column(
              children: [


                createRow((noOfTea).toString(), 'Tea'),
                createRow((noOfLemonTea).toString(), 'Lemon'),
                createRow((noOfGreenTea).toString(), 'Green Tea'),
                createRow((noOfCoffee).toString(), 'Coffee'),
                createRow((noOfBlackTea).toString(), 'Black tea'),
                createRow((noOfWithout).toString(), 'WithOut Sugar Tea'),
                createRow((noOfLunch).toString(), 'Lunch'),
                createRow((noOfDinner).toString(), 'Dinner'),
                createRow((roomNo).toString(), 'Room Number'),
                createRow((noOfSnacks).toString(), 'Snacks'),
                createRow((phone).toString(), 'Phone'),
                createRow((status).toString(), "Status"),
                createRow((payment).toString(), "Payment"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order At',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),),
                    Text(created,
                    style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),)
                  ],
                )






              ],
            )
          ],
        ),
      ),
    );
  }
  Widget createRow(String item, String itemName){

    if(item == "null" || item == '0'){
      print(' create class null');
      return SizedBox(height: 0,);
    }
    else{

      return Column(
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.greenAccent),
              ),
              Text(
                item,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent),
              )
            ],
          ),
        ],
      ) ;
    }
  }

  void getDetails(){
    print(widget.orderId);
    DatabaseReference userRef = FirebaseDatabase.instance.reference().child('/order/${(widget.orderId).toString()}');
    userRef.once().then((DataSnapshot snapshot){
      if(snapshot.value != null) {
        setState(() {
        userName = snapshot.value['name'].toString();
        phone = snapshot.value['phone'].toString();
        roomNo = snapshot.value['room'].toString();
        noOfSnacks = snapshot.value['Number\'s Of snacks'].toString();
        noOfLunch = snapshot.value['NoOfLunch'].toString();
        noOfDinner = snapshot.value['NoOfDinner'].toString();
        noOfTea = snapshot.value['tea'].toString();
        noOfWithout = snapshot.value['without_sugar'].toString();
        noOfBlackTea = snapshot.value['black_tea'].toString();
        noOfGreenTea = snapshot.value['green_tea'].toString();
        noOfLemonTea = snapshot.value['lemon_tea'].toString();
        noOfCoffee = snapshot.value['coffee'].toString();
        payment = snapshot.value['payment'].toString();
        status = snapshot.value['status'].toString();
        created =snapshot.value['created_at'].toString();
        });



        print(roomNo);


      }
      else{
        print('not getting user Id');
      }
    });

  }


}

