
import 'package:flutter/material.dart';

import 'login_page.dart';

class LandingPge extends StatelessWidget {
  const LandingPge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height*.1,),
        const  Center(child: Text('Welcome to WhatsApp',style:  TextStyle(color:Color(0xff419080),fontSize: 27,fontWeight: FontWeight.w500),)),
          SizedBox(height: height*.03,),
          Image.asset("assets/images/bg.png",color: Colors.teal,height: height*.5,width: width*.85,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: width*.04,vertical: height*.03),
            child: RichText(text: TextSpan(
              style: const TextStyle(fontSize: 17, color: Colors.black),
              children: [
                TextSpan(
                  text: "Agree and continue to accept the ",
                  style: TextStyle(color: Colors.grey[500])

                ),
                const TextSpan(
                    text: "whatsApp terms of Services and privacy policy",
                    style: TextStyle(color: Colors.cyan)
                )
              ]
            )),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage()));
            },
            child: Container(
              width: width*.8,
              height: height*.08,
              child: Card(
                color: Colors.greenAccent[700],
                elevation: 4,
                child: Center(child: Text("AGREE AND CONTINUE",style: TextStyle(color:Colors.white,fontSize: 16),)),
              ),
            ),
          )

        ],
      ),
    );
  }
}
