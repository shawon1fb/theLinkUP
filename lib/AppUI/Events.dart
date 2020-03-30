import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:the_link_up/Api/CheckAuth.dart';
import 'package:the_link_up/Api/ConnectWithUser.dart';
import 'package:the_link_up/Api/GetNearByPostApi.dart';
import 'package:the_link_up/Component/CustomAppBar.dart';
import 'package:the_link_up/Component/CustomCardView.dart';
import 'package:the_link_up/Component/CustomeEmptyCard.dart';
import 'package:the_link_up/Component/ProfileCard.dart';
import 'package:the_link_up/Constant/constant.dart';
import 'package:the_link_up/Controller/EventsController.dart';
import 'package:the_link_up/Fcm/FcmController.dart';
import 'package:the_link_up/Model/ProfileCardModel.dart';
import 'package:the_link_up/tools/appTools.dart';
import 'package:toast/toast.dart';
import 'ChatScreen.dart';
import 'Chats.dart';
import 'LeftDrawer.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

////'https://avatars0.githubusercontent.com/u/37122193?s=400&u=4350e74d1a06430cad9ef46c070a9912f289de0d&v=4',

class _EventsPageState extends State<EventsPage> {
  final String activityPage = 'EventPage';
  BuildContext context;

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  GetNearByPostApi api = new GetNearByPostApi();
  List<ProfileCardModel> profileList = new List();
  List<ProfileCard> _profiles = new List();
  final storage = new FlutterSecureStorage();
  var page, limit, lat, lng, token;
  int pageViewIndexPage = 0;

  Future GetToken() async {
    String value = await storage.read(key: 'token');
    if (value == null) {
      print('user not authintatic');
      return;
    }
    return value;
  }

  void makeToast(context, text) {
    Toast.show(
      "$text",
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.CENTER,
    );
  }

  bool success = false;

  void callConnectWithUserApi() async {
    var sentRequistId = list[pageViewIndexPage];
    print('requist id   ======================');
    print(sentRequistId.name);
    print(sentRequistId.id);
    ConnectWithUser connectWithUser = new ConnectWithUser();
    token = await GetToken();
    bool b = false;
    if (token != null) {
      try {
        var body =
            await connectWithUser.callConnectWithUser(sentRequistId.id, token);
        b = body['success'];
        if (b) {
          friendListSet.add(sentRequistId.id);
        }
      } catch (e) {
        print(e);
      }
    } else {
      /// token problem
    }

    setState(() {
      success = b;

      connectedList[pageViewIndexPage] = b;
    });
  }

  List<ProfileCardModel> list = new List();

  List<bool> connectedList = List();
  Set friendListSet = new Set();
  bool message = false;

  void callApi() async {
    List<ProfileCard> profiles = new List();
    list.clear();
    String value = await storage.read(key: 'token');
    if (value == null) {
      print('user not authintatic');
      Navigator.of(context).pop();
      return;
    }
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    page = 1;
    limit = 10;
    lat = position.latitude;
    lng = position.latitude;
    token = value;
    list = ProfileCardModelGenerator(
        await api.callGetNearByPostApi(page, limit, lat, lng, token));
    for (var i in list) {
      connectedList.add(i.isConnected);
      if (i.isConnected) {
        friendListSet.add(i.id);
      }
      print('=============iiiiiii=========');
      print(i.name);
      profiles.add(ProfileCard(
        imageUrl: i.imagesUrl,
        userName: i.name,
        address: i.address,
      ));
    }
    setState(() {
      id = list[0].id.toString();
      name = list[0].name.toString();
      _profiles = profiles;
      success = friendListSet.contains(list[pageViewIndexPage].id);
    });
    print('inside Event::::::::::::::::');
  }

  final fcm = FcmController().stream;
  final test = FcmController().newMessageStream;

  void showData(data) {
    showSnackBar(data, _scaffoldKey);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAuth();
    callApi();
    fcm.listen(
        (data) {
          print(
              "fcm lissener==================from event=============================================================");
          print(data);
          // makeToast(context, data);
          showData(data);
        },
        onError: (err) {
          print(err);
        },
        cancelOnError: false,
        onDone: () {
          print('done!!!');
        });

    test.listen((b) {
      print(b);
      setmessage(b);
    });
  }

  void setmessage(bool b) {
    setState(() {
      this.message = b;
    });
  }

  String id, name, currentUserId;

  getAuth() async {
    var _token = await GetToken();
    this.token = token;
    CheckAuth Cauth = new CheckAuth();
    var auth = await Cauth.callCheckAuth(_token);
    this.currentUserId = auth['id'].toString();
  }

  void NavToMessage() async {
    print("----------- NavToMessage ----------------->>>>>>>>>>>>>");

    print(currentUserId);
    print(id);
    print(name);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatScreen(
                  friendId: id,
                  userName: name,
                  currentUserId: this.currentUserId.toString(),
                  token: this.token,
                )));
  }

  @override
  Widget build(BuildContext context) {
    final fcmCont = Provider.of<FcmController>(context);
    final appState = Provider.of<EventsController>(context);
    this.context = context;

    var SkinHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backGroundColor2,
      appBar: appBar(
          context: context, title: "Let's Hangout", newMessage: this.message),
      drawer: LeftDrawer(context, activityPage),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            BackgroundWhiteCard(),

            ///========Card============

            Align(
              alignment: Alignment(0, -0.5),
              child: CustomCardView(
                elevation: 5,
                borderRadius: 10,
                child: CustomEmptyCard(
                  height: 360.0,
                  borderRadius: 10,
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.6),
              child: CustomCardView(
                elevation: 5,
                borderRadius: 10,
                child: CustomEmptyCard(
                  height: 360.0,
                  borderRadius: 10,
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.7),
              child: CustomCardView(
                elevation: 5,
                borderRadius: 10,
                child: CustomEmptyCard(
                  height: 360.0,
                  borderRadius: 10,
                ),
              ),
            ),
            /*   Align(
              alignment: Alignment(0, -0.7),
              child: CustomCardView(
                elevation: 5,
                borderRadius: 10,
                child: CustomEmptyCard(
                  height: 360.0,
                  borderRadius: 10,
                ),
              ),
            ),*/
            Align(
              alignment: Alignment(0, -.9),
              child: Container(
                  height: 450,
                  child: PageView(
                    controller: appState.controller,
                    onPageChanged: (int page) {
                      pageViewIndexPage = page;
                      id = list[page].id.toString();
                      name = list[page].name.toString();

                      print('===========Page=================');
                      print(page);
                      setState(() {
                        success = friendListSet.contains(list[page].id);
                      });
                    },
                    children: _profiles,
                  )),
            ),
            ProfileBottomButton(
              crossButton: () {
                appState.previousButton(context);
              },
              connectButton: success ? NavToMessage : callConnectWithUserApi,
              connectButtonText: success ? 'message' : 'connect',
              loveButton: () {
                appState.nextButton(context);
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Chats(),
                  ),
                );*/
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*

ProfileCard(
imageUrl:
'https://github.com/shawon1fb/StoreImage/blob/master/158533.jpg?raw=true',
userName: "Gisele Bündchen",
address: "USA",
),
ProfileCard(
imageUrl:
'https://github.com/shawon1fb/StoreImage/blob/master/Selena-Gomez-2017-HD-Wallpaper_thumb2x.jpg?raw=true',
userName: "Selena-Gomez",
address: "USA",
),
ProfileCard(
imageUrl:
'https://github.com/shawon1fb/StoreImage/blob/master/a7663f1dd6635781992151cf550c71cd.jpg?raw=true',
userName: "Alexandra daddario",
address: "France",
),
ProfileCard(
imageUrl:
'https://github.com/shawon1fb/StoreImage/blob/master/unnamed.jpg?raw=true',
userName: "Chloë Grace Moretz",
address: "USA",
),
ProfileCard(
imageUrl:
'https://github.com/shawon1fb/StoreImage/blob/master/gettyimages-480667731-1572901927.jpg?raw=true',
userName: "Emma watson",
address: "France",
),*/
