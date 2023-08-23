import 'package:flutter/material.dart';

import '../app_constants/app_constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.buttonAction,
    required this.child,
  }) : super(key: key);

  final void Function() buttonAction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          minimumSize: const Size.fromHeight(40),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
        ),
        onPressed: buttonAction,
        child: child);
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.buttonAction,
    required this.child,
  }) : super(key: key);

  final void Function() buttonAction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryButtonFill,
          minimumSize: const Size.fromHeight(40),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
        ),
        onPressed: buttonAction,
        child: child);
  }
}

class SelectionButton extends StatelessWidget {
  const SelectionButton({
    Key? key,
    required this.buttonAction,
    required this.buttonText,
    required this.buttonSelection,
  }) : super(key: key);

  final void Function() buttonAction;
  final String buttonText;
  final bool buttonSelection;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonSelection ? primaryColor : secondaryButtonFill,
          minimumSize: const Size.fromHeight(40),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
        ),
        onPressed: buttonAction,
        child: Text(buttonText,
            style: robotoNormal.copyWith(
              color: buttonSelection ? white : primaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            )));
  }
}
