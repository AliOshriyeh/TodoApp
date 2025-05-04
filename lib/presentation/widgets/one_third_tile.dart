// import 'package:get/get.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter/material.dart';

// class OneThirdTile extends StatelessWidget {
//   final String label;
//   final String svgIcon;
//   final Color color;

//   final VoidCallback onPressed;

//   const OneThirdTile({super.key, required this.label, required this.svgIcon, required this.onPressed, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//           width: Get.width * 0.27,
//           height: Get.width * 0.27,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SvgPicture.string(svgIcon),
//               const SizedBox(height: 5),
//               Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
//             ],
//           )),
//     );
//   }
// }
