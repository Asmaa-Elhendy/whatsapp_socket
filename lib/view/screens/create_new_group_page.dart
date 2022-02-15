import 'package:chat_socket/model/chat_model.dart';
import 'package:chat_socket/view/widgets/custom_circle_avatar.dart';
import 'package:chat_socket/view/widgets/custom_contact_card.dart';
import 'package:flutter/material.dart';

class CreateNewGroupPage extends StatefulWidget {
  const CreateNewGroupPage({Key? key}) : super(key: key);

  @override
  _CreateNewGroupPageState createState() => _CreateNewGroupPageState();
}

class _CreateNewGroupPageState extends State<CreateNewGroupPage> {

  List<ChatModel> contacts=[
    ChatModel(name: 'asmaa',status: 'life is nothing'),
    ChatModel(name: 'aya',status: 'architecture '),
    ChatModel(name: 'shimo',status: 'chinese  translator ♥️✨ '),
    ChatModel(name: 'haidy',status: 'Chemical '),
    ChatModel(name: 'heba',status: 'sales '),
  ];

  List<ChatModel> selected_pariticpants_list=[];

  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('New Group',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
            Text('Add participants',style: TextStyle(fontSize: 13))
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),

        ],
      ),
      body: Stack(
        children: [
         Column(crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           selected_pariticpants_list.length==0?Container():  SizedBox(height: height*.1,),
           SizedBox(height: selected_pariticpants_list.length==0?height*.85:height*.75,
             child: ListView.builder(
                 itemCount: contacts.length,
                 itemBuilder: (context,int index){

                   return InkWell(
                       onTap: (){
                         if(contacts[index].selected_contact==false){
                           setState(() {
                             contacts[index].selected_contact=true;
                             selected_pariticpants_list.add(contacts[index]);
                           });
                         }else{
                           setState(() {
                             contacts[index].selected_contact=false;
                             selected_pariticpants_list.remove(contacts[index]);
                           });
                         }
                       },
                       child: CustomContactCard(chatModel: contacts[index],));

                 }),),

           ],
         ),
        selected_pariticpants_list.length==0?Container():  Column(
            children: [
              Container(
                color: Colors.white,
                height: height*.09,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: contacts.length,
                    itemBuilder: (context,int index){
                   if(contacts[index].selected_contact==true){
                     return Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 2.5),
                       child: InkWell(
                           onTap: (){
                             setState(() {
                               contacts[index].selected_contact=false;
                               selected_pariticpants_list.remove(contacts[index]);

                             });
                           },
                           child: CustomCircleAvatar(selected_participant: contacts[index])),
                     );
                   }else{
                     return Container();
                   }
                })

                // ListView.builder(
                //   scrollDirection: Axis.horizontal,
                //     itemCount: selected_pariticpants_list.length,
                //     itemBuilder: (context,int index){
                //       return Padding(
                //         padding:  EdgeInsets.symmetric(horizontal: 2.5),
                //         child: InkWell(
                //             onTap: (){
                //              setState(() {
                //                selected_pariticpants_list[index].selected_contact=false;
                //                selected_pariticpants_list.remove(selected_pariticpants_list[index]);
                //
                //              });
                //             },
                //         child:    CustomCircleAvatar(selected_participant:selected_pariticpants_list[index]),
                //             )
                //       );
                //     })
                ,

              ),
              Divider(thickness: 1,),

            ],
          )

        ],
      )
    );
  }
}
