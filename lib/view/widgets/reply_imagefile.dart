import 'package:flutter/material.dart';
class ReplyImageFile extends StatelessWidget {
  String url;
  ReplyImageFile({required this.url});

  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*.02,vertical: height*.006),
        child: Container(
        child: Container(
        width: width/1.8,
         height: height/2.2,
          decoration: BoxDecoration(color: Color(0xffdcf8c6),),
          child: Card(margin: EdgeInsets.symmetric(horizontal: width*.01,vertical: height*.005),child:
          Image.network(url,fit: BoxFit.cover,),),),
        ),
      ),
    );
  }
}