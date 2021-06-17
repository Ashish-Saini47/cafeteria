import 'package:cafe/AllScreens/DinnerPage.dart';
import 'package:cafe/AllScreens/LunchOrder.dart';
import 'package:cafe/AllScreens/LunchPage.dart';
import 'package:cafe/AllScreens/NoInternetPage.dart';
import 'package:cafe/AllScreens/OrderDetails.dart';
import 'package:cafe/AllScreens/SnacksPage.dart';
import 'package:cafe/AllScreens/TeaPage.dart';
import 'package:cafe/AllScreens/dinnerOrder.dart';
import 'package:cafe/Globalvariable.dart';
import 'package:cafe/Methods/HelperMethods.dart';
import 'package:cafe/datamodels/OrderDetails.dart';
import 'package:cafe/styles/styles.dart';
import 'package:cafe/widgets/AccpetNotification.dart';
import 'package:cafe/widgets/BrandDivider.dart';
import 'package:cafe/widgets/ConformationNotification.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:outline_material_icons/outline_material_icons.dart';



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
  @override
  _MainPageState createState() => _MainPageState();


}

class _MainPageState extends State<MainPage> {

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List keys=[];
  String orderId='';
Future<void> checkInternet() async {
  var connectivityResult= await Connectivity().checkConnectivity();
  if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> NoInternet()));
  }
}
// void getAmount(){
//   DatabaseReference amtRef = FirebaseDatabase.instance.reference().child('user/${currentFirebaseUser.uid}');
//   amtRef.once().then((DataSnapshot snapshot){
//     if(snapshot != null){
//       amount= snapshot.value['amount'];
//       print(amount);
//     }
//   });
// }
  void initState()  {
    // TODO: implement initState
    super.initState();
    checkInternet();

    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);
   if(dateParse.day == 1){
     setState(() {
       DatabaseReference amtRef = FirebaseDatabase.instance.reference().child('user/${currentFirebaseUser.uid}/amount');
       amtRef.set(5000);

     });

   }
print('month ${dateParse.day}');

    getToken();setState(() {

    HelperMethods.getCurrentUserInfo();
    HelperMethods.getAmount();

    });

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

    DatabaseReference tokenRef = FirebaseDatabase.instance.reference().child('user/${currentFirebaseUser.uid}/token');
    tokenRef.set(token);


  }

  void fetchOrderDetails(String orderId) {
    DatabaseReference orderRef = FirebaseDatabase.instance.reference().child(
        'order/$orderId');
    orderRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        String name = snapshot.value['name'].toString();
        String room = snapshot.value['room'].toString();
        String phone = snapshot.value['phone'].toString();
        String greenTea = snapshot.value['green_tea'].toString();
        String blackTea = snapshot.value['black_tea'].toString();
        String lemonTea = snapshot.value['lemon_tea'].toString();
        String coffee = snapshot.value['coffee'].toString();
        String tea = snapshot.value['tea'].toString();
        String withoutSugar = snapshot.value['without_sugar'].toString();
        String lunch = snapshot.value['NoOfLunch'].toString();
        String dinner = snapshot.value['NoOfDinner'].toString();
        String snacks = snapshot.value['Number\s Of snacks'].toString();
        int payment = int.parse(snapshot.value['payment']);
        String status = snapshot.value['status'];
        OrderDetails orderDetails = OrderDetails();
        // print(orderDetails.userName);
        orderDetails.userName = name;
        orderDetails.roomNo = room;
        orderDetails.phoneNo = phone;
        orderDetails.noOfTea = tea;
        orderDetails.noOfSnacks = snacks;
        orderDetails.noOfWithoutSugar = withoutSugar;
        orderDetails.noOfLemonTea = lemonTea;
        orderDetails.noOfCoffee = coffee;
        orderDetails.noOfBlackTea = blackTea;
        orderDetails.noOfGreenTea = greenTea;
        orderDetails.noOfLunch = lunch;
        orderDetails.noOfDinner = dinner;
        orderDetails.status= status;
orderDetails.payment=payment;

        print(orderDetails.userName);

        if(status == 'Accepted'){
          showDialog(

              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => OrderAccepted());

        }

        if(status == 'Rejected'){

        DatabaseReference amtRef = FirebaseDatabase.instance.reference().child('user/${currentFirebaseUser.uid}/amount');
        amtRef.once().then((DataSnapshot snapshot){
          if(snapshot != null){
            amount = snapshot.value;
        amount=amount+orderDetails.payment;

        amtRef.set(amount);
          }

        });
        showDialog(

            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => OrderRejected());
      }
        }



      else{
        print('Else part is running null');


      }

    });

  }

  // bool drawerCanOpen = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer:Container(
        width: 250,
        color: Colors.white,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              Container(
                color: Colors.white,
                height: 160,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,

                  ),
                  child: Row(
                    children: [
                      Image.asset('images/user_icon.png', height: 60, width: 60,),
                      SizedBox(width: 15,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Container(child: Text(userName, maxLines: 1, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))),
                            SizedBox(height: 5,),
                            Expanded(child: Container(child: Text('Payment Left = $amount', overflow: TextOverflow.ellipsis,maxLines: 1,))),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              BrandDivider(),

              SizedBox(height: 10,),

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderHistory()));
                },
                child: ListTile(
                  leading: Icon(OMIcons.history),
                  title: Text('Order History', style: kDrawerItemStyle,),
                ),
              ),



            ],
          ),
        ),
      ),
      body: Stack(

       children: [
         SingleChildScrollView(
           child: SafeArea(
             child: Column(
               children: [
                 Container(

                   child: Padding(
                     padding: EdgeInsets.only(top: 20, left: 20),
                     child: Row(

                       children:[
                       GestureDetector(
                         onTap: (){

                             scaffoldKey.currentState.openDrawer();


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
                             child: Icon(Icons.menu),
                           ),
                         ),
                       ),

                         Expanded(
                           child: Text(
                             'FOOD ZONE',

                             textAlign: TextAlign.center,
                             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,),
                           ),
                         )

      ]


                     ),
                     
                   ),
                 ),
                 SizedBox(height: 40,),
                 
                 Column(
                   children: [
                     GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> Tea()));

                       },
                       child: Padding(
                         padding: EdgeInsets.symmetric(horizontal: 10),
                         child: Card(
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               Padding(
                                 padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 30 ),
                                 child: Row(

                                   children: [

                                     Image.asset('images/tea.png', height: 60, width: 60,),
                                     SizedBox(width: 50,),
                                     Text(
                                       'TEA',
                                       style: TextStyle(
                                         fontSize: 15,
                                         fontWeight: FontWeight.bold,
                                       ),
                                     )
                                   ],
                                 ),
                               ),

                             ],
                           ),

                         )
                       ),
                     ),

                     GestureDetector(
                       onTap: (){

                         Navigator.push(context, MaterialPageRoute(builder: (context)=> SnacksPage()));
                       },
                       child: Padding(
                           padding: EdgeInsets.symmetric(horizontal: 10),
                           child: Card(
                             child: Column(
                               mainAxisSize: MainAxisSize.min,
                               children: <Widget>[
                                 Padding(
                                   padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 30 ),
                                   child: Row(

                                     children: [

                                       Image.asset('images/buger.png', height: 60, width: 60,),
                                       SizedBox(width: 50,),
                                       Text(
                                         'SNACKS',
                                         style: TextStyle(
                                           fontSize: 15,
                                           fontWeight: FontWeight.bold,
                                         ),
                                       )
                                     ],
                                   ),
                                 ),

                               ],
                             ),

                           )
                       ),
                     ),

                     GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> LunchOrder()));

                       },
                       child: Padding(
                           padding: EdgeInsets.symmetric(horizontal: 10),
                           child: Card(
                             child: Column(
                               mainAxisSize: MainAxisSize.min,
                               children: <Widget>[
                                 Padding(
                                   padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 30 ),
                                   child: Row(

                                     children: [

                                       Image.asset('images/lunch.png', height: 60, width: 60,),
                                       SizedBox(width: 50,),
                                       Text(
                                         'LUNCH',
                                         style: TextStyle(
                                           fontSize: 15,
                                           fontWeight: FontWeight.bold,
                                         ),
                                       )
                                     ],
                                   ),
                                 ),

                               ],
                             ),

                           )
                       ),
                     ),
                     GestureDetector(
                       onTap: (){

                         Navigator.push(context, MaterialPageRoute(builder: (context)=> DinnerOrder()));
                       },
                       child: Padding(
                           padding: EdgeInsets.symmetric(horizontal: 10),
                           child: Card(
                             child: Column(
                               mainAxisSize: MainAxisSize.min,
                               children: <Widget>[
                                 Padding(
                                   padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 30 ),
                                   child: Row(

                                     children: [

                                       Image.asset('images/dinner.png', height: 60, width: 60,),
                                       SizedBox(width: 50,),
                                       Text(
                                         'DINNER',
                                         style: TextStyle(
                                           fontSize: 15,
                                           fontWeight: FontWeight.bold,
                                         ),
                                       )
                                     ],
                                   ),
                                 ),

                               ],
                             ),

                           )
                       ),
                     ),
                   ],
                   
                 ),
               ],
             ),
           ),
         )
       ],
      ),


    );
  }
  String getId(RemoteMessage message){
    orderId = message.data['order_id'];
    print('orderId = $orderId');
    return orderId;
  }
}
