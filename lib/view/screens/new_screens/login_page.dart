import 'package:chat_socket/model/country_model.dart';
import 'package:chat_socket/view/widgets/alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'country_page.dart';

class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

String countryName='India';
String code='+91';
TextEditingController phonrcontroller =TextEditingController();

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Enter your phone Number", style: TextStyle(
            color: Colors.teal, fontWeight: FontWeight.w600, fontSize: 17),),
        centerTitle: true,
        elevation: 0,
        actions: const [
          Icon(Icons.more_vert, color: Colors.black,)
        ],
      ),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * .03, top: height * .02),
                child: const Text(
                    'WhatsApp will send an sms message to verify your number',
                    style: TextStyle(fontSize: 13.5,)),
              ),
              Center(
                child: Text('What\'s my number?',
                    style: TextStyle(fontSize: 13, color: Colors.teal)),
              ),
              Center(child: countryCard(context,width,height)),
              Center(child: phoneCard(width,height)),
              SizedBox(height: height*.46,),
              InkWell(
                onTap: (){
                  phonrcontroller.text.length<10?AlertmessageNot(context, width, height):
                  Alertmessage(context,width,height,code,phonrcontroller.text);},
                child: Center(
                  child: Container(
                    width: width*.2,
                    height: height*.06,
                    color: Colors.tealAccent[400],
                    child: Center(child: Text("Next"),),
                  ),
                ),
              )



            ],
          ),
        ),
      ),
    );
  }
 Widget phoneCard(width,height){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*.17,vertical: 5),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        Container(
        width: width*.12,
        height: height*.07,
     //   margin: EdgeInsets.symmetric(vertical: height*.03),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.teal,width: 1.8)),
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Text(' +',style: TextStyle(fontSize: 18),),
            SizedBox(width: width*.02,),
            Text(code.substring(1),style: TextStyle(fontSize: 18),)
          ],),
        ),
        ),SizedBox(width: width*.03,),
       Container(
         width: width*.48,
        // margin: EdgeInsets.symmetric(vertical: height*.03),
         decoration: const BoxDecoration(
           border: Border(bottom: BorderSide(color: Colors.teal,width: 1.8)),
         ),
         child: TextField(
           controller: phonrcontroller,
           keyboardType: TextInputType.number,
           decoration: InputDecoration(
             contentPadding: EdgeInsets.symmetric(horizontal:width*.09),
             hintText: "phone number",
             hintStyle: TextStyle(fontSize: 15),
             border: InputBorder.none,
           ),
         ),
       )]
      ),
    );

 }
  Widget countryCard(context,width,height){
    return  InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>CountryPage(setcountryfunc:setCountryVariables)));
      },
      child: Container(
               width: width/1.7,
               margin: EdgeInsets.symmetric(vertical: height*.03),
               decoration: const BoxDecoration(
                 border: Border(bottom: BorderSide(color: Colors.teal,width: 1.8))
               ),child: Row(
                 children: [
                   Expanded(child: Container(child: Center(child:  Text(countryName,style: TextStyle(fontSize: 18),)))),
                   const Icon(Icons.arrow_drop_down,color: Colors.teal,size: 28,)
                 ],
               ),
        ),
    );
  }

void setCountryVariables(Country country){  //*****************************************************important********************
    setState(() {                      // set vaiables from another page
      countryName=country.name;
      code=country.code;
    });
    Navigator.pop(context);
 }
}
