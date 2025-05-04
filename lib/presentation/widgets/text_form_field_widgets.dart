// import 'package:flutter/material.dart';
// import 'package:task01/presentation/theme/index_theme.dart';

// class TextFormField extends StatefulWidget {
//   TextFormField({
//     this.hintText,
//     this.hintTextStyle,
//     this.controller,
//     this.padding,
//     this.multiline = false,
//     this.minimumLines = 1,
//     this.isPasswordField = false,
//     this.isCalenderField = false,
//     this.background = AppColors.accent,
//   });

//   final String hintText;
//   final TextStyle hintTextStyle;
//   final TextEditingController controller;
//   final bool multiline;
//   final int minimumLines;
//   final bool isPasswordField;
//   final bool isCalenderField;
//   final Color background;
//   final double padding;

//   @override
//   State<TextFormField> createState() => _TextFormFieldState();
// }

// class _TextFormFieldState extends State<TextFormField> {
//   bool isVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: widget.background,
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: widget.padding ?? ListifySize.width(26),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Flexible(
//               child: TextFormField(
//                 onTap: () {
//                   if (widget.isCalenderField) {
//                     // DatePicker.showDateTimePicker(
//                     //   context,
//                     //   showTitleActions: true,
//                     //   minTime: DateTime(1900),
//                     //   maxTime: DateTime(2100),
//                     //   onConfirm: (date) {
//                     //     widget.controller.text = DateFormat('hh:mm aa MMM dd, yyyy').format(date);
//                     //   },
//                     //   currentTime: DateTime.now(),
//                     //   locale: LocaleType.en,
//                     // );
//                   }
//                 },
//                 maxLines: widget.multiline ? null : 1,
//                 minLines: widget.multiline ? widget.minimumLines : 1,
//                 obscureText: widget.isPasswordField ? !isVisible : false,
//                 controller: widget.controller,
//                 decoration: InputDecoration(
//                   hintText: widget.hintText,
//                   hintStyle: widget.hintTextStyle ??
//                       ListifyTextStyle.bodyText1().copyWith(
//                         color: ListifyColors.charcoal,
//                       ),
//                   border: InputBorder.none,
//                   suffixIcon: widget.isPasswordField
//                       ? GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isVisible = !isVisible;
//                             });
//                           },
//                           child: Image.asset(
//                             isVisible ? ListifyAssets.visibilityOn : ListifyAssets.visibilityOff,
//                           ),
//                         )
//                       : null,
//                   suffixIconConstraints: BoxConstraints(
//                     maxHeight: ListifySize.height(25),
//                     minWidth: ListifySize.width(25),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
