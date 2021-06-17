import 'package:cafe/Globalvariable.dart';
import 'package:cafe/widgets/CustomCard.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class OrderHistory extends StatefulWidget {
  const OrderHistory({Key key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {


        List orderId =[];
  void getOrderHistory(){
    DatabaseReference orderHistoryRef = FirebaseDatabase.instance.reference().child('order');
    orderHistoryRef.once().then((DataSnapshot snapshot){
      if(snapshot.value != null){
        List history = [];


        snapshot.value.forEach((key, value) => history.add(key));
        for(int i = 0; i<history.length;i++){
          DatabaseReference historyRef = FirebaseDatabase.instance.reference().child('/order/${history[i]}');
          historyRef.once().then((DataSnapshot snapshot){
            if(snapshot != null){
              if(snapshot.value['user_id'] ==currentFirebaseUser.uid){
               setState(() {
                 orderId.add(history[i]);
               });
               print('order Id ${orderId.length}');

              }

            }
          });
        }
        print('order history $history');
      }
else {
        print('order Id ${orderId}');
      }


    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getOrderHistory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
        backgroundColor: Colors.brown[300],
      ),
      body:createList()
    );
  }
  Widget createList() {
    if(orderId.length == 0 ){
      return Center(
        child: Text(
          'No New Orders Till Now',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      );
    }
    else {

      return  ListView.builder(
          itemCount: orderId.length,
          itemBuilder: (context, index)=>CustomCard(orderId: orderId[index],)
      );
    }
  }
}
