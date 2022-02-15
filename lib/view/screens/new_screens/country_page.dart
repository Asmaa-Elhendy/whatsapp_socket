import 'package:chat_socket/model/country_model.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
   CountryPage({required this.setcountryfunc});
 final Function setcountryfunc;

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List<Country> countries = [
    Country(name: 'Egypt', code: "+20", flag: "🇪🇬"),
    Country(name: "India", code: "+91", flag: "🇮🇳"),
    Country(name: "Pakistan", code: "+92", flag: "🇵🇰"),
    Country(name: "United States", code: "+1", flag: "🇺🇸"),
    Country(name: "South Africa", code: "+27", flag: "🇿🇦"),
    Country(name: "Afghanistan", code: "+93", flag: "🇦🇫"),
    Country(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
    Country(name: "Italy", code: "+39", flag: "🇮🇹"),
    Country(name: "India", code: "+91", flag: "🇮🇳"),
    Country(name: "Pakistan", code: "+92", flag: "🇵🇰"),
    Country(name: "United States", code: "+1", flag: "🇺🇸"),
    Country(name: "South Africa", code: "+27", flag: "🇿🇦"),
    Country(name: "Afghanistan", code: "+93", flag: "🇦🇫"),
    Country(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
    Country(name: "Italy", code: "+39", flag: "🇮🇹"),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.teal,),
            onPressed: (){
          Navigator.pop(context);
        }),
        title: const Text("choose a country", style: TextStyle(
            color: Colors.teal, fontWeight: FontWeight.w600, fontSize: 17),),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, int index) {
            return card(width, height, countries[index]);
          }),
    );
  }


  Widget card(double width, double height, Country country) {
    return InkWell(
      onTap: () {
         widget.setcountryfunc(country);
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * .04),
          height: height * .08,
          child: Row(
            children: [
              Text(country.flag, style: TextStyle(fontSize: 24),),
              SizedBox(width: width * .02,),
              Text(country.name),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(country.code)
                  ],),
              )
            ],
          ),
        ),
      ),
    );
  }
}