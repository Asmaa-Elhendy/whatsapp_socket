import 'package:chat_socket/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OwnMessageCard extends StatelessWidget {
   OwnMessageCard({Key? key,required this.msg}) : super(key: key);
  Message msg;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(constraints: BoxConstraints(maxWidth: width*0.7),
      child: Card(
        color: Color(0xffdcf8c6),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(horizontal: width*.025,vertical: height*.01),
        child: Stack(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: width*.02,top: height*.006,bottom:height*.023 ,right: width*.12),
              child: Text(msg.message ,style: TextStyle(fontSize: 15),),
            ),
            Positioned(
             right: width*.01,
                bottom: height*.001,
                child: Row(
                  children: [
                    Text(msg.time,style: TextStyle(color: Colors.grey[600],fontSize: 11),),
                    Icon(Icons.done_all,size: 15,)
                  ],
                ))
          ],
        ),
      ),
      ),
    );
  }
}
