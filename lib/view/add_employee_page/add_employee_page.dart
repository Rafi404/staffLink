import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:stafflink/app_constants/app_constants.dart';
import 'package:stafflink/controller/app_controller.dart';
import 'package:stafflink/widgets/calender_view.dart';
import 'package:stafflink/widgets/primary_button.dart';
import 'package:stafflink/widgets/primary_field.dart';

import '../../helpers/validator.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/bottom_button_panel.dart';
import '../../widgets/bottom_modal_button.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final TextEditingController employeeName = TextEditingController();

  final TextEditingController role = TextEditingController();

  final TextEditingController today = TextEditingController();

  final TextEditingController noDate = TextEditingController();

  final appController = Get.put(AppMainController());

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    checkEditMode();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppMainController>(builder: (logic) {
      return Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: PrimaryAppBar(
              appBarText: appController.editMode
                  ? 'Edit Employee Details'
                  : 'Add Employee Details',
            )),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              height25,
              PrimaryField(
                hintText: 'Employee Name',
                fieldController: employeeName,
                fieldValidator: fieldValidator,
                fieldIcon: Icons.person_2_outlined,
                enabled: true,
              ),
              height25,
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  bottomModal(context);
                },
                child: SecondaryField(
                    hintText: 'Select Role',
                    fieldController: role,
                    enabled: false,
                    fieldValidator: fieldValidator),
              ),
              height25,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap: () {
                        appController.calenderType = 'startDate';
                        appController.update();
                        calenderDialogue(context);
                      },
                      child: PrimaryField(
                        hintText: 'Today',
                        fieldController: today,
                        fieldValidator: fieldValidator,
                        fieldIcon: Icons.event,
                        enabled: false,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.arrow_forward,
                      color: primaryColor,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();

                        appController.calenderType = 'endDate';
                        appController.endDateSelection = true;
                        appController.update();
                        calenderDialogue(context);
                      },
                      child: PrimaryField(
                        hintText: 'No Date',
                        fieldController: noDate,
                        fieldValidator: fieldValidator,
                        fieldIcon: Icons.event,
                        enabled: false,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              BottomButtonPanel(
                cancelAction: () {
                  appController.editMode = false;
                  appController.update();
                  employeeName.text = "";
                  role.text = "";
                  today.text = "";
                  noDate.text = "";
                },
                saveAction: () {
                  FocusManager.instance.primaryFocus?.unfocus();

                  if (employeeName.text == '' ||
                      role.text == '' ||
                      today.text == '' ||
                      noDate.text == '') {
                    HapticFeedback.lightImpact();
                    FlutterToastr.show(fieldRequiredMessage, context,
                        backgroundColor: Colors.redAccent,
                        duration: FlutterToastr.lengthLong,
                        position: FlutterToastr.bottom);
                  } else {
                    if (appController.editMode == true) {
                      appController.updateEmployee(
                          employeeName.text.toString(),
                          role.text.toString(),
                          today.text.toString(),
                          noDate.text.toString());
                      appController.editMode = false;
                      appController.update();
                    } else {
                      appController.insertDatabase(
                          employeeName.text.toString(),
                          role.text.toString(),
                          today.text.toString(),
                          noDate.text.toString());
                    }
                  }
                },
                dateLabelStatus: false,
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Role selection bottom modal ----------------------------------------------
  bottomModal(context) {
    return showBarModalBottomSheet<void>(
        topControl: const SizedBox(),
        isDismissible: true,
        enableDrag: true,
        elevation: 5,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomModalButton(
                  buttonAction: () {
                    role.text = 'Product Designer';
                    Get.close(1);
                  },
                  buttonText: 'Product Designer',
                ),
                BottomModalButton(
                  buttonAction: () {
                    role.text = 'Flutter Developer';
                    Get.close(1);
                  },
                  buttonText: 'Flutter Developer',
                ),
                BottomModalButton(
                  buttonAction: () {
                    role.text = 'QA Tester';
                    Get.close(1);
                  },
                  buttonText: 'QA Tester',
                ),
                BottomModalButton(
                  buttonAction: () {
                    role.text = 'Product Owner';
                    Get.close(1);
                  },
                  buttonText: 'Product Owner',
                ),
              ],
            ),
          );
        });
  }

  /// Dialogue box for calender ------------------------------------------------
  calenderDialogue(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) =>
            GetBuilder<AppMainController>(builder: (logic) {
              return Dialog(
                insetPadding: const EdgeInsets.all(20),
                elevation: 24.0,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            appController.endDateSelection
                                ? Row(
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: SelectionButton(
                                            buttonAction: () {
                                              appController.noDateButtonStatus =
                                                  true;
                                              appController.update();
                                              appController.selectButton(4);
                                            },
                                            buttonText: 'No date',
                                            buttonSelection:
                                                appController.noDateSelected,
                                          )),
                                      width10,
                                      Expanded(
                                        flex: 4,
                                        child: SelectionButton(
                                          buttonAction: () {
                                            appController.selectButton(0);
                                          },
                                          buttonText: 'Today',
                                          buttonSelection:
                                              appController.buttonTodaySelected,
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: SelectionButton(
                                                buttonAction: () {
                                                  appController.selectButton(0);
                                                },
                                                buttonText: 'Today',
                                                buttonSelection: appController
                                                    .buttonTodaySelected,
                                              )),
                                          width10,
                                          Expanded(
                                            flex: 4,
                                            child: SelectionButton(
                                              buttonAction: () {
                                                appController.selectButton(1);
                                              },
                                              buttonText: 'Next Monday',
                                              buttonSelection:
                                                  appController.mondaySelected,
                                            ),
                                          ),
                                        ],
                                      ),
                                      height15,
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: SelectionButton(
                                                buttonAction: () {
                                                  appController.selectButton(2);
                                                },
                                                buttonText: 'Next Tuesday',
                                                buttonSelection: appController
                                                    .tuesdaySelected,
                                              )),
                                          width10,
                                          Expanded(
                                            flex: 4,
                                            child: SelectionButton(
                                              buttonAction: () {
                                                appController.selectButton(3);
                                              },
                                              buttonText: 'After 1 week',
                                              buttonSelection:
                                                  appController.weekSelected,
                                            ),
                                          ),
                                        ],
                                      ),
                                      height10,
                                    ],
                                  ),

                            ///Calender view------------------------------------
                            const CalenderView(),
                            height30,
                          ],
                        ),
                      ),
                      BottomButtonPanel(
                        cancelAction: () {
                          appController.endDateSelection = false;
                          appController.update();
                          Get.close(1);
                          appController.selectButton(0);
                        },
                        saveAction: () {
                          if (appController.calenderType == 'startDate') {
                            String formattedDate = DateFormat('dd MMM yyyy')
                                .format(appController.selectedDate);
                            today.text = formattedDate.toString();
                          } else {
                            if (appController.noDateButtonStatus == true) {
                              noDate.text = 'No date';
                              appController.noDateButtonStatus = false;
                              appController.update();
                            } else {
                              String formattedDate = DateFormat('dd MMM yyyy')
                                  .format(appController.selectedEndDate);
                              noDate.text = formattedDate.toString();
                            }
                          }

                          appController.endDateSelection = false;
                          appController.update();
                          Get.close(1);

                          appController.selectButton(0);
                        },
                        dateLabelStatus: true,
                      ),
                    ],
                  ),
                ),
              );
            }),
        barrierDismissible: false);
  }

  void checkEditMode() {
    if (appController.editMode == true) {
      employeeName.text = appController.employeeName;
      role.text = appController.employeeRole;
      today.text = appController.employeeStartDate;
      noDate.text = appController.employeeEndDate;
    }
  }
}
