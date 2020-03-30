import 'package:flutter/material.dart';
import 'package:the_link_up/Constant/Constant_Color.dart';

class ConnectButton extends StatefulWidget {
  ConnectButton({
    this.buttonText,
    this.backgroundColor,
    this.textColor,
    this.onPress,
    this.prefixIcon,
  });

  final buttonText;
  final Color backgroundColor;
  final textColor;
  final Function onPress;
  final IconData prefixIcon;

  @override
  _ConnectButtonState createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<ConnectButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15.0,
        ),
        color: (widget.backgroundColor != null)
            ? widget.backgroundColor
            : Colors.white,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Material(
          elevation: 5,
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(5.0),
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
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Transform.rotate(
                        angle: 45.0,
                        child: Icon(
                          Icons.link,
                          size: 20,
                          color: Color(0xffFF617E),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(
                        '${widget.buttonText}',
                        style: Theme.of(context).textTheme.button.copyWith(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0,
                              fontFamily: 'Quicksand',
                              color: widget.textColor != null
                                  ? widget.textColor
                                  : Color(0xffFF637E),
                            ),
                      ),
                    ),
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
