import 'package:chat_socket/model/chat_model.dart';
import 'package:chat_socket/view/screens/chat_page.dart';
import 'package:chat_socket/view/screens/status_screen.dart';
import 'package:chat_socket/view/widgets/camera.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key,required this.chatmodels}) : super(key: key);
  List<ChatModel> chatmodels;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController= TabController(length: 4, vsync: this , initialIndex: 1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whatsapp clone'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          PopupMenuButton(itemBuilder: (BuildContext context){
            return const[
              PopupMenuItem(child: Text('New group'),value:"New group" ,),
              PopupMenuItem(child: Text('New Broadcast'),value:'New Broadcast' ,),
              PopupMenuItem(child: Text('whatsapp web'),value: 'whatsapp web',),
              PopupMenuItem(child: Text('Starred messages'),value:'Starred messages' ,),
               PopupMenuItem(child: Text('Settings'),value: 'Settings')
            ];
          },
          onSelected: (value){
            print(value);
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.camera_alt),),
            Tab(text: "CHATS",),
            Tab(text: "STATUS",),
            Tab(text: "CALLS",)
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:  [
         CameraScreen(),
          ChatPage(chatmodels: widget.chatmodels,),
          StatusScreen(),
          Text('calls'),
        ],
      ),
    );
  }
}
