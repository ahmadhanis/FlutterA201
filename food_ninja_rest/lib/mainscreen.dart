import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'food.dart';
import 'newfoodscreen.dart';
import 'restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'updatefoodscreen.dart';

class MainScreen extends StatefulWidget {
  final Restaurant rest;

  const MainScreen({Key key, this.rest}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey;

  double screenHeight, screenWidth;
  List foodList;
  String titlecenter = "Loading Foods...";
  String type = "Food";

  @override
  void initState() {
    super.initState();
    _loadFoods(type);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rest.restname),
      ),
      // floatingActionButton: SpeedDial(
      //   animatedIcon: AnimatedIcons.menu_close,
      //   children: [
      //     SpeedDialChild(
      //         child: Icon(Icons.fastfood),
      //         label: "New Food",
      //         labelBackgroundColor: Colors.white,
      //         onTap: _newFoodScreen),
      //   ],
      // ),
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
                bottom: 10,
                left: 10,
                child: Column(
                  children: [
                    Text(
                      "Your Restaurant is:",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.rest.reststatus,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            children: [
              Tooltip(
                  message: 'Show Foods',
                  child: IconButton(
                    icon: Icon(Icons.food_bank),
                    iconSize: 32,
                    onPressed: () {
                      setState(() {
                        type = "Food";
                        _loadFoods(type);
                      });
                    },
                  )),
              Text(
                "Foods",
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
          Column(children: [
            Tooltip(
                message: 'Show Beverages',
                child: IconButton(
                  icon: Icon(Icons.emoji_food_beverage),
                  iconSize: 32,
                  onPressed: () {
                    setState(() {
                      type = "Beverage";
                      _loadFoods(type);
                    });
                  },
                )),
            Text(
              "Drinks",
              style: TextStyle(fontSize: 8),
            ),
          ]),
          Flexible(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(children: [
                Tooltip(
                    message: 'New Food/Beverage',
                    child: IconButton(
                      icon: Icon(Icons.fastfood),
                      iconSize: 32,
                      onPressed: () {
                        _newFoodScreen();
                      },
                    )),
                Text(
                  "New",
                  style: TextStyle(fontSize: 8),
                ),
              ]),
              Column(children: [
                Tooltip(
                    message: 'Show Orders',
                    child: IconButton(
                      icon: Icon(Icons.menu_book),
                      iconSize: 32,
                      onPressed: () {
                        setState(() {});
                      },
                    )),
                Text(
                  "Orders",
                  style: TextStyle(fontSize: 8),
                ),
              ]),
              Column(children: [
                Tooltip(
                    message: 'Open/Close Restaurant',
                    child: IconButton(
                      icon: Icon(Icons.sensor_door),
                      iconSize: 32,
                      onPressed: () {
                        _closeShopDialog();
                      },
                    )),
                Text(
                  widget.rest.reststatus,
                  style: TextStyle(fontSize: 8),
                ),
              ]),
            ],
          ))
        ]),
        Center(
            child: Container(
                child: Text(
          "Your Current $type Servings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ))),
        Divider(
          color: Colors.grey,
        ),
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
                child: RefreshIndicator(
                    key: refreshKey,
                    color: Color.fromRGBO(101, 255, 218, 50),
                    onRefresh: () async {
                      _loadFoods(type);
                    },
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (screenWidth / screenHeight) / 0.75,
                      children: List.generate(foodList.length, (index) {
                        return Padding(
                          padding: EdgeInsets.all(3),
                          child: Card(
                              child: InkWell(
                            onTap: () => _loadFoodDetails(index),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                      height: screenHeight / 5,
                                      width: screenWidth / 2.5,
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
                                  Text("RM " +
                                      foodList[index]['foodprice'] +
                                      " | Qty: " +
                                      foodList[index]['foodqty']),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        foodList[index]['status'],
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.check),
                                        iconSize: 16,
                                        onPressed: () {
                                          setState(() {
                                            _setAvailabilityDialog(index);
                                          });
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )),
                        );
                      }),
                    )),
              )
      ]),
    );
  }

  void _loadFoods(String ftype) {
    http.post("https://slumberjer.com/foodninjav2/php/load_foods.php", body: {
      "restid": widget.rest.restid,
      "type": ftype,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        foodList = null;
        setState(() {
          titlecenter = "No $type Available";
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

  _loadFoodDetails(int index) async {
    Food curfood = new Food(
        foodid: foodList[index]['foodid'],
        foodname: foodList[index]['foodname'],
        foodprice: foodList[index]['foodprice'],
        foodqty: foodList[index]['foodqty'],
        foodimg: foodList[index]['imgname'],
        restid: widget.rest.restid);

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => UpdateFoodScreen(
                  food: curfood,
                )));
    _loadFoods(type);
  }

  Future<void> _newFoodScreen() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => NewFoodScreen(
                  restaurant: widget.rest,
                )));
    _loadFoods(type);
  }

  // Future<bool> _onBackPressed() {
  //   return showDialog(
  //         context: context,
  //         builder: (context) => new AlertDialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(20.0))),
  //           title: new Text(
  //             'Are you sure?',
  //             style: TextStyle(
  //                 //color: Colors.white,
  //                 ),
  //           ),
  //           content: new Text(
  //             'Do you want to exit an App',
  //             style: TextStyle(
  //               color: Colors.white,
  //             ),
  //           ),
  //           actions: <Widget>[
  //             MaterialButton(
  //                 onPressed: () {
  //                   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  //                 },
  //                 child: Text(
  //                   "Exit",
  //                   style: TextStyle(
  //                       //color: Color.fromRGBO(101, 255, 218, 50),
  //                       ),
  //                 )),
  //             MaterialButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(false);
  //                 },
  //                 child: Text(
  //                   "Cancel",
  //                   style: TextStyle(
  //                       //color: Color.fromRGBO(101, 255, 218, 50),
  //                       ),
  //                 )),
  //           ],
  //         ),
  //       ) ??
  //       false;
  // }

  void _setAvailabilityDialog(int i) {
    String st;
    String food = foodList[i]['foodname'];
    if (foodList[i]['status'] == 'Available') {
      st = "Not Available";
    } else {
      st = "Available";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Set $food to $st",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: new Text(
            "Are you sure?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _onSetAvailability(i, st);
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onSetAvailability(int i, String st) {
    http.post("https://slumberjer.com/foodninjav2/php/set_foodsavail.php",
        body: {"foodid": foodList[i]['foodid'], "status": st}).then((res) {
      print(res.body);
      if (res.body == "success") {
        _loadFoods(type);
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      } else {
        Toast.show("Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _closeShopDialog() {
    String st;
    if (widget.rest.reststatus == "OPEN") {
      st = "CLOSE";
    } else {
      st = "OPEN";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Set Restaurant to $st ",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: new Text(
            "Are you sure?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _setStoreStatus(st);
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _setStoreStatus(String st) {
    http.post("https://slumberjer.com/foodninjav2/php/set_store_status.php",
        body: {"restid": widget.rest.restid, "status": st}).then((res) {
      print(res.body);
      if (res.body == "success") {
        setState(() {
          widget.rest.reststatus = st;
        });
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      } else {
        Toast.show("Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      }
    }).catchError((err) {
      print(err);
    });
  }
}
