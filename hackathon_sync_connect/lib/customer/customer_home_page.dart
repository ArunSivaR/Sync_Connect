import 'package:flutter/material.dart';
import 'package:hackathon_sync_connect/list_view_animation/componets/ListViewEffect.dart';

class CustomerHomePage extends StatefulWidget {
  CustomerHomePageState createState() => new CustomerHomePageState();
}

class CustomerHomePageState extends State<CustomerHomePage> {
  List<String> _list = ["HR Portal"].toList();
  Duration _duration = Duration(milliseconds: 300);

  Widget build(BuildContext context) {
    return new Scaffold(
      
        body: Center(
            child: new Container(
                padding: EdgeInsets.all(10),
                child: new ListViewEffect(
                    duration: _duration,
                    children:
                        _list.map((s) => _buildWidgetExample(s)).toList()))));
  }

  Widget _buildWidgetExample(String text) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.all(30),
        child: new Center(
            child: new Text(text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20))));
  }
}
