import 'package:chat_socket/controller/imagecontroller.dart';
import 'package:chat_socket/controller/network_image_handler.dart';
import 'package:chat_socket/controller/source_model_provider.dart';
import 'package:chat_socket/view/screens/camera_view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_socket/view/widgets/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';


class Bottomsheetchat extends StatefulWidget {
  double width;
  double height;
  Function function;
  Bottomsheetchat( this.width, this.height, this.function);

  @override
  _BottomsheetchatState createState() => _BottomsheetchatState();
}

class _BottomsheetchatState extends State<Bottomsheetchat> {

  ImagePicker picker=ImagePicker();
  @override
  Widget build(BuildContext context) {
    ImagefileProvider _imagefileProvider =Provider.of<ImagefileProvider>(context);
    SourceModelProvider sourceModelProvider =Provider.of<SourceModelProvider>(context);
    return Container(

      height: widget.height*.4,
      child:  Card(
        margin: EdgeInsets.all(15),
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: widget.height*.05,horizontal: widget.width*.06),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconcirclebottomsheet(Icons.insert_drive_file,Colors.indigo,"Document",widget.width,widget.height,(){}),
                  iconcirclebottomsheet(Icons.camera_alt,Colors.pink,"Camera",widget.width,widget.height,(){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>CameraScreen()));
                  }),
                  iconcirclebottomsheet(Icons.insert_photo,Colors.purple,"Gallery",widget.width,widget.height,()async{
                    var  file= (await picker.pickImage(source: ImageSource.gallery))!;
                    _imagefileProvider.setfile(file);
                       var req= await http.MultipartRequest('POST',Uri.parse('https://test-pm2-with-rabbit.herokuapp.com/users/photo',));

                    var pic = await http.MultipartFile.fromPath("photo", file.path);
                    req.files.add(pic);
                    http.StreamedResponse res= await req.send() ;
                    var body= await res.stream.bytesToString();
                    var decodedbody= json.decode(body); // convert string to object
                    print(decodedbody['photo']);
                    _imagefileProvider.setimageurl(decodedbody['photo']);
                    print(res.statusCode);
                    print('provider*********${_imagefileProvider.imageurlapi}');
                    widget.function(_imagefileProvider.imageurlapi);
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>CameraViewPage(path: file.path)));
                  })
                ],
              ),
              SizedBox(height: widget.height*.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconcirclebottomsheet(Icons.headset,Colors.deepOrange,"Audio",widget.width,widget.height,(){}),
                  iconcirclebottomsheet(Icons.location_on_sharp,Colors.green,"Location",widget.width,widget.height,(){}),
                  iconcirclebottomsheet(Icons.person,Colors.blue,"Contact",widget.width,widget.height,(){})
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget iconcirclebottomsheet(IconData icon, Color color,String text, double width ,double height,  ontap){
    return InkWell(
      onTap:()=>ontap(),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color ,
            radius: width*.07,
            child: Icon(icon,size: width*.07
              ,),
          ),
          SizedBox(height: height*.01,),
          Text(text)
        ],
      ),
    );
  }

}



