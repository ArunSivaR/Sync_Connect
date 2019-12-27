import 'package:flutter/material.dart';
import 'dropDown.dart';

class DTIncidentsForEmployers extends StatefulWidget {
  DTIncidentsForEmployers(this.selectedType);

  final String selectedType;

  @override
  DTIncidentsForEmployersState createState() => DTIncidentsForEmployersState();
}

class DTIncidentsForEmployersState extends State<DTIncidentsForEmployers> {
  String _component;
  String _domain;
  String _incidentType;

  final List<String> _componentList = <String>[
    'Select component',
    'SfCalendar',
    'SfChart',
    'SfGauge',
  ].toList();

  final List<String> _incidentTypeList = <String>[
    'Customer',
    'Internal',
  ].toList();

  final List<String> _domainList = <String>[
    'Select platform',
    'Xamarin',
    'Flutter',
  ].toList();

  @override
  void initState() {
    _domain = 'Select platform';
    _component = 'Select component';
    _incidentType = 'Internal';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.selectedType),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Pendings',
              ),
              Tab(
                text: 'Promissed',
              ),
              Tab(
                text: 'Post processing',
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Search'),
                              TextFormField(),
                            ],
                          ),
                          actions: <Widget>[
                            RaisedButton(
                              child: Text('Search'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      );
                    });
              },
            ),
            Icon(Icons.notifications_active)
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => _openCreateIncident(context),
            );
          },
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: <Color>[Colors.green, Colors.blue])),
          child: TabBarView(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Text('Pending Incidents will be displayed here')
                ],
              ),
              ListView(
                children: <Widget>[
                  Text('Promised Incidents will be displayed here')
                ],
              ),
              ListView(
                children: <Widget>[
                  Text('Post processing incidents will be displayed here')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _openCreateIncident(dynamic context) {
    return AlertDialog(
      content: Form(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Incident Type'),
              DropDown(
                  value: _incidentType,
                  item: _incidentTypeList.map((String value) {
                    return DropdownMenuItem<String>(
                        value: (value != null) ? value : 'Internal',
                        child: Text(
                          '$value',
                          textAlign: TextAlign.center,
                        ));
                  }).toList(),
                  valueChanged: (dynamic value) {
                    _incidentType = value;
                  }),
              Text('Enter Customer ID/Email'),
              TextFormField(),
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
                  }),
              Text('Title'),
              TextFormField(),
              Text('Content'),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ]),
      ),
      actions: <Widget>[
        RaisedButton(
          child: Text('Submit'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
