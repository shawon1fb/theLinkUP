import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AppUI/Chats.dart';
import 'AppUI/profile_page.dart';
import 'Controller/ProfilePageController.dart';

void nav_to_profile(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (_) => ProfilePageController(),
        child: ProfilePage(),
      ),
    ),
  );
}

void NavToChatList(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Chats(),
    ),
  );
}
