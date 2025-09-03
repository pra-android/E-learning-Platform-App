import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginCustomTextfield extends StatelessWidget {
  final TextEditingController tc;
  final Icon prefixIcon;
  final String hintText;
  final bool? obscureText;
  final IconButton? suffixIcon;

  const LoginCustomTextfield({
    super.key,
    required this.tc,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: tc,
      obscureText: obscureText ?? false,
      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        fillColor: Colors.blueGrey.shade50,
        filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        hintText: hintText,
        hintStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade200),
        ),
      ),
    );
  }
}
