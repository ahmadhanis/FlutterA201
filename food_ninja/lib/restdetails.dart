import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'food.dart';
import 'restaurant.dart';
import 'package:http/http.dart' as http;
import 'foodscreen.dart';

class RestScreenDetails extends StatefulWidget {
  final Restaurant rest;
  const RestScreenDetails({Key key, this.rest}) : super(key: key);

  @override
  _RestScreenDetailsState createState() => _RestScreenDetailsState();
}

class _RestScreenDetailsState extends State<RestScreenDetails> {
  double screenHeight, screenWidth;
  List foodList;
  String titlecenter = "Loading Foods...";
  
  @override
  void initState() {
    super.initState();
    _loadFoods();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rest.restname),
      ),
      body: Column(children: [
        Container(
            height: screenHeight / 4,
            width: screenWidth / 0.3,
            child: CachedNetworkImage(
              imageUrl:
                  "http://slumberjer.com/foodninjav2/images/restaurantimages/${widget.rest.restimage}.jpg",
              fit: BoxFit.cover,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(
                Icons.broken_image,
                size: screenWidth / 2,
              ),
            )),
        foodList == null
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
                crossAxisCount: 2,
                childAspectRatio: (screenWidth / screenHeight) / 0.8,
                children: List.generate(foodList.length, (index) {
                  return Padding(
                      padding: EdgeInsets.all(1),
                      child: Card(
                        child: InkWell(
                          onTap: () => _loadFoodDetails(index),
                          child: Column(
                            children: [
                              Container(
                                  height: screenHeight / 3.8,
                                  width: screenWidth / 1.2,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "http://slumberjer.com/foodninjav2/images/foodimages/${foodList[index]['foodid']}.jpg",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        new CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        new Icon(
                                      Icons.broken_image,
                                      size: screenWidth / 2,
                                    ),
                                  )),
                              SizedBox(height: 5),
                              Text(
                                foodList[index]['foodname'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text("RM " + foodList[index]['foodprice']),
                              Text("Qty: " + foodList[index]['foodqty']),
                            ],
                          ),
                        ),
                      ));
                }),
              )),
      ]),
    );
  }

  void _loadFoods() {
    http.post("https://slumberjer.com/foodninjav2/php/load_foods.php", body: {
      "restid": widget.rest.restid,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        foodList = null;
        setState(() {
          titlecenter = "No Food Available";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          foodList = jsondata["foods"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadFoodDetails(int index) {
    Food curfood = new Food(
        foodid: foodList[index]['foodid'],
        foodname: foodList[index]['foodname'],
        foodprice: foodList[index]['foodprice'],
        foodqty: foodList[index]['foodqty'],
        restid: widget.rest.restid);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => FoodScreenDetails(
                  food: curfood,
                )));
  }
}
