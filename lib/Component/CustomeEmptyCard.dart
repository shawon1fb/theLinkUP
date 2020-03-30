import 'package:flutter/material.dart';

class CustomEmptyCard extends StatefulWidget {
  CustomEmptyCard({
    this.borderRadius,
    this.color,
    this.height,
    this.width,
  });

  final double borderRadius;
  final double height;
  final double width;
  final Color color;

  @override
  _CustomEmptyCardState createState() => _CustomEmptyCardState();
}

class _CustomEmptyCardState extends State<CustomEmptyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.color != null ? widget.color : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
                widget.borderRadius != null ? widget.borderRadius : 0.0),
          ),
        ),
      ),
    );
  }
}
