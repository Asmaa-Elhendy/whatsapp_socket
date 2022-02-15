import 'package:chat_socket/model/chat_model.dart';
import 'package:chat_socket/view/widgets/custom_button.dart';
import 'package:chat_socket/view/widgets/custom_contact_card.dart';
import 'package:flutter/material.dart';

import 'create_new_group_page.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  List<ChatModel> contacts=[
    ChatModel(name: 'asmaa',status: 'life is nothing'),
    ChatModel(name: 'aya',status: 'architecture '),
    ChatModel(name: 'shimo',status: 'chinese  translator '),
    ChatModel(name: 'haidy',status: 'Chemical '),
    ChatModel(name: 'heba',status: 'sales '),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Select Contact',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
            Text('156 contacts',style: TextStyle(fontSize: 13))
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return const[
                PopupMenuItem(
                  child: Text('invite a friend'), value: 'invite a friend'),
                PopupMenuItem(child: Text('Contacts'),
                  value:'Contacts',),
                PopupMenuItem(child: Text('Refresh'), value: 'Refresh',),
                PopupMenuItem(child: Text('Help'),
                  value: 'Help',),
              ];
            },
            onSelected: (value) {
              print(value);
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: contacts.length+2,
          itemBuilder: (context,int index){
            if(index==0){
              return InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewGroupPage()));},
                  child: CustomButton(name: "New Group", icon: Icons.group));
            }
            else if(index==1){
              return CustomButton(name: "Add Contact", icon: Icons.person_add);
            }
            return CustomContactCard(chatModel: contacts[index-2],);

      }),
    );
  }
}
