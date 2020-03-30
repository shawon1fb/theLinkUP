import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_link_up/Constant/APP_Gradient.dart';
import 'package:the_link_up/Constant/Constant_Color.dart';
import 'package:the_link_up/Controller/PostAnEventController.dart';
import 'package:the_link_up/Fcm/FcmController.dart';

import '../all_route.dart';

Widget appBar({context, title, bool newMessage}) {
  bool b = (title != "Messages") ? true : false;

  return AppBar(
    elevation: 5,
    backgroundColor: backGroundColor2,
    title: Text(
      '$title',
      style: Theme.of(context).textTheme.button,
    ),
    automaticallyImplyLeading: true,
    actions: <Widget>[
      Visibility(
        visible: b,
        child: InkWell(
          onTap: () {
            if (title != "Messages") NavToChatList(context);
            FcmController.newMessage = false;
          },
          child: FcmController.newMessage
              ? messageIcon(
                  key: ValueKey(2),
                  color: Colors.red,
                )
              : messageIcon(
                  key: ValueKey(1),
                  color: Colors.white,
                ),
        ),
      ),
      SizedBox(
        width: 10,
      ),
    ],
    primary: true,
    iconTheme: new IconThemeData(color: Colors.white),

    /*leading: new IconButton(
      icon: new Icon(Icons.menu, color: Colors.white),
      onPressed: () {
        print('Menu pressed===================');
        Scaffold.of(context).openDrawer();
      },
    ),*/
    flexibleSpace: Container(
      decoration: BoxDecoration(gradient: leftToRightLinearGradient),
    ),
  );
}

class messageIcon extends StatefulWidget {
  messageIcon({Key key, this.newMessage, this.color}) : super(key: key);

  final bool newMessage;
  final Color color;

  @override
  _messageIconState createState() => _messageIconState();
}

class _messageIconState extends State<messageIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Icon(
          Icons.message,
          color: widget.color,
          key: ValueKey(1),
        ),
      ),
    );
  }
}
