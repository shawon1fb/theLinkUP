import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ActiveUser extends StatelessWidget {
  ActiveUser({
    @required this.imageUrl,
    @required this.userName,
  });

  final String imageUrl;
  final String userName;

  @override
  Widget build(BuildContext context) {
    var imageSize = MediaQuery.of(context).size.width / 6.0;
    return Container(
      height: 90,
      padding: EdgeInsets.only(right: 10, top: 10),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            height: 60,
            width: 60,
            child: CachedNetworkImage(
              color: Colors.orange,
              imageUrl:
                  '$imageUrl',
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit
                        .cover, /*
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
          //online flag
          Positioned(
            top: 45,
            left: 45,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                color: Color(0xff05D91B),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 65,
            child: Text(
              '$userName',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
