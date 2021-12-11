import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserRates extends StatefulWidget {
  String uid;

  UserRates({required this.uid});

  @override
  _UserRatesState createState() => _UserRatesState();
}

class _UserRatesState extends State<UserRates> {
  late List<String> messages = [];
  late List<double> rates = [];
  late List<Timestamp> dates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("rates")
            .where('uid', isEqualTo: widget.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Nie ma żadnych ocen'),
            );
          } else {
            snapshot.data.docs.forEach((element) {
              Map<String, dynamic> data = element.data();
              List<dynamic> messengesData = data['message'];
              List<dynamic> ratesData = data['rate'];
              List<dynamic> datesData = data['date'];

              messages = messengesData.cast<String>();
              rates = ratesData.cast<double>();
              dates = datesData.cast<Timestamp>();
            });
            if (dates.isEmpty) {
              return Center(
                child: Text('Nie ma żadnych ocen'),
              );
            } else {
              return ListView.builder(
                  itemCount: dates.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                          leading: CircleAvatar(
                            child: Text(rates[index].toString()),
                          ),
                          title: Column(
                            children: [
                              Text(dates[index].toDate().toString().substring(0,11)),
                              Text(messages[index])
                            ],
                          )),
                    );
                  });
            }
          }
        },
      ),
    );
  }
}
