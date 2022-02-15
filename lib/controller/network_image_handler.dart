import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:http/http.dart'as http;

var imageUrl;
class Handler {

  imageUpload (XFile file)async{

   var req= await http.MultipartRequest('POST',Uri.parse('https://test-pm2-with-rabbit.herokuapp.com/users/photo',));
   // req.fields['photo']=file.path;
    var pic = await http.MultipartFile.fromPath("photo", file.path);
   req.files.add(pic);
   http.StreamedResponse res= await req.send() ;
   var body= await res.stream.bytesToString();
   print('response  ${body}');
var decodedbody= json.decode(body); // convert string to object
print(decodedbody['photo']);
    imageUrl=decodedbody['photo'];

 }
}
