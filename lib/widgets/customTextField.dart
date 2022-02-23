import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double? height;
  final bool shapeIsCircular;
  final Color bodyColor;
  final String? initVal;
  final TextEditingController? txtEditingController;
  final void Function()? onTaped;
  final void Function(String) onChanged;
  final String? Function(String?)? valid;
  final bool obscure;
  final String hintTxt;
  final TextStyle? hintStyle;
  final Icon? icon;
  final Widget? prefix;
  final Widget? suffix;
  final bool? autoFocus;
  CustomTextField({
    required this.bodyColor,
    required this.onChanged,
    this.obscure = false,
    required this.valid,
    required this.hintTxt,
    this.icon,
    this.suffix,
    this.prefix,
    this.initVal,
    this.shapeIsCircular = false,
    this.onTaped,
    this.txtEditingController,
    this.height,
    this.hintStyle,
    this.autoFocus,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          color: bodyColor,
          borderRadius: shapeIsCircular ? BorderRadius.circular(20) : null),
      padding: const EdgeInsets.only(left: 8.0),
      child: TextFormField(
        autofocus: autoFocus ?? false,
        controller: txtEditingController,
        initialValue: initVal,
        onTap: onTaped,
        onChanged: onChanged,
        validator: valid,
        obscureText: obscure,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintTxt,
            hintStyle: hintStyle,
            icon: icon,
            prefixIcon: prefix,
            suffixIcon: suffix),
      ),
    );
  }
}
