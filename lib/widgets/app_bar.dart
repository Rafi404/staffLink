import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stafflink/view/home_page/home_page.dart';

import '../app_constants/app_constants.dart';
import '../controller/app_controller.dart';

class PrimaryAppBar extends StatelessWidget {
  PrimaryAppBar({Key? key, required this.appBarText}) : super(key: key);
  final appController = Get.put(AppMainController());

  final String appBarText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              appController.clearEmployeesTable();
            },
            child: Text(
              appBarText,
              style: appBarHead,
            ),
          ),
          const Spacer(),
          appController.editMode
              ? Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();

                      appController.deleteEmployee(appController.employeeName);

                      appController.insertIntoPreviousEmployees(
                        appController.employeeName,
                        appController.employeeRole,
                        appController.employeeStartDate,
                        appController.employeeEndDate,
                      );

                      appController.getData();
                      appController.getPreviousData();
                      appController.editMode = false;
                      appController.update();
                      Get.offAll(const HomePage(),
                          transition: Transition.cupertino);
                    },
                    child: const Icon(
                      Icons.delete,
                      size: 25,
                      color: white,
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
      backgroundColor: primaryColor,
    );
  }
}
