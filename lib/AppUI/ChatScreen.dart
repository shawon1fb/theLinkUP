import 'package:flutter/material.dart';
import 'package:the_link_up/Api/GetMessageWithUserApi.dart';
import 'package:the_link_up/Api/SentMessageApi.dart';
import 'package:the_link_up/Component/CustomAppBar.dart';
import 'package:the_link_up/Constant/ChatScreenConstant.dart';
import 'package:the_link_up/Model/GetMessageWithUserModel.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  ChatScreen({
    @required this.friendId,
    @required this.userName,
    @required this.currentUserId,
    @required this.token,
  });

  final friendId;
  final userName;
  final currentUserId;
  final token;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();

  String massageText;
  List<MessageBubble> messageList = new List();
  List<MessageBubble> messageListToDisplay = new List();

  @override
  void dispose() {
    // TODO: implement dispose
    loop = false;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print('================== CHAT =============================\n');
    // getUserMessage();
    loop = true;
    Resent();
  }

  bool loop;

  Future<String> test(int a) {
    Future<String> t = Future.delayed(Duration(seconds: 1), () {
      return '$a';
    });
    return t;
  }

  void Resent() async {
    for (var i = 0; loop; i++) {
      String s = await test(i);
      if (i % 5 == 0) {
        print('test no : $i');
        getUserMessage();
      }
    }
  }

  void getUserMessage() async {
    messageList.clear();
    GetMessageWithUser messageWithUser = new GetMessageWithUser();
    List<MessageBody> list = ProfileCardModelGenerator(
      await messageWithUser.callGetMessageWithUser(
          "${widget.token}", "${widget.friendId}"),
    );
    for (var text in list) {
      messageList.add(
        MessageBubble(
          isMe: text.sender_id == widget.currentUserId ? true : false,
          sender: text.sender_id.toString(),
          text: text.body.toString(),
        ),
      );
    }

    setState(() {
      print('set state =========');
      messageListToDisplay = messageList;
    });
  }

  void SentMessage(sentSms) async {
    /*  messageList.add(MessageBubble(
      isMe: true,
      sender: widget.currentUserId.toString(),
      text: sentSms,
    ));*/
/*
    setState(() {
      messageListToDisplay = messageList;
    });*/

    SentMessageAPi sentMessageAPi = new SentMessageAPi();
    var data = await sentMessageAPi.callSentMessage(
        widget.token, sentSms, widget.friendId.toString());
    messageList.clear();
    getUserMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
          context: context, title: '${widget.userName}', newMessage: false),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: MessageStream(
                messageListToDisplay: messageListToDisplay,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          //Do something with the user input.
                          massageText = value;
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: Colors.red,
                      highlightColor: Colors.brown,
                      splashColor: Colors.brown,
                      hoverColor: Colors.brown,
                      onTap: () {
                        messageTextController.clear();
                        if (massageText != null) {
                          SentMessage(massageText);
                          massageText = null;
                        }
                        //Implement send functionality.                      print(new DateTime.now());
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 8.0),
                        width: 50,
                        height: 48,
                        child: Center(
                          child: Icon(
                            Icons.send,
                            color: Color.fromRGBO(0, 0, 0, 0.9),
                          ),
                        ),
                      ), /*Text(
                        'Send',
                        style:
                            kSendButtonTextStyle.copyWith(color: Colors.orange),
                      ),*/
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  MessageStream({
    this.messageListToDisplay,
  });

  List<MessageBubble> messageListToDisplay = new List();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        reverse: true,
        children: <Widget>[] + messageListToDisplay,
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          /// USER NAME
          /* Text(
            '$sender',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12.0,
            ),
          ),*/
          Material(
            elevation: 5.0,
            borderRadius: isMe
                ? BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            color:
                isMe ? Color.fromRGBO(255, 216, 216, 0.8) : Color(0xffFD8E73),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Text(
                '$text',
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Quicksand',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
