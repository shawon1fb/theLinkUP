import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:the_link_up/AppUI/Events.dart';
import 'package:the_link_up/AppUI/LoginPage.dart';
import 'package:the_link_up/AppUI/PostAnEvent.dart';
import 'AppUI/profile_page.dart';
import 'AppUI/resetPassword/ResetPassword.dart';
import 'Component/DatePicker.dart';
import 'Constant/constant.dart';
import 'Controller/ChatPageController.dart';
import 'Controller/EventsController.dart';
import 'Controller/LoginController.dart';
import 'Controller/MailVerificationController.dart';
import 'Controller/PostAnEventController.dart';
import 'Controller/ProfilePageController.dart';
import 'Controller/RegisterController.dart';
import 'Fcm/FcmController.dart';
import 'Helper/StaticMemory.dart';
import 'PluginOverride/CustomeSplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ChatPageController(),
        ),
        ChangeNotifierProvider.value(
          value: RegisterController(),
        ),
        ChangeNotifierProvider.value(
          value: LoginController(),
        ),
        ChangeNotifierProvider.value(
          value: PostAnEventController(),
        ),
        ChangeNotifierProvider.value(
          value: EventsController(),
        ),
        ChangeNotifierProvider.value(
          value: MailVerificationController(),
        ),
        ChangeNotifierProvider.value(
          value: FcmController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Link Up',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        backgroundColor: Color(0xffFBA06A),
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: lightOrange,
        accentColor: deepOrange,
        cursorColor: Colors.white,
        // Define the default font family.
        fontFamily: 'Quicksand',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontFamily: 'Quicksand',
          ),
          subhead: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontFamily: 'Quicksand',
          ),
          title: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontFamily: 'Quicksand',
          ),
          subtitle: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontFamily: 'Quicksand',
          ),
          body1: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Quicksand',
            fontStyle: FontStyle.normal,
          ),
          body2: TextStyle(
            fontSize: 12.0,
            fontFamily: 'Quicksand',
          ),
          button: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.normal,
            fontFamily: 'Quicksand',
            color: Color(0xffFFFEFE),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

bool flag = false;

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    routePage();
  }

  final storage = new FlutterSecureStorage();

  Future routePage() async {
    bool b = false;
    String value = await storage.read(key: 'token');
    String userName = await storage.read(key: 'userName');
    StaticTempMemory.userName = userName;

    if (value == null) {
      b = false;
    } else {
      b = true;
    }
    flag = b;
    return b;
  }

  @override
  Widget build(BuildContext context) {
    return new CustomSplashScreen(
      seconds: 2,
      navigateAfterSeconds: new AfterSplash(),
      //  image: new Image.asset('images/loading_screen.gif'),

      onClick: () => print("Flutter Egypt"),
      // backgroundColor: Color(0xffFCC56B),
      image: Image.asset(
        'images/logo/splash.png',
        // fit: BoxFit.cover,
        //height: MediaQuery.of(context).size.height * .5,
        // width: MediaQuery.of(context).size.width * .5,
      ),
      photoSize: 150,
      gradientBackground: backgroundLinearGradient,

/*      imageBackground: AssetImage(
        'images/logo/logo.png',
      ),*/
      //  loaderColor: Color(0xffFCC56B),
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: flag ? EventsPage() : LoginPage(),
    );
  }
}
