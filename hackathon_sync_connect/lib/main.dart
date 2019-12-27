import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import './list_view_animation/componets/ListViewEffect.dart';

GlobalKey current_User_login = GlobalKey<State>();

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );
  runApp(MediaQuery(
      data: MediaQueryData(), child: MaterialApp(home: SyncConnect())));
}

class SyncConnect extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SyncConnetcState();
  }
}

class SyncConnetcState extends State<SyncConnect> {
  Timer initialStartUpTimer;
  bool initialPageCompleted = false;
  bool circularProgressIndicatior = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    initialStartUpTimer?.cancel();
  }

  void startTimer() {
    initialStartUpTimer =
        Timer(Duration(seconds: !initialPageCompleted ? 2 : 3), () {
      if (!initialPageCompleted) {
        initialPageCompleted = true;
      } else {
        circularProgressIndicatior = true;
      }
      initialStartUpTimer.cancel();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    Widget widget;
    if (!initialPageCompleted && !circularProgressIndicatior) {
      widget = MaterialApp(
        home: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/sync_connect_logo.jpg')))),
      );
    } else if (initialPageCompleted && !circularProgressIndicatior) {
      widget = MaterialApp(
          home: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          AssetImage('assets/images/sync_connect_logo.jpg')))),
          Center(
              child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 70, maxWidth: 70),
                  child: CircularProgressIndicator()))
        ],
      ));
    } else {
      widget = Home_Page(key: current_User_login);
    }
    return widget;
  }
}

class Home_Page extends StatefulWidget {
  Home_Page({Key key}) : super(key: key);
  Home_Page_State createState() => new Home_Page_State();
}

class Home_Page_State extends State<Home_Page> {
  CurrenUserData currenUserData;
  final List<CurrenUserData> currenUserData_List = [
    CurrenUserData(index: 0, name: "Employee Login"),
    CurrenUserData(index: 1, name: "Customer Login"),
  ].toList();
  Duration _duration = Duration(milliseconds: 300);

  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
            child: new Container(
                padding: EdgeInsets.only(top: 100),
                child: new ListViewEffect(
                    duration: _duration,
                    children: currenUserData_List
                        .map((CurrenUserData currentData) =>
                            _buildWidgetExample(currentData))
                        .toList()))));
  }

  Widget _buildWidgetExample(CurrenUserData currenUserData) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        height: 100,
        width: double.infinity,
        margin: EdgeInsets.all(30),
        child: new Center(
            child: new Text(currenUserData.name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20))));
  }
}

class CurrenUserData {
  CurrenUserData({this.name, this.index});
  String name;
  int index;
}
