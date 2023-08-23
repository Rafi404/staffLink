import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stafflink/view/add_employee_page/add_employee_page.dart';

import '../app_constants/app_constants.dart';

class FloatButton extends StatelessWidget {
  const FloatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddEmployeePage(), transition: Transition.cupertino);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
