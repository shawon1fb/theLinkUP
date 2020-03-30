import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FriendList extends StatefulWidget {
  FriendList({
    this.imageUrl,
    this.userName,
    this.textBody,
    this.onPress,
    this.unread,
  });

  final String imageUrl;
  final String userName;
  final String textBody;
  final Function onPress;
  bool unread;

  @override
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            widget.unread = false;
          });
          widget.onPress();
        },
        child: Row(
          children: <Widget>[
            // user image holder
            Container(
              height: 60,
              width: 60,
              child: CachedNetworkImage(
                color: Colors.orange,
                imageUrl: '${widget.imageUrl}',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.red,
                        width: 3,
                        style: widget.unread
                            ? BorderStyle.solid
                            : BorderStyle.none),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      /*
                      colorFilter: ColorFilter.mode(
                        Colors.red,
                        BlendMode.colorBurn,
                      ),*/
                    ),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${widget.userName}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    /*   Text(
                      '${widget.textBody}',
                      style: TextStyle(
                        color: Color(0xffB1B0B0),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Quicksand',
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
