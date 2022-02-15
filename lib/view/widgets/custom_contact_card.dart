import 'package:chat_socket/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomContactCard extends StatelessWidget {
  ChatModel chatModel ;
  CustomContactCard({required this.chatModel});

  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return  ListTile(
      leading:  Stack(
        children: [
          CircleAvatar(
              radius:width*.063,
              backgroundColor: Color(0xffb0bec2),
              child: SvgPicture.asset("assets/images/person.svg",color: Colors.white,width: 30,height: 30,)

          ),
          chatModel.selected_contact? Positioned(
              right: 0,
              bottom: 0,
              child: CircleAvatar(
                radius: width*.03,
                backgroundColor:  Color(0xff00a884),
                child: Icon(Icons.done,size: 15,),
              )):
              Text('')

        ],
      ),
      title:  Text(chatModel.name,style:  const TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
      subtitle: Text(chatModel.status),

    );
  }
}
