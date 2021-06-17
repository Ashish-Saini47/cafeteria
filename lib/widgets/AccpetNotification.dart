import 'package:cafe/widgets/BrandDivider.dart';
import 'package:cafe/widgets/OutlineButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class OrderAccepted extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),

      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:   BorderRadius.circular(4),

        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20,),
            Text("ORDER ACCEPTED", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.greenAccent),),
            SizedBox(height: 10,),

            BrandDivider(),
            // SizedBox(height: 10,),
            Icon(FontAwesomeIcons.check, size: 50, color: Colors.greenAccent,),
            // Text('RS:-', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
            SizedBox(height: 16,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Your order has been Accepted", style:TextStyle(fontSize: 16),textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30,),
            Container(
              width: 230,
              child: OwnOutlineButton(
                title: "Ok",
                color: Colors.grey,

                onPressed: (){
                  Navigator.pop(context,);

                },
              ),
            ),
            SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}
