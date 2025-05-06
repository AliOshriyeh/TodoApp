import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task01/presentation/theme/index_theme.dart';

/// Custom app bar widget with consistent styling and back button functionality
class TaskAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Title to display in the app bar

  const TaskAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leadingWidth: 120,
      leading: Transform.translate(
        offset: const Offset(-18, 0),
        child: TextButton(
          onPressed: () => Get.back(), // Navigation back action
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_back_ios_new, size: 30, color: AppColors.info),
              Text("Close", style: AppTextStyle.regular20.copyWith(color: AppColors.info)),
            ],
          ),
        ),
      ),
      title: Text(title, style: AppTextStyle.semiBold18),
      shape: const Border(bottom: BorderSide(color: AppColors.grey, width: 0.5)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
