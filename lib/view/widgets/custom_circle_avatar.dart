import 'package:chat_socket/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCircleAvatar extends StatelessWidget {
  ChatModel selected_participant;
  CustomCircleAvatar({required this.selected_participant});

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.only(top: 1.11),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xffb0bec2),
                child: SvgPicture.asset("assets/images/person.svg",color: Colors.white,),
            radius: width*.06,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: width*.02,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.clear,size: width*.03,color: Colors.white,),
                ),
              )
            ],
          ),
          Center(child: Text(selected_participant.name,style: TextStyle(fontSize: 12),))
        ],
      ),
    );
  }
}
