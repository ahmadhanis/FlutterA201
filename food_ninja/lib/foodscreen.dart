import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'food.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'user.dart';
import 'package:numberpicker/numberpicker.dart';

class FoodScreenDetails extends StatefulWidget {
  final Food food;
  final User user;

  const FoodScreenDetails({Key key, this.food, this.user}) : super(key: key);

  @override
  _FoodScreenDetailsState createState() => _FoodScreenDetailsState();
}

class _FoodScreenDetailsState extends State<FoodScreenDetails> {
  double screenHeight, screenWidth;
  int selectedQty = 0;
  final TextEditingController _remcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedQty = int.parse(widget.food.foodcurqty) ?? 1;
    _remcontroller.text = widget.food.remarks;
  }

  @override
  Widget build(BuildContext context) {
    var foodQty =
        Iterable<int>.generate(int.parse(widget.food.foodqty) + 1).toList();
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.food.foodname),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: screenHeight / 3.8,
                          width: screenWidth / 0.1,
                          child: CachedNetworkImage(
                            imageUrl:
                                "http://slumberjer.com/foodninjav2/images/foodimages/${widget.food.foodimg}.jpg",
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                new CircularProgressIndicator(),
                            errorWidget: (context, url, error) => new Icon(
                              Icons.broken_image,
                              size: screenWidth / 2,
                            ),
                          )),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Select Quantity"),
                          SizedBox(width: 10),
                          NumberPicker.horizontal(
                            decoration: BoxDecoration(
                              border: new Border(
                                top: new BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.black26,
                                ),
                                bottom: new BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                            initialValue: selectedQty,
                            minValue: 1,
                            maxValue: foodQty.length - 1,
                            step: 1,
                            zeroPad: false,
                            onChanged: (value) =>
                                setState(() => selectedQty = value),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("Price RM " +
                          (selectedQty * double.parse(widget.food.foodprice))
                              .toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      TextField(
                          controller: _remcontroller,
                          keyboardType: TextInputType.text,
                          maxLines: 3,
                          decoration: InputDecoration(
                              labelText: 'Your Remark',
                              icon: Icon(Icons.notes))),
                      SizedBox(height: 10),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        minWidth: 300,
                        height: 50,
                        child: Text('Add/Update Cart'),
                        color: Colors.black,
                        textColor: Colors.white,
                        elevation: 15,
                        onPressed: _onOrderDialog,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ))));
  }

  void _onOrderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Order " + widget.food.foodname + "?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: new Text(
            "Quantity " + selectedQty.toString(),
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
                _orderFood();
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

  void _orderFood() {
    http.post("https://slumberjer.com/foodninjav2/php/insert_cart.php", body: {
      "email": widget.user.email,
      "foodid": widget.food.foodid,
      "foodqty": selectedQty.toString(),
      "remarks": _remcontroller.text,
      "restid": widget.food.restid,
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show(
          "Success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        Navigator.pop(context);
      } else {
        Toast.show(
          "Failed",
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
