import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  DatePicker({
    this.hint,
  });

  final String hint;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String _value = '';
  var Controller = new TextEditingController();

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(3022));
    if (picked != null) {
      setState(() {
        _value = picked.toString().split(' ')[0];
        Controller.text = _value;
      });
    }
  }

  final textStyle = TextStyle(
    color: Colors.white.withOpacity(0.8),
    fontFamily: 'Quicksand',
    fontStyle: FontStyle.normal,
  );

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.calendar_today,
            color: Colors.white,
          ),
          labelText: "${widget.hint}",
          labelStyle: textStyle,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        controller: Controller,
        onTap: () {
          _selectDate();
        },
      ),
    );
  }
}
