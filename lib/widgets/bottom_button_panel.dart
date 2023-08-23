import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stafflink/widgets/primary_button.dart';

import '../app_constants/app_constants.dart';
import '../controller/app_controller.dart';

class BottomButtonPanel extends StatelessWidget {
  BottomButtonPanel({
    Key? key,
    required this.cancelAction,
    required this.saveAction,
    required this.dateLabelStatus,
  }) : super(key: key);
  final void Function() cancelAction;
  final void Function() saveAction;
  final bool dateLabelStatus;
  final appController = Get.put(AppMainController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          border:
              Border(top: BorderSide(color: bottomBarBorderColor, width: 2))),
      child: Row(
        children: [
          dateLabelStatus
              ? Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.event,
                        size: 22,
                        color: primaryColor,
                      ),
                      width5,
                      appController.noDateSelected
                          ? Text(
                              'No date',
                              style: robotoNormal.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )
                          : Text(
                              appController.calenderType == 'endDate'
                                  ? DateFormat("d MMM yyyy").format(
                                      DateTime.parse(appController
                                          .selectedEndDate
                                          .toString()))
                                  : DateFormat("d MMM yyyy").format(
                                      DateTime.parse(appController.selectedDate
                                          .toString())),
                              style: robotoNormal.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )
                    ],
                  ),
                )
              : const SizedBox(
                  width: 100,
                ),
          const SizedBox(
            width: 60,
          ),
          Expanded(
            flex: 2,
            child: SecondaryButton(
              buttonAction: cancelAction,
              child: Text(
                'Cancel',
                style: primaryButtonTextStyle.copyWith(color: primaryColor),
              ),
            ),
          ),
          width10,
          Expanded(
            flex: 2,
            child: PrimaryButton(
              buttonAction: saveAction,
              child: Text(
                'Save',
                style: primaryButtonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
