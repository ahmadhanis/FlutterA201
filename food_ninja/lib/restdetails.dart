import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'restaurant.dart';

class RestDetails extends StatefulWidget {
  final Restaurant rest;
  const RestDetails({Key key, this.rest}) : super(key: key);

  @override
  _RestDetailsState createState() => _RestDetailsState();
}

class _RestDetailsState extends State<RestDetails> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rest.restname),
      ),
      body: Center(
        child: Column(children: [
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
        ]),
      ),
    );
  }
}
