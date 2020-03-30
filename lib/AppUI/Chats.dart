import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:the_link_up/Api/CheckAuth.dart';
import 'package:the_link_up/Api/RecentUserApi.dart';
import 'package:the_link_up/AppUI/ChatScreen.dart';
import 'package:the_link_up/ChatApp/src/models/user.dart';
import 'package:the_link_up/ChatApp/src/screens/home_screen.dart';
import 'package:the_link_up/Component/ActiveUser.dart';
import 'package:the_link_up/Component/CustomAppBar.dart';
import 'package:the_link_up/Component/FriendList.dart';
import 'package:the_link_up/Component/SearchField.dart';
import 'package:the_link_up/Controller/ChatPageController.dart';
import 'package:the_link_up/Model/RecentUserModel.dart';

import 'LeftDrawer.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final String activityPage = 'ChatPage';

  var widgetDistance = 10.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CallRecentUsers();
  }

  final storage = new FlutterSecureStorage();

  //var context;

  var token;

  //widget
  List<FriendList> friendListWidget = new List();
  List<FriendList> friendListWidget2 = new List();

  Future<String> GetToken() async {
    String value = await storage.read(key: 'token');
    return value;
  }



  void CallRecentUsers() async {
    print('CallRecentUsers ::::::::::::::::::::');
    token = await GetToken();

    if (token == null) {
      print('token is not valid');
      return;
    } else {
      print('token is valid::::::');
      print(token);
    }
    RecentUserApi api = new RecentUserApi();
    CheckAuth Cauth = new CheckAuth();
    var auth = await Cauth.callCheckAuth(token);
    print('===============');
    print(token);
    print(auth['id']);
    print(auth['name']);
    var currentUserId = auth['id'];
    //api.CallRecentUserApi(token);

    List<RecentUsers> recent_users_list = new List();
    recent_users_list = getRecentUsersList(await api.CallRecentUserApi(token));
    var j = 0;
    for (var i in recent_users_list) {
      j++;
      friendListWidget.add(
        FriendList(
          onPress: () {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          friendId: i.id,
                          userName: i.name,
                          currentUserId: currentUserId,
                          token: token,
                        )));
          },
          userName: i.name,
          imageUrl: i.pictureUrl,
          textBody: ' ',
          unread: i.unread,
        ),
      );
    }

    setState(() {
      friendListWidget2 = friendListWidget;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ChatPageController>(context);

    return Scaffold(
      drawer: LeftDrawer(context, activityPage),
      backgroundColor: Colors.white,
      appBar: appBar(
        context: context,
        newMessage: false,
        title: 'Messages',
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: <Widget>[
              /*      SizedBox(
                height: 10,
              ),
              //Search Bar
              Search_TextFeild(),
              SizedBox(
                height: 20,
              ),
              //Text: Online Users
              Container(
                // padding: EdgeInsets.all(10),
                width: double.infinity,
                // color: Colors.orange,
                child: Text(
                  'Online Users',
                  style: Theme.of(context).textTheme.subhead.copyWith(
                        color: Color(0xff3F3D56),
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              */ /*  SizedBox(
                height: widgetDistance,
              ),*/
              /*
              //Active User List
              Container(
                // color: Colors.green,
                height: 100,
                width: double.infinity,
                //  color: Colors.orange,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ActiveUser(
                      userName: 'Emma',
                      imageUrl:
                          "https://github.com/shawon1fb/storeImage/blob/master/squre/29-pixie-cut-with-highlights-and-bangs-BXaXhICgKs_.jpg?raw=true",
                    ),
                    ActiveUser(
                      userName: 'Sophia',
                      imageUrl:
                          "https://github.com/shawon1fb/storeImage/blob/master/squre/2_41.jpg?raw=true",
                    ),
                    ActiveUser(
                      userName: 'Mia',
                      imageUrl:
                          "https://github.com/shawon1fb/storeImage/blob/master/squre/hairstyles-for-square-face-shapes5.jpg?raw=true",
                    ),
                    ActiveUser(
                      userName: 'Isabella',
                      imageUrl:
                          "https://github.com/shawon1fb/storeImage/blob/master/squre/images.jpeg?raw=true",
                    ),
                    ActiveUser(
                      userName: 'Olivia',
                      imageUrl:
                          "https://github.com/shawon1fb/storeImage/blob/master/squre/kiera-knightley-long-bob-57bef22b3df78cc16ef95c5c.jpg?raw=true",
                    ),
                    ActiveUser(
                      userName: 'Billah2',
                      imageUrl:
                          "https://github.com/shawon1fb/storeImage/blob/master/squre/black.png?raw=true",
                    ),
                  ],
                ),
              ),
*/
              SizedBox(
                height: 20,
              ),
              // friend list
              Expanded(
                child: Container(
                  child: ListView(
                    children: friendListWidget2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createUser(userName, imgUrl) {
    // TODO: move logic to other widget
    final List<Color> colors = [
      Colors.pink,
      Colors.teal,
      Colors.blue,
      Colors.orange,
      Colors.yellow,
      Colors.purple,
      Colors.red
    ];

    final List<String> imageUrls = [
      'https://cdn4.iconfinder.com/data/icons/user-avatar-flat-icons/512/User_Avatar-04-512.png',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4LRADmE5sIaCA5kC7SaM2WDgzUH_ngB30-rgL6xfIcFdbnsUW',
      'https://image.flaticon.com/icons/png/512/306/306473.png',
      'https://banner2.kisspng.com/20180403/tkw/kisspng-avatar-computer-icons-user-profile-business-user-avatar-5ac3a1f7d96614.9721182215227704238905.jpg'
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkYcbCCLAF3opunLo7FJ7si5fwDhQJp0C__SpRM3QxSpVKJYOa',
    ];

    colors.shuffle();
    imageUrls.shuffle();

    Random random = new Random();

    int indexImage = random.nextInt(imageUrls.length - 1);
    int indexColor = random.nextInt(colors.length - 1);

    final User user = new User(
        name: userName, //textEditingController.text,
        imageUrl: imgUrl, //imageUrls[indexImage],
        color: colors[indexColor]);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Provider<User>(
          builder: (_) => user,
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Chat',
              theme: ThemeData(
                primarySwatch: Colors.orange,
              ),
              home: HomeScreen()),
        ),
      ),
    );
  }
}
