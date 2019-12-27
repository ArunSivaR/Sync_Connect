import 'package:flutter/material.dart';
import 'dropDown.dart';

class DTHomeForCustomers extends StatefulWidget {
  @override
  DTHomeForCustomersState createState() => DTHomeForCustomersState();
}

class DTHomeForCustomersState extends State<DTHomeForCustomers> {
  String _component;
  String _domain;
  List<Incident> _incidents;

  final List<String> _componentList = <String>[
    'Select component',
    'SfCalendar',
    'SfChart',
    'SfGauge',
  ].toList();

  final List<String> _domainList = <String>[
    'Select platform',
    'Xamarin',
    'Flutter',
  ].toList();

  @override
  void initState() {
    _incidents = <Incident>[];
    _domain = 'Select platform';
    _component = 'Select component';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Center(
          child: Text('DT Home'),
        ),
        leading: Icon(Icons.perm_identity),
        actions: <Widget>[Icon(Icons.notifications_active)],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: _getChildren(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Create Incident',
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => _openCreateIncident(context),
          );
        },
      ),
    );
  }

  List<Widget> _getChildren() {
    List<Widget> _children = <Widget>[];
    if (_incidents == null || _incidents.isEmpty) {
      _children.add(Text('No Incidents creates'));
    } else {
      for (int i = 0; i < _incidents.length; i++) {
        _incidents[i].component = _incidents[i].component ?? 'General';
        _incidents[i].platform = _incidents[i].platform ?? 'General';
        _children.add(Card(
            color: Colors.purple,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  style: BorderStyle.solid, color: Colors.teal[600], width: 5),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.all(10),
            elevation: 30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                    _incidents[i].title ?? '',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    _incidents[i].content ?? '',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text(
                    _incidents[i].platform + ' | ' + _incidents[i].component,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )));
      }
    }

    return _children;
  }

  Widget _openCreateIncident(dynamic context) {
    Incident incident = Incident();
    return AlertDialog(
      content: Form(
        child: Container(
          width: 300,
          height: 650,
          child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
            Text('Enter Customer ID/Email'),
            TextFormField(
              onChanged: (String value) {
                incident.customerID = value;
              },
            ),
            Text('Select Platform'),
            DropDown(
                value: _domain,
                item: _domainList.map((String value) {
                  return DropdownMenuItem<String>(
                      value: (value != null) ? value : 'Select platform',
                      child: Text(
                        '$value',
                        textAlign: TextAlign.center,
                      ));
                }).toList(),
                valueChanged: (dynamic value) {
                  _domain = value;
                  incident.platform = value;
                  if (value == 'Select platform') incident.platform = null;
                }),
            Text('Select Component'),
            DropDown(
                value: _component,
                item: _componentList.map((String value) {
                  return DropdownMenuItem<String>(
                      value: (value != null) ? value : 'Select component',
                      child: Text(
                        '$value',
                        textAlign: TextAlign.center,
                      ));
                }).toList(),
                valueChanged: (dynamic value) {
                  _component = value;
                  incident.component = value;
                  if(value == 'Select component')
                    incident.component = null;
                }),
            Text('Title'),
            TextFormField(onChanged: (String value) {
              incident.title = value;
            }),
            Text('Content'),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (String value) {
                incident.content = value;
              },
            ),
          ]),
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          child: Text('Submit'),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              if (incident.title.isNotEmpty || incident.content.isNotEmpty) {
                _incidents.add(incident);
              }
            });
          },
        )
      ],
    );
  }
}

class Incident {
  String customerID;
  String title;
  String content;
  String platform;
  String component;
}

typedef IncidentCreated = void Function(
    CreatedIncidentDetails createdIncidentDetails);

class CreatedIncidentDetails{
  Incident incident;
}