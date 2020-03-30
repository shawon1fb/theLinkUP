import 'dart:io';
import 'package:flutter/material.dart';

class RoundImageLoader extends StatefulWidget {
  RoundImageLoader({
    this.image,
    this.onTap,
  });

  final File image;
  final Function onTap;

  @override
  _RoundImageLoaderState createState() => _RoundImageLoaderState();
}

class _RoundImageLoaderState extends State<RoundImageLoader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
      child: FittedBox(
        child: Container(
          child: InkWell(
            onTap: widget.onTap,
            child: Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                color: Color(0xff863B3B),
                border: Border.all(
                  color: Colors.transparent.withOpacity(0.1),
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(110.0),
                ),
                image: widget.image == null
                    ? null
                    : DecorationImage(
                        image: FileImage(widget.image), fit: BoxFit.cover),
              ),
              child: widget.image != null
                  ? null
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.camera_alt),
                          Center(
                              child: Text(
                            'Click to',
                            style: TextStyle(fontSize: 9.0),
                          )),
                          Center(
                              child: Text(
                            'Upload picture',
                            style: TextStyle(
                                fontSize: 9.0,
                                color: Colors.white.withOpacity(0.9)),
                          )),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
