import 'package:flutter/material.dart';

/// Custom scrollable time picker widget with wheel interface
class CustomTimePicker extends StatelessWidget {
  final int itemCount; // Total number of items
  final int initialItem; // Initially selected item index
  final double itemExtent; // Height of each item
  final Function(int) onChanged; // Callback when selection changes
  final Widget Function(int) itemBuilder; // Builder for each item

  const CustomTimePicker({
    required this.itemCount,
    required this.initialItem,
    required this.itemExtent,
    required this.onChanged,
    required this.itemBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = FixedExtentScrollController(initialItem: initialItem);

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          final index = scrollController.selectedItem;
          onChanged(index);
        }
        return false;
      },
      child: ListWheelScrollView(
        controller: scrollController,
        itemExtent: itemExtent,
        diameterRatio: 1.5,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onChanged,
        children: List.generate(itemCount, (index) => itemBuilder(index)),
      ),
    );
  }
}
