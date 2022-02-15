import 'package:flutter/material.dart';

class HeadOwnStatus extends StatelessWidget {
  const HeadOwnStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: width*.072,
            backgroundColor: Colors.blueGrey,
            child:Center(child:  Image.asset("assets/images/1.png",width: width*.12,height: height*.25,),),
          ),
          Positioned(
              bottom: 0,right: 0,
              child: CircleAvatar(
            radius: width*.03,
            backgroundColor:  Color(0xff25D366),
            child: Icon(Icons.add,color: Colors.white,),
          ))
        ],
      ),
      title: Text('My Status',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
      subtitle: Text('Tap to add status update',style: TextStyle(color: Colors.grey[700],fontSize: 13),),
    );
  }
}
