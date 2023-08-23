import 'package:flutter/material.dart';

import '../app_constants/app_constants.dart';

class EmployeeListHeader extends StatelessWidget {
  const EmployeeListHeader({Key? key, required this.headerText})
      : super(key: key);
  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: bottomBarBorderColor,
      padding: const EdgeInsets.all(16),
      child: Text(
        headerText,
        style: robotoNormal.copyWith(
            fontWeight: FontWeight.w500, fontSize: 16, color: primaryColor),
      ),
    );
  }
}
