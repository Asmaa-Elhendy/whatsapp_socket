import 'dart:convert';
import 'dart:math';
import 'package:chat_socket/view/screens/individual_chat_page.dart';
import 'package:http/http.dart'as http;
import 'package:chat_socket/view/screens/camera_view_page.dart';
import 'package:chat_socket/view/screens/video_view_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {


  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  late Future<void> cameravalue;
  late String  videopath;
  bool isrecording=false;
  bool flash= false;
  bool isfrontcamera= true;
  double transformvalue=0;
  XFile? file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = CameraController(cameras![0], ResolutionPreset.max);
    cameravalue= controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder(
          future: cameravalue,
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.done){
              return CameraPreview(controller);
            }
            return Center(child: CircularProgressIndicator(),);
          }
      ),     Positioned(
              bottom: 0.0,

              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      setState(() {
                        flash=!flash;
                      });
                    flash? controller.setFlashMode(FlashMode.torch):controller.setFlashMode(FlashMode.off);
                    }, icon: flash?Icon(Icons.flash_on):Icon(Icons.flash_off,color: Colors.white,size: 28,)),
                    GestureDetector(
                     onLongPress: ()async{
                var  videofile=  await controller.startVideoRecording();

                    setState(() {
                      isrecording =true;
                    });
                     },onLongPressUp: ()async{
                   var videofile2= await controller.stopVideoRecording();
                       setState(() {
                         isrecording=false;
                         videopath=videofile2.path;
                         print('asmaa $videopath *****-*');
                       });

                       Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoViewPage(path:videopath)));
                       },
                      onTap: (){
                       if(!isrecording) {
                         return takePhoto(context);
                       }
                    },
                      child:isrecording?const Icon(Icons.radio_button_checked,color: Colors.red,size: 70,)
                          : const Icon(Icons.panorama_fisheye_sharp,color: Colors.white,size: 70,),),
                    IconButton(onPressed: (){
                      setState(() {
                        isfrontcamera =!isfrontcamera;
                        transformvalue=transformvalue+pi;
                      });
                      int camerapose= isfrontcamera?0:1;
                      controller = CameraController(cameras![camerapose], ResolutionPreset.max);
                      cameravalue= controller.initialize();
                    }, icon: Transform.rotate(angle:transformvalue,
                        child: const Icon(Icons.flip_camera_ios,color: Colors.white,size: 28,)))
                  ],mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                ),
              const Center(child: Text('holde for video, tap for photo',style: TextStyle(color: Colors.white),))
            ],
          ),
              ))
        ],
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
 void  takePhoto(BuildContext context)async{
  //  String  path= join((await getTemporaryDirectory()).path,"${DateTime.now()}.png");
   file=await controller.takePicture();
  print("asmaa file ${file!.path}");
  //await  imageUpload(file!);

  Navigator.push(context, MaterialPageRoute(builder: (context)=>CameraViewPage(path: file!.path)));


  }

}