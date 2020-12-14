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
  var locList = {"Changlun", "Sintok", "Bkt Kayu Hitam"};
  String selectedLoc = "Changlun";
  @override
  void initState() {
    super.initState();
    _loadRestaurant(selectedLoc);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate =
        "${dateParse.hour}:${dateParse.minute}-${dateParse.day}/${dateParse.month}/${dateParse.year}";

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
          Container(
            //height: screenHeight / 12,
            width: screenWidth / 0.5,
            child: SingleChildScrollView(child:  
            Card(
              child: Column(
                children: [
                  Text(
                    "Welcome " + widget.user.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text("The time is " + formattedDate),
                ],
              ),
            ),
          )),
          //Divider(color: Colors.grey),
          Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Select Location"),
                  SizedBox(width: 40),
                  DropdownButton(
                    //sorting dropdownoption
                    hint: Text(
                      'Quantity',
                      style: TextStyle(
                          //color: Color.fromRGBO(101, 255, 218, 50),
                          ),
                    ), // Not necessary for Option 1
                    value: selectedLoc,
                    onChanged: (newValue) {
                      setState(() {
                        selectedLoc = newValue;
                        print(selectedLoc);
                        _loadRestaurant(selectedLoc);
                      });
                    },
                    items: locList.map((selectedLoc) {
                      return DropdownMenuItem(
                        child: new Text(selectedLoc.toString(),
                            style: TextStyle(color: Colors.black)),
                        value: selectedLoc,
                      );
                    }).toList(),
                  ),
                ],
              )),

          Text("Please choose a restaurant"),
          Divider(color: Colors.grey),
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
                  childAspectRatio: (screenWidth / screenHeight) / 0.65,
                  children: List.generate(restList.length, (index) {
                    return Padding(
                        padding: EdgeInsets.all(1),
                        child: Card(
                            child: InkWell(
                          onTap: () => _loadRestaurantDetail(index),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                    height: screenHeight / 4.5,
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
                              ],
                            ),
                          ),
                        )));
                  }),
                ))
        ],
      ),
    ));
  }

  void _loadRestaurant(String loc) {
    http.post("https://slumberjer.com/foodninjav2/php/load_restaurant.php",
        body: {
          "location": loc,
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
        restimage: restList[index]['restimage'],
        restradius: restList[index]['restradius'],
        restlatitude: restList[index]['restlatitude'],
        restlongitude: restList[index]['restlongitude'],
        restdelivery: restList[index]['restdelivery']
        );

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
            builder: (BuildContext context) =>
                ShoppingCartScreen(user: widget.user)));
  }
}
