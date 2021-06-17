
import 'package:cafe/AllScreens/MainPage.dart';
import 'package:cafe/AllScreens/TeaOrderDetails.dart';
import 'package:cafe/widgets/Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../Globalvariable.dart';

class Tea extends StatefulWidget {

  @override
  _TeaState createState() => _TeaState();
}

class _TeaState extends State<Tea> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackBar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15), ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
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
                        SizedBox(width: 70,),
                        Text(
                          'TEA',

                          // textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,),
                        )

                      ]


                  ),

                ),
              ),
              SizedBox(height: 40,),

              Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 30 ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(


                                    children: [

                                      Image.asset('images/teawithsugar.png', height: 60, width: 60,),
                                      SizedBox(width: 50,),
                                      Text(
                                        'Tea',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // SizedBox(width:,),




                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            if(teaCount>0){
                                              teaCount--;
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

                                      Container(
                                        child: Text(teaCount.toString()),
                                      ),
                                      SizedBox(width: 10,),
                                      GestureDetector(
                                        onTap: (){

                                          setState(() {
                                            teaCount++;
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

                                  )
                                ],
                              ),
                            ),

                          ],
                        ),

                      )
                  ),

                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 30 ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(

                                    children: [

                                      Image.asset('images/black tea.png', height: 60, width: 60,),
                                      SizedBox(width: 55,),
                                      Text(
                                        'Black Tea',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),


                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            if(blackTeaCount>0){
                                              blackTeaCount--;
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
                                        child: Text(blackTeaCount.toString()),
                                      ),
                                      SizedBox(width: 10,),
                                      GestureDetector(
                                        onTap: (){

                                          setState(() {
                                            blackTeaCount++;
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
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),

                      )
                  ),

                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 30 ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(

                                    children: [

                                      Image.asset('images/lemon.png', height: 60, width: 60,),
                                      SizedBox(width: 40,),
                                      Text(
                                        'Lemon Tea',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            if(lemonTeaCount>0){
                                              lemonTeaCount--;
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
                                        child: Text(lemonTeaCount.toString()),
                                      ),
                                      SizedBox(width: 10,),
                                      GestureDetector(
                                        onTap: (){

                                          setState(() {
                                            lemonTeaCount++;
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
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),

                      )
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 30 ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(

                                    children: [

                                      Image.asset('images/coffee.png', height: 60, width: 60,),
                                      SizedBox(width: 40,),
                                      Text(
                                        'Coffee',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            if(coffeeCount>0){
                                              coffeeCount--;
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
                                        child: Text(coffeeCount.toString()),
                                      ),
                                      SizedBox(width: 10,),
                                      GestureDetector(
                                        onTap: (){

                                          setState(() {
                                            coffeeCount++;
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
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),

                      )
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 30 ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(

                                    children: [

                                      Image.asset('images/tea.png', height: 60, width: 60,),
                                      SizedBox(width: 30,),
                                      Text(
                                        'Without Sugar',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),


                                    ],
                                  ),
                                 Row(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [
                                     GestureDetector(
                                       onTap: (){
                                         setState(() {
                                           if(withOutSugarCount>0){
                                             withOutSugarCount--;
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
                                       child: Text(withOutSugarCount.toString()),
                                     ),
                                     SizedBox(width: 10,),
                                     GestureDetector(
                                       onTap: (){

                                         setState(() {
                                           withOutSugarCount++;
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
                                 )
                                ],
                              ),
                            ),

                          ],
                        ),

                      )
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 30 ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(

                                    children: [

                                      Image.asset('images/green tea.png', height: 60, width: 60,),
                                      SizedBox(width: 30,),
                                      Text(
                                        'Green Tea',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),


                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,

                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            if(greenTeaCount>0){
                                              greenTeaCount--;
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
                                        child: Text(greenTeaCount.toString()),
                                      ),
                                      SizedBox(width: 10,),
                                      GestureDetector(
                                        onTap: (){

                                          setState(() {
                                            greenTeaCount++;
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
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),

                      )
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 20),
                    child: OwnButton(
                      title: 'Place Order',
                      color: Colors.brown[300],
                      onPressed: (){
                        if(teaCount == 0 &&
                        coffeeCount == 0 &&
                        greenTeaCount == 0 &&
                        blackTeaCount == 0 &&
                        lemonTeaCount ==0 &&
                        greenTeaCount == 0){
                          showSnackBar("Select SomeThing to order");
                          return ;

                        }
                        else{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> TeaOrder()));
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 50,)
                ],

              ),
            ],
          ),
        ),
      ),
    );
  }
}
