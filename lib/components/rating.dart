import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:helpermate/pages/userRates.dart';

class RatingRead extends StatelessWidget {
  int rate;
  int numberOfrate;
  String uid;

  RatingRead(
      {required this.rate, required this.numberOfrate, required this.uid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => UserRates(uid: uid)));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Oceny: ($numberOfrate): ",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          RatingBar.builder(
            initialRating: rate.toDouble(),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            ignoreGestures: true,
            itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (double value) {},
          ),
        ],
      ),
    );
  }
}

class Rating extends StatelessWidget {
  ValueSetter<double> callback;

  Rating({required this.callback});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 0,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (double value) {
        callback(value);
      },
    );
  }
}