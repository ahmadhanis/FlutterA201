import 'package:flutter/material.dart';
import 'food.dart';
import 'foodscreen.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class ShoppingCartScreen extends StatefulWidget {
  final User user;
  
  const ShoppingCartScreen({Key key, this.user}) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List cartList;
  double screenHeight, screenWidth;
  String titlecenter = "Loading Cart...";
  final formatter = new NumberFormat("#,##");
  double totalPrice = 0.0;
  String restName = "";
  int numcart = 0;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Container(
              height: screenHeight / 4,
              width: screenWidth / 0.3,
              child: Card(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      widget.user.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("There are " +
                        numcart.toString() +
                        " item/s in your cart"),
                    Text("Total amount payable RM " +
                        totalPrice.toStringAsFixed(2)),
                  ],
                ),
              ))),
          Text("Content of your cart"),
          cartList == null
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
                  childAspectRatio: (screenWidth / screenHeight) / 0.75,
                  children: List.generate(cartList.length, (index) {
                    return Padding(
                        padding: EdgeInsets.all(1),
                        child: Card(
                            child: InkWell(
                          onTap: () => _loadFoodDetails(index),
                          onLongPress: () => _deleteOrderDialog(index),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                    height: screenHeight / 4,
                                    width: screenWidth / 1.2,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "http://slumberjer.com/foodninjav2/images/foodimages/${cartList[index]['imagename']}.jpg",
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
                                  cartList[index]['foodname'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("RM " +
                                    cartList[index]['foodprice'] +
                                    " x " +
                                    cartList[index]['foodqty'] +
                                    " set"),
                                Text("Total RM " +
                                    (double.parse(
                                                cartList[index]['foodprice']) *
                                            int.parse(
                                                cartList[index]['foodqty']))
                                        .toStringAsFixed(2))
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

  _loadFoodDetails(int index) async {
    Food curfood = new Food(
        foodid: cartList[index]['foodid'],
        foodname: cartList[index]['foodname'],
        foodprice: cartList[index]['foodprice'],
        foodqty: cartList[index]['availqty'],
        foodimg: cartList[index]['imagename'],
        restid: cartList[index]['restid'],
        foodcurqty: cartList[index]['foodqty'],
        remarks: cartList[index]['remarks']);

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => FoodScreenDetails(
                  food: curfood,
                  user: widget.user,
                )));
    _loadCart();
  }

  void _loadCart() {
    http.post("https://slumberjer.com/foodninjav2/php/load_cart.php", body: {
      "email": widget.user.email,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        cartList = null;
        setState(() {
          titlecenter = "No Item Found";
        });
      } else {
        totalPrice=0;
        numcart=0;
        setState(() {
          var jsondata = json.decode(res.body);
          cartList = jsondata["cart"];
          for (int i = 0; i < cartList.length; i++) {
            totalPrice = totalPrice +
                double.parse(cartList[i]['foodprice']) *
                    int.parse(cartList[i]['foodqty']);
            numcart = numcart + int.parse(cartList[i]['foodqty']);
          }
          restName = cartList[0]['restname'];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _deleteOrderDialog(int index) {
    print("Delete " + cartList[index]['foodname']);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Delete order " + cartList[index]['foodname'] + "?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: new Text(
            "Are your sure? ",
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
              onPressed: () async {
                Navigator.of(context).pop();
                _deleteCart(index);
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

  void _deleteCart(int index) {
    http.post("https://slumberjer.com/foodninjav2/php/delete_cart.php", body: {
      "email": widget.user.email,
      "foodid": cartList[index]['foodid'],
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        _loadCart();
        Toast.show(
          "Delete Success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      } else {
        Toast.show(
          "Delete failed!!!",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      }
    }).catchError((err) {
      print(err);
    });
  }
}
