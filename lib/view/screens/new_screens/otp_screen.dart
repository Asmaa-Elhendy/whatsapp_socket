import 'package:chat_socket/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  String code;
  String phone;
  OtpScreen({required this.code,required this.phone});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
   appBar: AppBar(
     backgroundColor: Colors.white,
     title: Text('Verify ${widget.code}  ${widget.phone}',style: TextStyle(color: Colors.teal[800],fontSize: 16.5),),
   ),body: Container(
      width: width,
      height: height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*.05),
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(vertical: height*.02,horizontal: width*.01),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                children: [
                  TextSpan(text: 'We have sent an SMS with a code to ',style: TextStyle(fontSize: 14.5,color: Colors.black)),
                  TextSpan(text: '${widget.code} ${widget.phone}',style: TextStyle(fontSize: 14.5,color: Colors.black,fontWeight: FontWeight.bold)),
                  TextSpan(text: ' wrong number ?',style: TextStyle(fontSize: 14.5,color: Colors.teal[800])),
                ]
              )),
            ),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width-width*.04,
              fieldWidth: 40,
              style: TextStyle(
                  fontSize: 17
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: " + pin);
                Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
              },onChanged: (pin){},
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: height*.02),
              child: Text('Enter 6 digit code ',style: TextStyle(color: Colors.grey[600]),),
            ),
            bottombutton(width,'Resend SMS',Icons.message),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: height*.01),
              child: Divider(thickness: 1.5,),
            ),
            bottombutton(width,'Call me',Icons.call)
          ],
        ),
      ),
    ),
    );
  }
  Widget bottombutton(width,String title,IconData icon){
    return Row(children: [
      Icon(icon,color: Colors.teal,size: 25,),
      SizedBox(width: width*.05,),
      Text(title,style: TextStyle(color: Colors.teal),)
    ],);
  }
}
