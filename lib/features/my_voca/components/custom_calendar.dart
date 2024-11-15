import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatelessWidget {
  const CustomCalendar({
    super.key,
    required this.kFirstDay,
    required this.kLastDay,
  });

  final DateTime kFirstDay;
  final DateTime kLastDay;

  @override
  Widget build(BuildContext context) {
    MyVocaController controller = Get.find<MyVocaController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.width10 * 0.8),
      child: Material(
        elevation: 2,
        textStyle: TextStyle(
          color: AppColors.scaffoldBackground,
          fontSize: Responsive.height14,
        ),
        child: TableCalendar(
          rowHeight: Responsive.height10 * 5.2,
          daysOfWeekHeight: Responsive.height10 * 2.2,
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: controller.focusedDay,
          calendarFormat: controller.calendarFormat,
          eventLoader: controller.getEventsForDay,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          selectedDayPredicate: (day) {
            return controller.selectedDays.contains(day);
          },
          onDaySelected: controller.onDaySelected,
          onFormatChanged: controller.onFormatChanged,
          onPageChanged: (focusedDay) {
            controller.focusedDay = focusedDay;
          },
        ),
      ),
    );
  }
}
