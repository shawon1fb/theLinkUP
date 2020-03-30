import 'package:flutter/material.dart';
import 'package:the_link_up/AppUI/Chats.dart';
import 'package:the_link_up/AppUI/Events.dart';
import 'package:the_link_up/AppUI/LoginPage.dart';
import 'package:the_link_up/AppUI/PostAnEvent.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:the_link_up/Constant/APP_Gradient.dart';
import 'package:the_link_up/Helper/StaticMemory.dart';

import '../all_route.dart';

final storage = new FlutterSecureStorage();
final SelectedColor = Colors.deepOrange;
var hight = 100.0;

Widget LeftDrawer(context, activityPage) {
  bool selectedFlag = false;
  return Drawer(
    child: Container(
      decoration: BoxDecoration(
        gradient: leftToRightLinearGradient,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            height: hight,
            width: hight / 1.03,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'images/logo/splash.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            child: ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text(
                "What's Going On",
                style: Theme.of(context).textTheme.subhead,
              ),
              onTap: () {
                if (activityPage != "PostAnEventPage") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostAnEvent(),
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            child: ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text(
                "Let's Hangout",
                style: Theme.of(context).textTheme.subhead,
              ),
              onTap: () {
                if (activityPage != 'EventPage') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventsPage(),
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            child: ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text(
                "Messages",
                style: Theme.of(context).textTheme.subhead,
              ),
              onTap: () {
                if (activityPage != 'ChatPage') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chats(),
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            child: ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text(
                "Profile",
                style: Theme.of(context).textTheme.subhead,
              ),
              onTap: () {
                if (activityPage != 'updateProfile') {
                  nav_to_profile(context);
                }
              },
            ),
          ),
          Container(
            child: ListTile(
              trailing: Icon(Icons.exit_to_app),
              title: Text(
                'Log out (${StaticTempMemory.userName})',
                style: Theme.of(context).textTheme.subhead,
              ),
              onTap: () async {
                await storage.deleteAll();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
