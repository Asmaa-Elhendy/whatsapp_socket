
import 'dart:math';

import 'package:flutter/material.dart';

class OtherStatus extends StatelessWidget {
   OtherStatus({Key? key,required this.name,required this.time,required this.imagepath,required this.isSeen,required this.statusNum}) : super(key: key);
   String name;
   String time;
   String imagepath;
   bool isSeen;
   int statusNum;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ListTile(
      leading: CustomPaint(
        painter: StatusPainter(isSeen: isSeen,statusNum: statusNum),
        child: CircleAvatar(
          radius: width*.072,
          backgroundColor: Colors.blueGrey,
          child:Center(child:  Image.asset(imagepath,width: width*.12,height: height*.25,),),
        ),
      ),
      title: Text(name,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15),),
      subtitle: Text('Today at $time',style: TextStyle(color: Colors.grey[700],fontSize: 13),),
    );
  }
}
covertToRadian(double degree){
  return degree*pi/180;
}

class StatusPainter extends CustomPainter{
  bool isSeen;
  int statusNum;
  StatusPainter({required this.isSeen,required this.statusNum});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =Paint();
    paint..isAntiAlias=true
      ..strokeWidth=6.0
      ..style=PaintingStyle.stroke
    ..color =isSeen?Colors.grey:Color(0xff21bfa6);
    drawarc(canvas, size, paint);

  }
  drawarc(Canvas canvas, Size size,Paint paint){
    if(statusNum==1){
      canvas.drawArc(Rect.fromLTWH(0, 0.0, size.width, size.height), covertToRadian(0), covertToRadian(360), false, paint);
    }else{
      double degree=-90;
      double arc= 360/statusNum;
      for(int i =0;i<statusNum;i++){
        canvas.drawArc(Rect.fromLTWH(0, 0.0, size.width, size.height), covertToRadian(degree+4), covertToRadian(arc-8), false, paint);
        degree+=arc;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true ;
  }

}