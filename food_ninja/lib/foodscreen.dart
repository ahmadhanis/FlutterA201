import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'food.dart';

class FoodScreenDetails extends StatefulWidget {
  final Food food;

  const FoodScreenDetails({Key key, this.food}) : super(key: key);

  @override
  _FoodScreenDetailsState createState() => _FoodScreenDetailsState();
}

class _FoodScreenDetailsState extends State<FoodScreenDetails> {
  double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.foodname),
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight / 4,
            width: screenWidth / 0.3,
            child: CachedNetworkImage(
              imageUrl:
                  "http://slumberjer.com/foodninjav2/images/foodimages/${widget.food.foodid}.jpg",
              fit: BoxFit.cover,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(
                Icons.broken_image,
                size: screenWidth / 2,
              ),
            )),
        ],
      ),
    );
  }
}
