import 'package:todo_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final double? width;
  final double? height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final int? maxLines;
  final TextEditingController? controller;

  const TextFieldWidget({
    super.key,
    required this.hintText,
    this.labelText,
    this.errorText,
    this.width,
    this.height = 60,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Adaptive.w(86),
      height: height,
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        maxLines: maxLines,
        cursorColor: Constants.textThreeColor,
        obscureText: obscureText!,
        style: const TextStyle(
          fontFamily: "FontMedium",
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Constants.hintTextColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          prefixIconColor: Constants.textThreeColor,
          suffixIcon: suffixIcon,
          suffixIconColor: Constants.textThreeColor,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Constants.hintTextColor,
              fontSize: 14),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Constants.textThreeColor),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Constants.textThreeColor),
          ),
          contentPadding: EdgeInsets.only(left: Adaptive.w(0)),
          hintStyle: const TextStyle(
            fontFamily: "FontMedium",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Constants.hintTextColor,
          ),
        ),
      ),
    );
  }
}
