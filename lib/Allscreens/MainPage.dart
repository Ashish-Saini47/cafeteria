import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodzone/Allscreens/HistoryPage.dart';
import 'package:foodzone/DataModels/OrderDetails.dart';
import 'package:foodzone/Globalvariable.dart';
import 'package:foodzone/Methods/HelperMethod.dart';
import 'package:foodzone/widgets/CustomCard.dart';
import 'package:foodzone/widgets/DropDown.dart';



//Firebase messaging starts here


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}





class MainPage extends StatefulWidget {
  static const String id = 'mainpage';

  const MainPage({ Key key}) : super(key: key);



  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String orderId='';
  // bool call = false;

  // OrderDetails orderDetails = OrderDetails();
  int i=0;

int sancksCount=0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    getNumbers();
    // pendingOrder();
    HelperMethods.getOrderHistory();

    // fetchOrderDetails(getId(message));



    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      // fetchOrderDetails(getId(message));
      print('fetch result');
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),

            ));

        setState(() {

          fetchOrderDetails(getId(message));

        });


      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // fetchOrderDetails(getId(message));
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {

        setState(() {
          fetchOrderDetails(getId(message));

        });

      }
    });
  }


  Future<void>  getToken() async{
    String token = await FirebaseMessaging.instance.getToken();
    print('token is $token');

    DatabaseReference tokenRef = FirebaseDatabase.instance.reference().child('cafe/${currentFirebaseUser.uid}/token');
    tokenRef.set(token);


  }
  // void pendingOrder(){
  //   DatabaseReference orderHistoryRef = FirebaseDatabase.instance.reference().child('order');
  //   orderHistoryRef.once().then((DataSnapshot snapshot){
  //     if(snapshot.value != null){
  //       List history = [];
  //
  //       snapshot.value.forEach((key, value) => history.add(key));
  //       for(int i = 0; i<history.length;i++){
  //         DatabaseReference historyRef = FirebaseDatabase.instance.reference().child('/order/${history[i]}');
  //         historyRef.once().then((DataSnapshot snapshot){
  //           if(snapshot != null){
  //             if(snapshot.value['status'] =='Waiting'){
  //               fetchOrderDetails(history[i]);
  //             }
  //           }
  //         });
  //       }
  //
  //       print('order history $history');
  //     }
  //
  //
  //   });
  //
  //
  // }

void fetchOrderDetails(String orderId) {
    DatabaseReference orderRef = FirebaseDatabase.instance.reference().child('order/$orderId');
    orderRef.once().then((DataSnapshot snapshot){
      if(snapshot.value != null){

        String name = snapshot.value['name'].toString();
        String room = snapshot.value['room'].toString();
        String phone = snapshot.value['phone'].toString();
        String greenTea = snapshot.value['green_tea'].toString();
        String blackTea = snapshot.value['black_tea'].toString();
        String lemonTea= snapshot.value['lemon_tea'].toString();
        String coffee = snapshot.value['coffee'].toString();
        String tea = snapshot.value['tea'].toString();
        String withoutSugar = snapshot.value['without_sugar'].toString();
        String lunch = snapshot.value['NoOfLunch'].toString();
        String dinner = snapshot.value['NoOfDinner'].toString();
        String snacks = snapshot.value['Number\'s Of snacks'].toString();

        OrderDetails orderDetails = OrderDetails();
        // print(orderDetails.userName);
        orderDetails.userName= name;
        orderDetails.roomNo=room;
        orderDetails.phoneNo=phone;
        orderDetails.noOfTea=tea;
        orderDetails.noOfSnacks=snacks;
        orderDetails.noOfWithoutSugar=withoutSugar;
        orderDetails.noOfLemonTea=lemonTea;
        orderDetails.noOfCoffee=coffee;
        orderDetails.noOfBlackTea=blackTea;
        orderDetails.noOfGreenTea=greenTea;
        orderDetails.noOfLunch=lunch;
        orderDetails.noOfDinner=dinner;

      print(orderDetails.userName);


      print(order);
      setState(() {
        order.add(orderDetails);

      });

       

      }
      else{
        print('Else part is running null');


      }
    });

}

  @override
  Widget build(BuildContext context) {
  String dropDownValue = 'First';
  List items = ['Samosa', 'Bread Pakoda', 'Bondaa', 'Mathi', 'Chachori', 'Baada'];


    return Scaffold(
      appBar: AppBar(
        title: Text('TODAY\'S ORDER', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        backgroundColor: Colors.brown[300],
        actions: [
          DropdownButton(
            // value: dropDownValue,
            hint: Text("todays order", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
            icon: Icon(Icons.arrow_drop_down, size: 40,color: Colors.white,),
            dropdownColor: Colors.brown[300],
            // value: dropDownValue,
            onChanged: (newValue){
              setState(() {

                dropDownValue = newValue;
                print(dropDownValue);
                DatabaseReference todaySnacksRef = FirebaseDatabase.instance.reference().child('today\'s_order');
                todaySnacksRef.set(dropDownValue);

              });
            },
            items: items.map((valueItem){
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            }).toList(),
          ),
          SizedBox(width: 10,),
          GestureDetector(
             onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderHistory()));
              },
            child: Icon(Icons.history),
            ),
          SizedBox(width: 10,),

        ],
      ),
      body: DataTable(
        columns: [
          DataColumn(label: Text("SR.NO", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.redAccent),)),
          DataColumn(label: Text("ITEM NAME",  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.redAccent))),
          DataColumn(label: Text('Number Of Items',  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.redAccent)))
        ],
        rows: [
          DataRow(cells:[
            DataCell(Text("1", )),
            DataCell(Text("Snacks", )),
            DataCell(Text(sancksCount.toString(), style: TextStyle(color: Colors.greenAccent,fontWeight: FontWeight.bold), ))

          ]
          ),
          DataRow(cells:[
            DataCell(Text("2", )),
            DataCell(Text("Tea", )),
            DataCell(Text("10", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold), ))

          ]
          ),
          DataRow(cells:[
            DataCell(Text("3", )),
            DataCell(Text("Lunch", )),
            DataCell(Text("10", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),))

          ]
          ),
          DataRow(cells:[
            DataCell(Text("4", )),
            DataCell(Text("Dinner", )),
            DataCell(Text("10", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold), ))

          ]
          ),
        ],
      )
// body:createList(),

    );

  }

Widget createList() {
    if(order.length == 0 ){
      return Center(
        child: Text(
          'No New Orders Till Now',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      );
    }
    else {

      return  ListView.builder(
          itemCount: order.length,
          itemBuilder: (context, index)=>CustomCard(orderDetails: order[index],
          onDelete:()=> onDelete(index), orderId: orderId)
      );
    }
}

  String getId(RemoteMessage message){
      orderId = message.data['order_id'];
      print('orderId = $orderId');
    return orderId;
  }
void getNumbers(){
  DatabaseReference orderHistoryRef = FirebaseDatabase.instance.reference().child('order');
  orderHistoryRef.once().then((DataSnapshot snapshot){
    if(snapshot.value != null){
      List history = [];


      snapshot.value.forEach((key, value) => history.add(key));
      for(int i = 0; i<history.length;i++){
        DatabaseReference historyRef = FirebaseDatabase.instance.reference().child('/order/${history[i]}/Number\'s Of snacks');
        historyRef.once().then((DataSnapshot snapshot){
          if(snapshot.value != null){
print("Snapshot vale = ${snapshot.value}");
            setState(() {
              sancksCount=int.parse(snapshot.value.toString())+sancksCount;
            });
            print("snack count = $sancksCount");



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

  void onDelete(int index){
    setState(() {
      print(order.length);
      print(index);
      order.removeAt(index);

    });
  }


void getNumbersOfDinner(){
    DatabaseReference dinnerCountRef = FirebaseDatabase.instance.reference().child('order/$orderId');
    dinnerCountRef.once().then((DataSnapshot snapshot){

    });
}
}


