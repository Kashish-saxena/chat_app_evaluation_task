import 'package:chat_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

import '../utils/color_constants.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(dynamic)? validator;
  final Function(String)? onChange;

  final TextEditingController controller;
  const TextFormFieldWidget({
    super.key,
    required this.hint,
    required this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
    this.validator,
    required this.controller,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyles.textStyleFont14Weight400.copyWith(color: ColorConstants.white),
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChange,
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: ColorConstants.blue38419D,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1)),
        hintText: hint,
        hintStyle: TextStyles.textStyleFont12Weight500.copyWith(color: ColorConstants.white),
        suffixIcon: suffixIcon,
        prefixIcon: Icon(prefixIcon,color: ColorConstants.white,),
        
      ),
    );
  }
}
