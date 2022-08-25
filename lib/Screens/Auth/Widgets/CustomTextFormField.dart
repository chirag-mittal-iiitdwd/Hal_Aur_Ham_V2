import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String valueKey;
  final String errorMessage;
  final Function saveVariable;
  final int inputlength;
  final TextInputType keyboardType;
  final String hintTextValue;
  CustomTextFormField({
    this.valueKey,
    this.errorMessage,
    this.saveVariable,
    this.inputlength,
    this.keyboardType,
    this.hintTextValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(valueKey),
      validator: (value) {
        if (value.length == inputlength) {
          return null;
        }
        if (inputlength == 10000 && value.length != 0) {
          return null;
        }
        return errorMessage;
      },
      onSaved: (value) {
        saveVariable(value);
      },
      keyboardType: keyboardType,
      autofocus: false,
      style: TextStyle(
        fontSize: 15.sp,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintTextValue,
        filled: true,
        fillColor: Color(0x99FFDFB0),
        contentPadding: const EdgeInsets.only(
          left: 14.0,
          bottom: 6.0,
          top: 8.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x99FFDFB0),
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
