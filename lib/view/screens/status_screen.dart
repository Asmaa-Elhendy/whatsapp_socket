import 'package:chat_socket/view/screens/contact_page.dart';
import 'package:chat_socket/view/widgets/status_page/head_own_status.dart';
import 'package:chat_socket/view/widgets/status_page/other_status.dart';
import 'package:flutter/material.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

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

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.blueGrey[100],
            onPressed: () {},
            child: Icon(Icons.edit, color: Colors.grey[900],),),
          SizedBox(height: height * .02,),
          FloatingActionButton(
            backgroundColor: Color(0xff25D366),
            onPressed: () {},
            child: Icon(Icons.camera_alt, color: Colors.white,),),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HeadOwnStatus(),
            label(width,height,'Recent updates'),
            OtherStatus(name: 'asmaa',time: '12.05',imagepath: "assets/images/5.png",isSeen: false,statusNum: 13,),
            OtherStatus(name: 'shimaa',time: '05.02',imagepath: "assets/images/2.png",isSeen: false,statusNum: 2,),
            OtherStatus(name: 'nono',time: '06.07',imagepath: "assets/images/3.png",isSeen: false,statusNum: 3,),
            label(width,height,'Viewed updates'),
            OtherStatus(name: 'asmaa',time: '12.05',imagepath: "assets/images/4.png",isSeen: true,statusNum: 5,),
            OtherStatus(name: 'shimaa',time: '05.02',imagepath: "assets/images/5.png",isSeen: true,statusNum:2),
            OtherStatus(name: 'nono',time: '06.07',imagepath: "assets/images/3.png",isSeen: true,statusNum:3),

          ],
        ),
      ),
    );
  }
}
Widget label(double width,double height,String title){
  return Container(
    padding: EdgeInsets.only(left: width*.04,top: height*.005),
    width: width,
    child: Text(title,style: TextStyle(color: Colors.blueGrey[500],fontWeight: FontWeight.w600),),
  );
}
