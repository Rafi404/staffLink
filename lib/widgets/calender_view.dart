import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../app_constants/app_constants.dart';
import '../controller/app_controller.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({
    Key? key,
  }) : super(key: key);
  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  final appController = Get.put(AppMainController());

  final DateTime selectedDate = DateTime.now();
  final DateTime selectedEndDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppMainController>(builder: (logic) {
      return TableCalendar(
        weekNumbersVisible: false,
        availableCalendarFormats: const {CalendarFormat.month: 'Month'},
        headerStyle: const HeaderStyle(titleCentered: true),
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        selectedDayPredicate: (day) => isSameDay(
            appController.calenderType == 'startDate'
                ? appController.selectedDate
                : appController.selectedEndDate,
            day),
        calendarBuilders: CalendarBuilders(
          // Customize the appearance of each day cell
          selectedBuilder: (context, date, events) {
            return Container(
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(300))),
              alignment: Alignment.center,
              child: Text(
                date.day.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
          todayBuilder: (context, date, events) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: primaryColor, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(300))),
              alignment: Alignment.center,
              child: Text(
                date.day.toString(),
                style: const TextStyle(color: Colors.black),
              ),
            );
          },
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            if (appController.calenderType == 'startDate') {
              appController.selectedDate = selectedDay;
              appController.update();
            } else {
              appController.selectedEndDate = selectedDay;
              appController.update();
            }
          });
        },
      );
    });
  }
}
