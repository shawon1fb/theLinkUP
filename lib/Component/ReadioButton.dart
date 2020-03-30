import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  RadioButton({
    this.gender,
    this.onChange,
  });

  final int gender;
  final Function onChange;

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

//enum Gender { male, female, other }

class _RadioButtonState extends State<RadioButton> {
  //Gender gender = Gender.male;

  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 35,
                ),
                Radio(
                  value: 1,
                  activeColor: Colors.green,
                  groupValue: widget.gender,
                  onChanged: widget.onChange,
                ),
                Text('Male'),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Radio(
                  value: 2,
                  activeColor: Colors.red,
                  groupValue: widget.gender,
                  onChanged: widget.onChange,
                ),
                Text('Female'),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Radio(
                  value: 3,
                  activeColor: Colors.black,
                  groupValue: widget.gender,
                  onChanged: widget.onChange,
                ),
                Text('Other'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
