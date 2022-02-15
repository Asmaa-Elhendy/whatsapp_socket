import 'package:chat_socket/view/screens/new_screens/otp_screen.dart';
import 'package:flutter/material.dart';


Alertmessage(BuildContext context,double width,double height,String code,String phone){
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content:  Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*.01),
              child:SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('we will verifying your phone number',style: TextStyle(fontSize: 13),),
                    Padding(
                      padding:EdgeInsets.symmetric(vertical: height*.015),
                      child: Text(' $code  $phone',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600)),
                    ),
                    Text('Is this ok , or would you edit this number ?',style: TextStyle(fontSize: 13))
                  ],
                ),
              )
            ),
            actions: [
              TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Edit')),
              TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>OtpScreen(code: code,phone: phone,)));}, child: Text('Ok'))

            ]
        );
      });}


AlertmessageNot(BuildContext context,double width,double height){
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content:
            Text('This is no number you entered !',
              style: TextStyle(fontSize: 13),),
            actions: [
              TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Edit')),

            ]
        );
      } );
}