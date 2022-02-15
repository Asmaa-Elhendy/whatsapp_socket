import 'package:camera/camera.dart';
import 'package:chat_socket/view/screens/new_screens/landing_page.dart';
import 'package:chat_socket/view/widgets/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/source_model_provider.dart';
import 'controller/imagecontroller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras= await availableCameras();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>SourceModelProvider()),
        ChangeNotifierProvider(create: (_)=>ImagefileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false ,
        title: 'Whatsapp clone',
        theme: ThemeData(
          fontFamily: 'OpenSans',
          primaryColor: Color(0xff008069),
          primarySwatch:  white,
          accentColor: Color(0xff00a884),
        //  primarySwatch: Colors.blue,
        ),
        home:LandingPge()//LoginScreen()
      ),
    );
  }
}
const MaterialColor white =  MaterialColor(
  0xff008069,
   <int, Color>{
    50:  Color(0xFFFFFFFF),
    100:  Color(0xFFFFFFFF),
    200:  Color(0xFFFFFFFF),
    300:  Color(0xFFFFFFFF),
    400:  Color(0xFFFFFFFF),
    500:  Color(0xFFFFFFFF),
    600:  Color(0xFFFFFFFF),
    700:  Color(0xFFFFFFFF),
    800:  Color(0xFFFFFFFF),
    900:  Color(0xFFFFFFFF),
  },
);