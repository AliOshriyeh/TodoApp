import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<AddTaskController>();
    return Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Row(
          children: [
            // Day Picker
            Obx(
              () => CupertinoPicker(
                  // scrollController: FixedExtentScrollController(
                  //   initialItem: controller.selectedDate.value.day - 1,
                  // ),
                  itemExtent: 40,
                  onSelectedItemChanged: (index) {
                    // controller.selectedDate.value = DateTime(
                    //   controller.selectedDate.value.year,
                    //   controller.selectedDate.value.month,
                    //   index + 1,
                    // );
                  },
                  children: []

                  // controller.daysInMonth.map((day) => Center(child: Text(day.toString().padLeft(2, '0')))).toList(),
                  ),
            ),

            // // Month Picker
            // Expanded(
            //   child: CupertinoPicker(
            //     scrollController: FixedExtentScrollController(
            //       initialItem: controller.selectedDate.value.month - 1,
            //     ),
            //     itemExtent: 40,
            //     onSelectedItemChanged: (index) {
            //       // controller.selectedDate.value = DateTime(
            //       //   controller.selectedDate.value.year,
            //       //   index + 1,
            //       //   min(controller.selectedDate.value.day, DateTime(controller.selectedDate.value.year, index + 2, 0).day),
            //       // );
            //     },
            //     children: controller.months.map((month) => Center(child: Text(month.toString().padLeft(2, '0')))).toList(),
            //   ),
            // ),

            // // Year Picker
            // Expanded(
            //   child: CupertinoPicker(
            //     scrollController: FixedExtentScrollController(
            //       initialItem: controller.years.indexOf(controller.selectedDate.value.year),
            //     ),
            //     itemExtent: 40,
            //     onSelectedItemChanged: (index) {
            //       controller.selectedDate.value = DateTime(
            //         controller.years[index],
            //         controller.selectedDate.value.month,
            //         min(controller.selectedDate.value.day, DateTime(controller.years[index], controller.selectedDate.value.month + 1, 0).day),
            //       );
            //     },
            //     children: controller.years.map((year) => Center(child: Text(year.toString()))).toList(),
            //   ),
            // ),
          ],
        ));
  }
}
