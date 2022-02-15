
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ImagefileProvider extends ChangeNotifier{

late XFile file;
late String imageurlapi;

  setfile(XFile newfile){
    file=newfile;
    notifyListeners();
  }

setimageurl(String url){
  imageurlapi=url;
  notifyListeners();
}

  get getfile{
    return file;
  }
get geturl{
  return imageurlapi;
}
}