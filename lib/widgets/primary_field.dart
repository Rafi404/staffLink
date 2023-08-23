import 'package:flutter/material.dart';

import '../app_constants/app_constants.dart';

class PrimaryField extends StatelessWidget {
  const PrimaryField({
    Key? key,
    required this.hintText,
    required this.fieldController,
    required this.fieldValidator,
    this.onChange,
    this.enabled = true,
    required this.fieldIcon,
  }) : super(key: key);
  final String hintText;
  final TextEditingController fieldController;
  final String? Function(String? text) fieldValidator;
  final Function(String)? onChange;
  final bool? enabled;
  final IconData fieldIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: fieldBorderColor, width: 1)),
      child: TextFormField(
          enabled: enabled,
          onChanged: onChange,
          validator: fieldValidator,
          textAlign: TextAlign.left,
          controller: fieldController,
          style: inputFieldStyle,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              fieldIcon,
              size: 20,
              color: primaryColor,
            ),
            hintText: hintText,
            hintStyle: inputFieldHintStyle,
            contentPadding:
                const EdgeInsets.only(top: 20, left: 20, bottom: 20),
            isDense: true,
            isCollapsed: true,
            counterText: "",
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: fieldBorderColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: fieldBorderColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            disabledBorder: InputBorder.none,
            fillColor: white,
            filled: true,
          )),
    );
  }
}

class SecondaryField extends StatelessWidget {
  const SecondaryField({
    Key? key,
    required this.hintText,
    required this.fieldController,
    required this.fieldValidator,
    this.onChange,
    this.enabled = true,
  }) : super(key: key);
  final String hintText;
  final TextEditingController fieldController;
  final String? Function(String? text) fieldValidator;
  final Function(String)? onChange;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: fieldBorderColor, width: 1)),
      child: TextFormField(
          enabled: enabled,
          onChanged: onChange,
          validator: fieldValidator,
          textAlign: TextAlign.left,
          controller: fieldController,
          style: inputFieldStyle,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.work_outline,
              color: primaryColor,
              size: 20,
            ),
            suffixIcon: const Icon(
              Icons.arrow_drop_down_outlined,
              size: 30,
              color: primaryColor,
            ),
            hintText: hintText,
            hintStyle: inputFieldHintStyle,
            contentPadding:
                const EdgeInsets.only(top: 20, left: 20, bottom: 20),
            isDense: true,
            isCollapsed: true,
            counterText: "",
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: fieldBorderColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: fieldBorderColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            disabledBorder: InputBorder.none,
            fillColor: white,
            filled: true,
          )),
    );
  }
}
