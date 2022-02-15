import 'package:chat_socket/controller/source_model_provider.dart';
import 'package:chat_socket/model/chat_model.dart';
import 'package:chat_socket/view/screens/home_screen.dart';
import 'package:chat_socket/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late ChatModel sourceChatModel;
  List<ChatModel> chats=[
    ChatModel(id:1,name: 'asmaa', icon: "person.svg", time: "09.00",isgroup: false, current_message: 'hello'),
    ChatModel(id:2,name: 'shimo', icon: "person.svg", time: "04.00",isgroup: false, current_message: 'hi smsm'),
    ChatModel(id:3,name: 'haidy', icon: "person.svg", time: "01.00",isgroup: false, current_message: 'bonjour ya asmaa'),
    ChatModel(id:4,name: 'aya', icon: "person.svg", time: "04.00",isgroup: false, current_message: 'engineering'),
    ChatModel(id:5,name: 'bob', icon: "person.svg", time: "01.00",isgroup: false, current_message: 'egypt'),


  ];
  @override
  Widget build(BuildContext context) {

    final SourceModelProvider _sourceModelProvider=Provider.of<SourceModelProvider>(context,listen: false);
    return Scaffold(
      body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context,int index){
        return InkWell(
            onTap: (){
           sourceChatModel= chats.removeAt(index); //the removed item stored in here
           _sourceModelProvider.setSourceChatModel(sourceChatModel);
           print(_sourceModelProvider.sourceChatModel.id);
              Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen(chatmodels: chats,)));
            },
            child: CustomButton(name: chats[index].name, icon: Icons.person));
      }),
    );
  }
}
