import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodzone/DataModels/OrderDetails.dart';
import 'package:foodzone/Globalvariable.dart';
import 'package:foodzone/Methods/HelperMethod.dart';
import 'package:foodzone/widgets/OutlineButton.dart';



typedef onDelete();
class CustomCard extends StatefulWidget {

 final OrderDetails orderDetails;

 final Function() onDelete;
 final String orderId;

  CustomCard({
  this.orderDetails,  this.onDelete, this.orderId

  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  String token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
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
                      (widget.orderDetails.userName != "null")?(widget.orderDetails.userName).toString():'',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
        Row(
          children: [

            IconButton(onPressed: (){

              DatabaseReference statusRef = FirebaseDatabase.instance.reference().child("/order/${widget.orderId}/status");
              statusRef.set('Accepted');
              widget.onDelete();
              HelperMethods.sendAcceptNotification(token, context, widget.orderId);

            },
              icon: Icon(
                FontAwesomeIcons.check,
              ),),
            SizedBox(width: 10,),
            IconButton(onPressed: (){
              DatabaseReference statusRef = FirebaseDatabase.instance.reference().child("/order/${widget.orderId}/status");
              statusRef.set('Rejected');
              widget.onDelete();


              HelperMethods.sendDeleteNotification(token, context, widget.orderId);


            },
              icon: Icon(
                FontAwesomeIcons.times,
              ),),
          ],
        ),


              ],
            ),
            SizedBox(height: 15,),
            Text("Order Details", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            Column(
              children: [


                createRow((widget.orderDetails.noOfTea).toString(), 'Tea'),
                createRow((widget.orderDetails.noOfLemonTea).toString(), 'Lemon'),
                createRow((widget.orderDetails.noOfGreenTea).toString(), 'Green Tea'),
                createRow((widget.orderDetails.noOfCoffee).toString(), 'Coffee'),
                createRow((widget.orderDetails.noOfBlackTea).toString(), 'Black tea'),
                createRow((widget.orderDetails.noOfWithoutSugar).toString(), 'WithOut Sugar Tea'),
                createRow((widget.orderDetails.noOfLunch).toString(), 'Lunch'),
                createRow((widget.orderDetails.noOfDinner).toString(), 'Dinner'),
                createRow((widget.orderDetails.roomNo).toString(), 'Room Number'),
                createRow((widget.orderDetails.noOfSnacks).toString(), 'Snacks'),
                createRow((widget.orderDetails.phoneNo).toString(), 'Phone'),
                // createRow((noOfSnacks).toString(), 'Snacks'),






              ],
            )
          ],
        ),
      ),
    );
  }
  Widget createRow(String item, String itemName){

    if(item == "null" || item == '0'){
      print('$itemName create class null');
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.greenAccent),
            )
          ],
        ),
      ],
    ) ;
    }
  }

  void getToken(){
print(widget.orderId);
    DatabaseReference userRef = FirebaseDatabase.instance.reference().child('/order/${(widget.orderId).toString()}');
    userRef.once().then((DataSnapshot snapshot){
      if(snapshot.value != null){
        String userId = snapshot.value['user_id'].toString();
        DatabaseReference tokenRef = FirebaseDatabase.instance.reference().child('user/$userId');
        tokenRef.once().then((DataSnapshot snapshot){
          if(snapshot != null){
            token = snapshot.value['token'];
            print("token is  in custom $token");
          }
          else{
            print('not getting token');
          }
        });

      }
      else{
        print('not getting user Id');
      }
    });

  }


}

