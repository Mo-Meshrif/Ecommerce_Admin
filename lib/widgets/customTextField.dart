import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Color bodyColor;
  final String initVal;
  final void Function(String) onChanged;
  final String Function(String) valid;
  final bool obscure;
  final String hintTxt;
  final Icon icon;
  final Widget prefix;
  final Widget suffix;

  CustomTextField({
    @required this.bodyColor,
    @required this.onChanged,
    this.obscure = false,
    @required this.valid,
    @required this.hintTxt,
    @required this.icon,
    this.suffix,
    this.prefix,
    this.initVal,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: bodyColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextFormField(
          initialValue: initVal,
          onChanged: onChanged,
          validator: valid,
          obscureText: obscure,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintTxt,
              icon: icon,
              prefixIcon: prefix,
              suffixIcon: suffix),
        ),
      ),
    );
  }
}
