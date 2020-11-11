import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List restList;
  double screenHeight, screenWidth;
  String titlecenter = "No Data Found";
  @override
  void initState() {
    super.initState();
    _loadRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Column(
        children: [
          restList == null
              ? Flexible(
                  child: Container(
                      child: Center(
                          child: Text(
                  titlecenter,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ))))
              : Flexible(
                  child: GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: (screenWidth / screenHeight) / 0.22,
                  children: List.generate(restList.length, (index) {
                    return Padding(
                      padding: EdgeInsets.all(1),
                      child: Card(
                        child: Column(
                          children: [Text(restList[index]['restname'])],
                        ),
                      ),
                    );
                  }),
                ))
        ],
      ),
    );
  }

  void _loadRestaurant() {
    http.post("https://slumberjer.com/foodninjav2/php/load_restaurant.php",
        body: {
          "location": "Changlun",
        }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        restList = null;
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          restList = jsondata["rest"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}
