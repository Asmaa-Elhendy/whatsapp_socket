import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   final String name;
   final IconData icon;
   CustomButton({required this.name,required this.icon});

  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return  ListTile(
      leading:  CircleAvatar(
          radius:width*.063,
          backgroundColor:  Color(0xff25D366),
          child: Icon(icon)

      ),
      title:  Text(name,style:  const TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),

    );
  }
}
