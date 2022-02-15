import 'package:flutter/material.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

class VideoViewPage extends StatefulWidget {
  const VideoViewPage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  State<VideoViewPage> createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  late VideoPlayerController _videoPlayerController ;

  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(File(widget.path))..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

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
              child: _videoPlayerController.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
                  : Container(),
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
                          onTap: (){},
                          child: const CircleAvatar(
                            child: Icon(Icons.check,color: Colors.white,size: 28,),backgroundColor: Color(0xff00a884),),
                        ),
                        contentPadding: EdgeInsets.only(top: height*.03)
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: (){
                setState(() {
                  _videoPlayerController.value.isPlaying?_videoPlayerController.pause():_videoPlayerController.play();
                });
                },
                child: CircleAvatar(
                  radius: width*.06,
                  backgroundColor: Colors.black38,
                  child: _videoPlayerController.value.isPlaying?Icon(Icons.pause,color: Colors.white,):Icon(Icons.play_arrow,color: Colors.white,)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
