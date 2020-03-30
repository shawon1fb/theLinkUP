import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomNetworkImageViewer extends StatefulWidget {
  CustomNetworkImageViewer({
    @required this.url,
    this.backgroundColor,
    this.borderRadius,
    this.boxFit,
    this.height,
    this.width,
  }) : assert(url != null);

  final String url;
  final double borderRadius;
  final double height;
  final double width;
  final BoxFit boxFit;
  final Color backgroundColor;

  @override
  _CustomNetworkImageViewerState createState() =>
      _CustomNetworkImageViewerState();
}

class _CustomNetworkImageViewerState extends State<CustomNetworkImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.backgroundColor != null
              ? widget.backgroundColor
              : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(
            widget.borderRadius != null ? widget.borderRadius : 1.0,
          )),
          image: DecorationImage(
            fit: widget.boxFit,
            image: NetworkImage(
              '${widget.url}',
            ),
          ),
        ),
      ),
    );
  }
}
