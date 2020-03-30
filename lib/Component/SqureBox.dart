import 'package:flutter/material.dart';
import 'dart:io';

class SqureBox extends StatefulWidget {
  SqureBox({
    this.image,
    this.onTap,
  });

  final File image;
  final Function onTap;

  @override
  _SqureBoxState createState() => _SqureBoxState();
}

class _SqureBoxState extends State<SqureBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff342323), //Color(0xff342323),
            image: widget.image == null
                ? null
                : DecorationImage(
                    image: FileImage(widget.image), fit: BoxFit.cover),
          ),
          height: MediaQuery.of(context).size.height * 0.25,
          child: widget.image != null
              ? null
              : Center(
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Center(
                      child: FlatButton(
                       // onPressed: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xffFF617E),
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.cloud_upload,
                                color: Color(0xffFF617E),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Upload Image',
                                style: Theme.of(context)
                                    .textTheme
                                    .body2
                                    .copyWith(color: Color(0xffFF617E)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
