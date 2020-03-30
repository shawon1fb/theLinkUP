import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class BasicTimeField extends StatefulWidget {
  BasicTimeField({
    this.hintText,
    this.onSubmitted,
    this.prefixIconData,
  });

  final String hintText;
  final Icon prefixIconData;
  final Function onSubmitted;

  @override
  _BasicTimeFieldState createState() => _BasicTimeFieldState();
}

class _BasicTimeFieldState extends State<BasicTimeField> {
  final format = DateFormat("HH:mm");
  final hintStyle = TextStyle(
    color: Colors.white.withOpacity(0.8),
    fontFamily: 'Quicksand',
    fontStyle: FontStyle.normal,
  );
  final textStyle = TextStyle(
    color: Colors.white.withOpacity(0.8),
    fontFamily: 'Quicksand',
    fontStyle: FontStyle.normal,
  );

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      //  Text('Basic time field (${format.pattern})'),
      DateTimeField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.prefixIconData != null ? widget.prefixIconData : Icons.access_time,
            color: Colors.white,
          ),
          labelText: widget.hintText != null ? widget.hintText : 'Time',
          labelStyle: textStyle,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}
