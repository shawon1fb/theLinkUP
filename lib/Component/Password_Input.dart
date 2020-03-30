import 'package:flutter/material.dart';

class Password_Inpute extends StatefulWidget {
  Password_Inpute({
    this.hint,
    this.validator,
    this.onSaved,
    this.focusNode,
    this.onFieldSubmitted,
  });

  final hint;
  final FocusNode focusNode;
  final Function validator;
  final Function onSaved;
  final Function onFieldSubmitted;


  @override
  _Password_InputeState createState() => _Password_InputeState();
}

class _Password_InputeState extends State<Password_Inpute> {
  bool passwordVisible = true;
  final textStyle = TextStyle(
    color: Colors.white.withOpacity(0.8),
    fontFamily: 'Quicksand',
    fontStyle: FontStyle.normal,
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: widget.onFieldSubmitted,
      focusNode: widget.focusNode,
      // autofocus: true,
      obscureText: passwordVisible,
      onSaved: widget.onSaved,
      validator: widget.validator,
      style: textStyle,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: textStyle,
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            }),
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
