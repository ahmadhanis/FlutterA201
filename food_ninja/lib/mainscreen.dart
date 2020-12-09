import 'package:flutter/material.dart';
import 'package:food_ninja/restaurant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'restdetails.dart';
import 'user.dart';
import 'ShoppingCartScreen.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List restList;
  double screenHeight, screenWidth;
  String titlecenter = "Loading Restaurant...";

  @override
  void initState() {
    super.initState();
    _loadRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Available Restaurants'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              _shoppinCartScreen();
            },
          )
        ],
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
                  crossAxisCount: 2,
                  childAspectRatio: (screenWidth / screenHeight) / 0.8,
                  children: List.generate(restList.length, (index) {
                    return Padding(
                        padding: EdgeInsets.all(1),
                        child: Card(
                          child: InkWell(
                            onTap: () => _loadRestaurantDetail(index),
                            child: Column(
                              children: [
                                Container(
                                    height: screenHeight / 3.8,
                                    width: screenWidth / 1.2,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "http://slumberjer.com/foodninjav2/images/restaurantimages/${restList[index]['restimage']}.jpg",
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
                                  restList[index]['restname'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(restList[index]['restphone']),
                                Text(restList[index]['restlocation']),
                              ],
                            ),
                          ),
                        ));
                  }),
                ))
        ],
      ),
    ));
  }

  void _loadRestaurant() {
    http.post("https://slumberjer.com/foodninjav2/php/load_restaurant.php",
        body: {
          "location": "Changlun",
        }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        restList = null;
        setState(() {
          titlecenter = "No Restaurant Found";
        });
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

  _loadRestaurantDetail(int index) {
    print(restList[index]['restname']);
    Restaurant restaurant = new Restaurant(
        restid: restList[index]['restid'],
        restname: restList[index]['restname'],
        restlocation: restList[index]['restlocation'],
        restphone: restList[index]['restphone'],
        restimage: restList[index]['restimage']);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => RestScreenDetails(
                  rest: restaurant,
                  user: widget.user,
                )));
  }

  void _shoppinCartScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ShoppingCartScreen(user:widget.user)));
  }
}
