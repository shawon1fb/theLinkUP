import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  DropDownList({
    @required this.dropdownValue,
    @required this.onChanged,
    @required this.itemList,
  });

  final String dropdownValue;
  final Function onChanged;
  final List<String> itemList;

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  static const double paddingBottom = 25.0;
  final textStyle = TextStyle(
    color: Colors.white.withOpacity(0.8),
    fontFamily: 'Quicksand',
    fontStyle: FontStyle.normal,
    fontSize: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.dropdownValue,
      icon: Padding(
        padding: const EdgeInsets.only(bottom: paddingBottom),
        child: Icon(
          Icons.arrow_drop_down_circle,
        ),
      ),
      iconSize: 24,
      elevation: 16,
      isExpanded: true,
      style: TextStyle(
        color: Colors.white,
      ),
      underline: Container(
        height: 1.2,
        // width: double.infinity,
        color: Colors.white,
      ),
      onChanged: widget.onChanged,
      items: widget.itemList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            padding: const EdgeInsets.only(
              bottom: paddingBottom,
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.local_activity,
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      style: textStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
