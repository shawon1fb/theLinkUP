import 'package:flutter/material.dart';
import 'package:the_link_up/Constant/APP_Gradient.dart';

class RoundButton extends StatefulWidget {
  RoundButton({
    @required this.iconData,
    this.boxSize,
    this.onPress,
    this.gradient,
    this.iconColor,
    this.backgroundColor,
    this.iconSize,
  }) : assert((iconData != null), "Must be provide an IconData For button");

  final double boxSize;
  final double iconSize;
  final IconData iconData;
  final Function onPress;
  final Gradient gradient;
  final Color backgroundColor;
  final Color iconColor;

  @override
  _RoundButtonState createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: widget.boxSize,
        width: widget.boxSize,
        decoration: BoxDecoration(
          color: widget.backgroundColor != null
              ? widget.backgroundColor
              : null, //Colors.transparent,
          gradient: widget.gradient != null
              ? widget.gradient
              : null, //leftToRightLinearGradient,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: InkWell(
            onTap: widget.onPress,
            child: Center(
              child: Icon(
                widget.iconData,
                color:
                    widget.iconColor != null ? widget.iconColor : Colors.white,
                size: widget.iconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
