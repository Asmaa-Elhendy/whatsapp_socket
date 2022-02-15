import 'package:chat_socket/controller/source_model_provider.dart';
import 'package:chat_socket/model/chat_model.dart';
import 'package:chat_socket/view/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contact_page.dart';

class ChatPage extends StatefulWidget {
   ChatPage({required this.chatmodels});
  List<ChatModel> chatmodels;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // List<ChatModel> chats=[
  //   ChatModel(name: 'asmaa', icon: "person.svg", time: "09.00",isgroup: false, current_message: 'hello'),
  //   ChatModel(name: 'shimo', icon: "person.svg", time: "04.00",isgroup: false, current_message: 'hi smsm'),
  //   ChatModel(name: 'comfort zone', icon: "groups.svg", time: "10.00",isgroup: true, current_message: 'amazing '),
  //   ChatModel(name: 'haidy', icon: "person.svg", time: "01.00",isgroup: false, current_message: 'bonjour ya asmaa'),
  //   ChatModel(name: 'collage', icon: "groups.svg", time: "12.00",isgroup: true, current_message: 'exam to everyone'),
  //   ChatModel(name: 'aya', icon: "person.svg", time: "04.00",isgroup: false, current_message: 'engineering'),
  //   ChatModel(name: 'is', icon: "groups.svg", time: "10.00",isgroup: true, current_message: 'data mining exam '),
  //   ChatModel(name: 'bob', icon: "person.svg", time: "01.00",isgroup: false, current_message: 'egypt'),
  //
  //
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactPage()));
      },
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
          itemCount: widget.chatmodels.length,
          itemBuilder: (context,int index){

            return CustomCard(chatModel: widget.chatmodels[index],);
          }),
    );
  }
}
