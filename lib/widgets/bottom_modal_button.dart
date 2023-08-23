import 'package:flutter/material.dart';

import '../app_constants/app_constants.dart';

class BottomModalButton extends StatelessWidget {
  const BottomModalButton(
      {Key? key, required this.buttonAction, required this.buttonText})
      : super(key: key);

  final void Function() buttonAction;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          surfaceTintColor: primaryColor,
          child: InkWell(
            splashColor: primaryColor,
            onTap: buttonAction,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      buttonText,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: modalButtonTextColor),
                    ),
                  ],
                )),
          ),
        ),
        const Divider(color: bottomBarBorderColor, thickness: 1),
      ],
    );
  }
}
