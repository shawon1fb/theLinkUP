import 'package:flutter/material.dart';

class CustomCardView extends StatefulWidget {
  CustomCardView({
    this.elevation,
    this.borderRadius,
    this.child,
  });

  final double borderRadius;
  final double elevation;
  final Widget child;

  @override
  _CustomCardViewState createState() => _CustomCardViewState();
}

class _CustomCardViewState extends State<CustomCardView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(
          widget.borderRadius != null ? widget.borderRadius : 1.0)),
      elevation: widget.elevation != null ? widget.elevation : 1.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
                widget.borderRadius != null ? widget.borderRadius : 0.0),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
