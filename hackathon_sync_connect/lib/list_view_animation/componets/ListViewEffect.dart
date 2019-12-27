import 'package:flutter/material.dart';
import '../bloc/ListBloc.dart';
import '../componets/ItemEffect.dart';
import '../../employee/home_page.dart';
import '../../customer/customer.dart';
import '../../main.dart';

class ListViewEffect extends StatefulWidget {
  final Duration duration;
  final List<Widget> children;

  ListViewEffect({Key key, this.duration, this.children});
  _ListViewEffect createState() => new _ListViewEffect();
}

class _ListViewEffect extends State<ListViewEffect> {
  ListBloc _listBloc;

  Home_Page_State home_page_state;

  initState() {
    _listBloc = new ListBloc();
    super.initState();
  }

  Widget build(BuildContext context) {
    _listBloc.startAnimation(widget.children.length, widget.duration);

    return Center(
        child: new ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.children.length,
            itemBuilder: (context, position) {
              return GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    home_page_state = current_User_login.currentState;
                    if (position == 0) {
                      home_page_state.currenUserData =
                          CurrenUserData(index: 0, name: "Employee Login");
                      Navigator.of(context).pushReplacement((MaterialPageRoute(
                          builder: (BuildContext context) => EmployeeHome())));
                    } else {
                      home_page_state.currenUserData =
                          CurrenUserData(index: 1, name: "Customer Login");
                      Navigator.of(context).pushReplacement((MaterialPageRoute(
                          builder: (BuildContext context) => CustomerHome())));
                    }
                  },
                  child: ItemEffect(
                      child: widget.children[position],
                      duration: widget.duration,
                      position: position));
            }));
  }

  @override
  void dispose() {
    _listBloc.dispose();
    super.dispose();
  }
}
