import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Entry point of an Application

void main() =>
    runApp(MaterialApp(title: "Flutter Application", home: new ShapeBody()));

/// Define my state of the widget called every time when setState is called

class ShapeBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RestApi();
}

class RestApi extends State<ShapeBody> {
  final String baseUrl = "http://swapi.co/api/people";
  List data;
  static const String routeName = '/cupertino/progress_indicator';

  @override
  void initState() {
    super.initState();
    this.getData();
    debugPrint("init state");
  }

  Future<String> getData() async {
    var response = await http
        .get(Uri.encodeFull(baseUrl), headers: {"Accept": "application/json"});
    debugPrint("Api Response : " + response.body);

    setState(() {
      var jsonData = jsonDecode(response.body);
      data = jsonData['results'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Rest API'),
      ),
      body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext mContext, int index) {
            return new Container(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: Text(data[index]['name']),
                      padding: const EdgeInsets.all(20.0),
                    ),
                    elevation: 2.0,
                    shape: StadiumBorder(),
                  )
                ],
              ),
            );
          }),
    );
  }
}
