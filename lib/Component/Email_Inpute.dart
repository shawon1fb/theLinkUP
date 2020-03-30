import 'package:flutter/material.dart';

class Email_Input extends StatefulWidget {
  Email_Input({
    this.focusNode,
    // this.onSubmitted,
    this.hint,
    this.prefixIconData,
    this.onFieldSubmitted,
    this.validator,
    this.onSaved,
    this.keyboardType,
    this.onChanged,
  });

  final focusNode;
  final String hint;

  // final Function onSubmitted;
  final IconData prefixIconData;
  final Function onFieldSubmitted;
  final Function validator;
  final Function onSaved;
  final Function onChanged;
  final TextInputType keyboardType;

  @override
  _Email_InputState createState() => _Email_InputState();
}

class _Email_InputState extends State<Email_Input> {
  final textStyle = TextStyle(
    color: Colors.white.withOpacity(0.8),
    fontFamily: 'Quicksand',
    fontStyle: FontStyle.normal,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        // autofocus: true,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
        // key: key,
        validator: widget.validator,
        onSaved: widget.onSaved,
        focusNode: widget.focusNode,
        // onSubmitted: widget.onSubmitted,
        textInputAction: TextInputAction.done,
        keyboardType: widget.keyboardType != null
            ? widget.keyboardType
            : TextInputType.emailAddress,
        style: textStyle,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.prefixIconData != null ? widget.prefixIconData : Icons.email,
            color: Colors.white,
          ),
          hintText: widget.hint != null ? widget.hint : 'Email',
          hintStyle: textStyle,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
