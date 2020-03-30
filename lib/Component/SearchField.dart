import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Search_TextFeild extends StatelessWidget {

  final txtStyle=TextStyle(
    color: Color.fromRGBO(79, 78, 78, 0.8),
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontFamily: 'Quicksand',
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Color.fromRGBO(217, 216, 215, 0.7),
      ),
      child: TextField(
        scrollPadding: EdgeInsets.only(top: 10,bottom: 10),
        cursorColor: Colors.green,
        style: txtStyle,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search,color: Colors.black,),
          hintText: "Search",
          hintStyle:txtStyle,
          /*  border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFEDEDED)),
              borderRadius: BorderRadius.circular(30.0),
              ),*/
        ),
      ),
    );
  }
}
