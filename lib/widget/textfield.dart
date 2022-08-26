import 'package:flutter/material.dart';
import 'package:flutter_bloc/constant/colors.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function onChanged;

  const MyTextField({
    required this.hintText,
    required this.obscureText,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(onChanged:((value) => onChanged),
      obscureText: obscureText,
      style: TextStyle(fontSize: 20, color: AppColor.black),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 18, color: AppColor.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
