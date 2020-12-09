import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'food.dart';
import 'newfoodscreen.dart';
import 'restaurant.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  final Restaurant rest;
  const MainScreen({Key key, this.rest}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.rest.restname),
            actions: [
              new DropdownButton<String>(
                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              )
            ],
          ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            children: [
              SpeedDialChild(
                  child: Icon(Icons.fastfood),
                  label: "New Food",
                  labelBackgroundColor: Colors.white,
                  onTap: _newFoodScreen),
            ],
          ),
          body: Column(children: [
            Stack(
              children: [
                Container(
                    height: screenHeight / 4,
                    width: screenWidth / 0.3,
                    child: CachedNetworkImage(
                      imageUrl:
                          "http://slumberjer.com/foodninjav2/images/restaurantimages/${widget.rest.restimage}.jpg",
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                      errorWidget: (context, url, error) => new Icon(
                        Icons.broken_image,
                        size: screenWidth / 2,
                      ),
                    )),
                Positioned(
                    top: 100,
                    right: 2,
                    child: Card(
                        child: Container(
                            height: 60,
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.rest.restname,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                Text(widget.rest.restlocation),
                                Text(widget.rest.restphone),
                              ],
                            )))),
              ],
            ),
            Center(
                child: Container(
                    child: Text(
              "Your Current Servings",
              style: TextStyle(fontWeight: FontWeight.bold),
            ))),
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
                                            "http://slumberjer.com/foodninjav2/images/foodimages/${foodList[index]['imgname']}.jpg",
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
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
        ));
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

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => FoodScreenDetails(
    //               food: curfood,
    //             )));
  }

  Future<void> _newFoodScreen() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => NewFoodScreen(
                  restaurant: widget.rest,
                )));
    _loadFoods();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Are you sure?',
              style: TextStyle(
                  //color: Colors.white,
                  ),
            ),
            content: new Text(
              'Do you want to exit an App',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text(
                    "Exit",
                    style: TextStyle(
                        //color: Color.fromRGBO(101, 255, 218, 50),
                        ),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        //color: Color.fromRGBO(101, 255, 218, 50),
                        ),
                  )),
            ],
          ),
        ) ??
        false;
  }
}
