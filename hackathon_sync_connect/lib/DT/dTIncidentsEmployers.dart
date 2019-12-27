import 'package:flutter/material.dart';
import 'package:sync_connect/DT/dTHomeForCustomers.dart';
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
  List<Incident> _incidents;

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
    _incidents = <Incident>[];
    _domain = 'Select platform';
    _component = 'Select component';
    _incidentType = 'Internal';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
              ),
              Tab(
                text: 'Created',
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
              ),
              ListView(children: _getChildren())
            ],
          ),
        ),
      ),
    );
  }

  Widget _openCreateIncident(dynamic context) {
    Incident incident = Incident();
    return AlertDialog(
      content: Form(
        child: Container(
          width: 300,
          height: 650,
          child: ListView(
              scrollDirection: Axis.vertical,
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
                      if (value == 'Select component') incident.component = null;
                    }),
                Text('Title'),
                TextFormField(
                  onChanged: (String value){
                    incident.title = value;
                  },
                ),
                Text('Content'),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onChanged: (String value){
                    incident.content = value;
                  },
                ),
              ]),
        )
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

  List<Widget> _getChildren() {
    List<Widget> _children = <Widget>[];
    if (_incidents == null || _incidents.isEmpty) {
      _children.add(Text('No Incidents created by you'));
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
}
