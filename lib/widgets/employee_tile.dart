import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stafflink/view/add_employee_page/add_employee_page.dart';

import '../app_constants/app_constants.dart';
import '../controller/app_controller.dart';

class EmployeeTile extends StatelessWidget {
  EmployeeTile({Key? key, this.employee, required this.index})
      : super(key: key);
  final appController = Get.put(AppMainController());

  final Map<String, dynamic>? employee;
  final int index;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Dismissible(
          background: Container(
            alignment: Alignment.centerRight,
            color: Colors.redAccent,
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.delete_forever,
                size: 25,
                color: white,
              ),
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (val) {
            showSnackBar(context);
            appController.insertIntoPreviousEmployees(
                employee?["empName"],
                employee?["role"],
                employee?["startDate"],
                employee?["endDate"]);

            appController.deleteEmployee(employee?["empName"]);

            appController.getData();
            appController.update();
          },
          key: _listKey,
          child: GestureDetector(
            onTap: () {
              appController.editMode = true;
              appController.update();
              appController.employeeName = employee!["empName"].toString();
              appController.employeeRole = employee!["role"].toString();
              appController.employeeStartDate =
                  employee!["startDate"].toString();
              appController.employeeEndDate = employee!["endDate"].toString();
              appController.update();
              Get.to(() => const AddEmployeePage(),
                  transition: Transition.cupertino);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.transparent,
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee!["empName"].toString(),
                      style: robotoNormal.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    height5,
                    Text(
                      employee!["role"].toString(),
                      style: robotoNormal.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: employeeDetailsColor),
                    ),
                    height5,
                    Text(
                      "From ${employee!["startDate"].toString()}  ${employee!["endDate"].toString() == 'No date' ? "" : "- ${employee!["endDate"]}"}",
                      style: robotoNormal.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: employeeDetailsColor),
                    ),
                    height5,
                  ],
                ),
              ),
            ),
          ),
        ),
        Divider(color: employeeDetailsColor.withOpacity(0.1), thickness: 1),
      ],
    );
  }

  void showSnackBar(context) {
    HapticFeedback.heavyImpact();

    final snackBar = SnackBar(
      content: const Text('Employee data has been deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          appController.deletePreviousEmployee(employee?["empName"]);

          appController.insertDatabase(
            employee!["empName"].toString(),
            employee!["role"].toString(),
            employee!["startDate"].toString(),
            employee!["endDate"].toString(),
          );
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class PreviousEmployeeTile extends StatelessWidget {
  PreviousEmployeeTile({Key? key, this.employee, required this.index})
      : super(key: key);
  final appController = Get.put(AppMainController());

  final Map<String, dynamic>? employee;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Colors.transparent,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee!["empName"].toString(),
                  style: robotoNormal.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black),
                ),
                height5,
                Text(
                  employee!["role"].toString(),
                  style: robotoNormal.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: employeeDetailsColor),
                ),
                height5,
                Text(
                  "${employee!["startDate"].toString()} - ${employee!["endDate"].toString() == 'No date' ? "" : employee!["endDate"].toString()} ",
                  style: robotoNormal.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: employeeDetailsColor),
                ),
                height5,
              ],
            ),
          ),
        ),
        Divider(color: employeeDetailsColor.withOpacity(0.1), thickness: 1),
      ],
    );
  }

  void showSnackBar(context) {
    final snackBar = SnackBar(
      content: const Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
