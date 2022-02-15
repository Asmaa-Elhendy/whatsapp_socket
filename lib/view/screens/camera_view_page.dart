import 'package:flutter/material.dart';
import 'dart:io';

class CameraViewPage extends StatelessWidget {
   CameraViewPage({Key? key, required this.path}) : super(key: key);
  final String path;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.crop_rotate)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.emoji_emotions_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.title)),
          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
        ],
      ),
      body: Container(
        width: width,
        height: height,
        child: Stack(
        //  fit: StackFit.passthrough,
          children: [
            Container(
              width: width,
              height: height * .77,
              child: Image.file(File(path),fit: BoxFit.cover,),
            ),
            Positioned(
                bottom: 0,
                child:  Container(
                   width: width-5,
                    decoration: const BoxDecoration(color: Colors.black38,),
                    child:  TextField(
                      textAlignVertical: TextAlignVertical.top,
                      style:TextStyle(color: Colors.white) ,
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: "Add caption...",
                        prefixIcon:   Icon(Icons.add_photo_alternate_outlined,color: Colors.white,),
                        hintStyle: const TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      suffixIcon: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const CircleAvatar(
                          child: Icon(Icons.check,color: Colors.white,size: 28,),backgroundColor: Color(0xff00a884),),
                      ),
                        contentPadding: EdgeInsets.only(top: height*.03)
                        ),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
