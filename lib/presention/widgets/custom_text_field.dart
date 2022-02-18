import 'package:fcih_app/constants/size_config.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Icon? prefixIcon;
  final void Function(String)? onChanged;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final int? maxLines;
  final int? minLines;
  final bool disabled;
  const CustomTextField({
    Key? key,
    this.prefixIcon,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.controller,
    this.maxLines,
    this.minLines,
    this.validation,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      enabled: disabled == true ? false : true,
      maxLines: maxLines,
      minLines: minLines,
      validator: validation,
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          fillColor: Colors.grey[300],
          hintText: hintText,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig.orientation == Orientation.portrait
                  ? getProportionScreenration(16)
                  : getProportionScreenration(60)),
          enabledBorder: InputBorder.none,
          filled: true),
    );
  }
}
