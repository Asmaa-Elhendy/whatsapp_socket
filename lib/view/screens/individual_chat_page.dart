import 'dart:convert';
import 'package:chat_socket/controller/imagecontroller.dart';
import 'package:chat_socket/controller/source_model_provider.dart';
import 'package:chat_socket/model/chat_model.dart';
import 'package:chat_socket/model/message_model.dart';
import 'package:chat_socket/view/widgets/own_image_file.dart';
import 'package:chat_socket/view/widgets/own_message_card.dart';
import 'package:chat_socket/view/widgets/reply_imagefile.dart';
import 'package:http/http.dart'as http;
import 'package:chat_socket/view/widgets/camera.dart';
import 'package:chat_socket/view/widgets/reply_msg.dart';
import 'package:chat_socket/view/widgets/utilites.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart'as IO;

import 'camera_view_page.dart';


List<Message> messages=[];

class IndividualChatPage extends StatefulWidget {
ChatModel chatmodel;
ChatModel sourcechatmodel;
IndividualChatPage({required this.chatmodel,required this.sourcechatmodel});

  @override
  _IndividualChatPageState createState() => _IndividualChatPageState();
}

class _IndividualChatPageState extends State<IndividualChatPage> {
  late IO.Socket socket;
  bool show =false;
  FocusNode focusNode=FocusNode();
  TextEditingController _controller =TextEditingController();
  bool sendButton=false;
   XFile? file;
  ImagePicker picker=ImagePicker();
  String receivedurl='';

  ScrollController scrollController=ScrollController();





  void connect(){//"http://192.168.1.2:5000"
    socket= IO.io("https://test-pm2-with-rabbit.herokuapp.com/chat",< String,dynamic>{
      "transports":["websocket"],
      "autoconnect":false
    });
    socket.connect();  //connect manually
    socket.emit('signin',{
      "id":widget.sourcechatmodel.id
    });//******************
    print(widget.sourcechatmodel.id);
    socket.onConnect((data) {
      print('socket connected successfully ');
      print(socket.connected);
      socket.on('message',(msg){
        print(msg);
       setmsgToList('received', msg['message'],DateTime.now().toString().substring(10,16)); // every space
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.linear);

      });
      socket.on('image',(msg){
        print('image on $msg');
        setmsgToList('receivedImage', msg['photo'],DateTime.now().toString().substring(10,16)); // every space
        receivedurl=msg['photo'];
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.linear);

      });
    });
    print(socket.connected);
  }

  sendMessage(String message,int sourceId, int targetId){
    setmsgToList('source', message,DateTime.now().toString().substring(10,16));
    socket.emit("message",{//********************************
      "sourceId":sourceId,
      "targetId":targetId,
      "message":message,


    });

    print("$message $sourceId $targetId");

  }
  sendImagetosocket(imageurl){
   setmsgToList('sourceImage', '${imageurl}', DateTime.now().toString().substring(10,16)) ;
   socket.emit('image',{
     'sourceId':widget.sourcechatmodel.id,
     'targetId':widget.chatmodel.id,
     'photo': imageurl
   });
  }

  setmsgToList(String type,String msg,String time){
    Message message=Message(type: type, message: msg,time: time);
    if (mounted) { setState(() {
      messages.add(message);
    });
  }}
  @override

  Widget build(BuildContext context) {
    ImagefileProvider _imagefileProvider =Provider.of<ImagefileProvider>(context);
    SourceModelProvider sourceModelProvider =Provider.of<SourceModelProvider>(context);
   if(scrollController.hasClients){
     scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.linear);

   }
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return Stack(
      children: [
        Image.asset("assets/images/background.png",width: width,height: height,fit: BoxFit.cover,),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(height * .09),
            child: AppBar(
              leadingWidth: width * .2,
              titleSpacing: 0,
              leading: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(child: Icon(Icons.arrow_back), onTap: () {
                    Navigator.pop(context);
                  },),
                  CircleAvatar(radius: 20, backgroundColor: Color(0xffb0bec2),
                    child: SvgPicture.asset(widget.chatmodel.isgroup
                        ? "assets/images/groups.svg"
                        : "assets/images/person.svg", color: Colors.white,
                      width: 35,
                      height: 35,),),
                ],
              ),
              title: Container(
                margin: EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.chatmodel.name, style: const TextStyle(
                        fontSize: 16.5, fontWeight: FontWeight.bold),),
                    const Text(
                      'Last seen today at 08.00 am', style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.visible,),
                  ],
                ),
              ),
              actions: [
                InkWell(child: const Icon((Icons.videocam), size: 27,), onTap: () {},),
                //icon button
                SizedBox(width: width * .05,),
                InkWell(child: const Icon((Icons.call),), onTap: () {},),

                PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return const[
                      PopupMenuItem(
                        child: Text('View contact'), value: 'View contact',),
                      PopupMenuItem(child: Text('Media ,links and docs'),
                        value: 'Media ,links and docs',),
                      PopupMenuItem(child: Text('Search'), value: 'Search',),
                      PopupMenuItem(child: Text('Mute notifications'),
                        value: 'Mute notifications',),
                      PopupMenuItem(child: Text('Wall paper'), value: 'Wall paper')
                    ];
                  },
                  onSelected: (value) {
                    print(value);
                  },
                ),
              ],
            ),
          ),
          body: WillPopScope(
            onWillPop: () {
              if(show){
                setState(() {
                  show=false;
                });
              }else{
             Navigator.pop(context);
              }
              return Future.value(false);
            },
            child: Container(
              height: height,
              width: width,
              child: Column(

                children: [
                  Expanded(
                    child: Container(
                      height: height*.78,
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: scrollController,
                        itemCount: messages.length+1,
                        itemBuilder: (context,int index){
                          if(index==messages.length){






                            return Container(height: height*.035,);
                          }
                          if(messages[index].type=='source'){
                            return OwnMessageCard(msg: messages[index]);
                          }
                          else if(messages[index].type=='received'){
                            return ReplayMessage(msg: messages[index]);
                          }
                          else if(messages[index].type=='sourceImage'){
                            return OwnImageFile(url: _imagefileProvider.imageurlapi,);
                          }
                          else if(messages[index].type=='receivedImage'){
                            return ReplyImageFile(url: receivedurl,);
                          }
                          return OwnMessageCard(msg: messages[index]);
                        },
                      ),
                    ),
                  ),
                  // OwnImageFile(),
                  // ReplyImageFile(),

                  Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Card(
                                      margin: EdgeInsets.only(bottom: height * .01,
                                          left: width * .01,
                                          right: width * .01),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25)),
                                      child: TextFormField(
                                        onChanged: (value){
                                          if(value.length>0){
                                            setState(() {
                                              sendButton=true;
                                            });
                                          }else{
                                            setState(() {
                                              sendButton=false;
                                            });
                                          }
                                        },
                                        controller: _controller,
                                        focusNode: focusNode,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        minLines: 1,
                                        textAlignVertical: TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.all(5),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            prefixIcon: IconButton(icon:  Icon(
                                             show?Icons.keyboard:Icons.emoji_emotions_outlined,
                                              color: Colors.grey,),
                                              onPressed: () {
                                                focusNode.unfocus();
                                                focusNode.canRequestFocus=false;
                                            setState(() {
                                              show=!show;
                                            });
                                              },),
                                            hintText: "Type a message",
                                            suffixIcon: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(

                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                        backgroundColor: Colors.transparent,
                                                        builder: (context){
                                                          return  Bottomsheetchat(width,height,sendImagetosocket);
                                                        }, context: context
                                                      );
                                                    },
                                                    icon: const Icon(Icons.attach_file,
                                                      color: Colors.grey,)),
                                                IconButton(

                                                    onPressed: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CameraScreen()));
                                                    },
                                                    icon: const Icon(Icons.camera_alt,
                                                      color: Colors.grey,))
                                              ],
                                            )
                                        ),
                                      )),
                                  width: width - width * .15,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: height * .01, right: width * .01),
                                  child: CircleAvatar(
                                    backgroundColor: const Color(0xff00a884),
                                    radius: 23,
                                    child: IconButton(icon:  Icon(
                                      sendButton?Icons.send:Icons.mic, color: Colors.white, size: 23,),
                                      onPressed: () {
                                      if(sendButton&&_controller.text.length>0){
                                        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.linear);
                                        sendMessage(_controller.text, widget.sourcechatmodel.id, widget.chatmodel.id);
                                        print(widget.sourcechatmodel.id);
                                        _controller.clear();
                                        setState(() {
                                          sendButton=false;
                                        });
                                      }

                                      },),
                                  ),
                                )
                              ],
                            ),
                           show? emojipicker():Container()
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  @override
  void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        setState(() {
          show=false;
        });
      }
    });
  }





  Widget emojipicker() {//-445
    return Container(height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height*0.66,
      child: EmojiPicker(onEmojiSelected: (category, emoji) {
        setState(() {
          sendButton=true;
        });
       _controller.text=_controller.text+emoji.emoji;
      },
        config: Config(

            columns: 7,
            verticalSpacing: 0,
            horizontalSpacing: 0,
            recentsLimit: 28,
            emojiSizeMax: 27 * (Platform.isIOS ? 1.30 : 1.0)
        ),
      ),
    );
  }

}
