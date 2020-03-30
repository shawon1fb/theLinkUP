import 'package:flutter/material.dart';
import 'package:the_link_up/Constant/Constant_Color.dart';

class WhiteButton extends StatefulWidget {
  WhiteButton({
    this.buttonText,
    this.backgroundColor,
    this.textColor,
    this.onPress,
  });

  final buttonText;
  final Color backgroundColor;
  final textColor;
  final Function onPress;

  @override
  _WhiteButtonState createState() => _WhiteButtonState();
}

class _WhiteButtonState extends State<WhiteButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          35.0,
        ),
        color: (widget.backgroundColor != null)
            ? widget.backgroundColor
            : Colors.white,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Material(
          color: Colors.transparent,
          //borderRadius: BorderRadius.circular(35.0),

          child: InkWell(
            borderRadius: BorderRadius.circular(35.0),
            highlightColor: buttonHorColor,
            hoverColor: buttonHorColor,
            splashColor: buttonHorColor,
            focusColor: buttonHorColor,
            onTap: widget.onPress,
            // color: Colors.orange,

            /*
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: Colors.red),
            ),*/
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  '${widget.buttonText}',
                  style: Theme.of(context).textTheme.button.copyWith(
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Quicksand',
                      color: widget.textColor != null
                          ? widget.textColor
                          : Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
