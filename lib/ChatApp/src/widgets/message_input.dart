import 'package:flutter/material.dart';
import 'package:the_link_up/Constant/APP_Gradient.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function onPressed;

  MessageInput({@required this.textEditingController, this.onPressed});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            flex: 9,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffFFFDFD),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextField(
                controller: widget.textEditingController,
                decoration: InputDecoration(
                    filled: true,
                    // fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    hintText: 'Send a message...'),
              ),
            ),
          ),
          Flexible(
            child: IconButton(
              color: Theme.of(context).primaryColor,
              disabledColor: Theme.of(context).primaryColorDark,
              icon: Icon(
                Icons.send,
                color: Colors.black.withOpacity(0.9),
              ),
              onPressed: widget.onPressed,
            ),
          )
        ],
      ),
    );
  }
}
