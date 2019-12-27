import 'package:flutter/material.dart';
import 'dTIncidentsEmployers.dart';

class DTHomeForEmployers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('DT'),
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: <Color>[Colors.green, Colors.blue])),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.only(
                        left: 80, right: 80, top: 30, bottom: 30),
                    elevation: 4,
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        side: BorderSide(
                            width: 5,
                            style: BorderStyle.solid,
                            color: Colors.red)),
                    child: Text('Incident'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DTIncidentsForEmployers('Incident')));
                    },
                  ),
                ),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.only(
                        left: 80, right: 80, top: 30, bottom: 30),
                    color: Colors.green,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        side: BorderSide(
                            width: 5,
                            style: BorderStyle.solid,
                            color: Colors.red)),
                    child: Text('Forum'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DTIncidentsForEmployers('Forum')));
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
