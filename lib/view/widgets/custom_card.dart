import 'package:chat_socket/controller/source_model_provider.dart';
import 'package:chat_socket/model/chat_model.dart';
import 'package:chat_socket/view/screens/individual_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CustomCard extends StatelessWidget {
ChatModel chatModel ;
CustomCard({required this.chatModel});

  Widget build(BuildContext context) {
    final SourceModelProvider _sourceModelProvider=Provider.of<SourceModelProvider>(context,listen: false);
    return  InkWell(
      onTap: (){
        _sourceModelProvider.setTargetChatModel(chatModel);
        Navigator.push(context, MaterialPageRoute(builder: (_)=>IndividualChatPage(chatmodel: chatModel,sourcechatmodel:_sourceModelProvider.sourceChatModel)));
      },
      child: ListTile(
        leading:  CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xffb0bec2),
          child: SvgPicture.asset(chatModel.isgroup?"assets/images/groups.svg":"assets/images/person.svg",color: Colors.white,width: 30,height: 30,)

        ),
        title:  Text(chatModel.name,style:  const TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
        subtitle: Row(
          children:  [
            const Icon(Icons.done_all,color:Color(0xffb0bec2),),// Color(0xff939a9d),
            const SizedBox(width: 3,),
            Text(chatModel.current_message)
          ],
        ),
        trailing: Text(chatModel.time,style: const TextStyle(fontSize: 12),),
      ),
    );
  }
}
