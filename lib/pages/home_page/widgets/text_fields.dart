import 'package:flutter/material.dart';
import 'package:intex_commerce/core/app_utils/app_colors.dart';
import 'package:intex_commerce/core/app_utils/app_text_styles.dart';
import 'package:intex_commerce/core/app_utils/box_shadow.dart';
import 'package:get/get.dart';

/// Text field for String type
class TextFieldString extends StatelessWidget {
  final bool next;
  final String hint;
  final double height;
  final bool displayShadow;
  final bool isConsultDialog;
  final TextEditingController textController;
  const TextFieldString({
    Key? key,
    required this.hint,
    required this.next,
    required this.height,
    required this.displayShadow,
    required this.isConsultDialog,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        boxShadow: displayShadow
            ? isConsultDialog ? [appBoxShadowMap()] : [appBoxShadowTextField()]
            : null,
      ),

      child: TextField(
        onChanged: (String value) {},
        controller: textController,
        cursorColor: AppColors.main,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: next ? TextInputAction.next : TextInputAction.done,
        maxLines: 1,

        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.textFieldFillColor,
          contentPadding: const EdgeInsets.all(12.0),

          hintText: hint,
          hintStyle: hint == "name".tr ?AppTextStyles.size15Weight700 : AppTextStyles.size20weight700Grey,

          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.main),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.transparent),
          ),
        ),
      ),
    );
  }
}

/// Text field for phone number
class PhoneTextField extends StatelessWidget {
  final bool next;
  final double height;
  final bool isConsultDialog;
  final bool displayShadow;
  final String hintText;
  final TextEditingController phoneController;
  const PhoneTextField({
    Key? key,
    required this.height,
    required this.next,
    required this.isConsultDialog,
    required this.displayShadow,
    required this.phoneController, required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          boxShadow: displayShadow
              ? isConsultDialog ? [appBoxShadowMap()] : [appBoxShadowTextField()]
              : null,
      ),

      child: TextField(
        controller: phoneController,
        cursorColor: AppColors.main,
        keyboardType: TextInputType.phone,
        textInputAction: next ? TextInputAction.next : TextInputAction.done,
        maxLines: 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.textFieldFillColor,
          hintText: hintText,
          hintStyle: hintText == "number".tr ? AppTextStyles.size15Weight700 : AppTextStyles.size20weight700Grey,
          contentPadding: const EdgeInsets.all(12.0),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.main),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.transparent),
          ),
        ),
      ),
    );
  }
}

/// Text field for Consulting
// class FooterTextField extends StatelessWidget {
//   final TextEditingController textController;
//   final String hint;
//   final bool next;
//
//   const FooterTextField({
//     Key? key,
//     required this.next,
//     required this.hint,
//     required this.textController,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 37.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: AppBorders.circular10,
//       ),
//       child: TextField(
//         controller: textController,
//         cursorColor: AppColors.main,
//         textCapitalization: TextCapitalization.sentences,
//         textInputAction: next ? TextInputAction.next : TextInputAction.done,
//         maxLines: 1,
//
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: AppColors.textFieldFillColor,
//           contentPadding: const EdgeInsets.all(12.0),
//
//           hintText: hint,
//           // hintStyle: AppTextStyles.size20weight400Grey,
//
//           border: InputBorder.none,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//             borderSide: const BorderSide(color: AppColors.transparent),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//             borderSide: const BorderSide(color: AppColors.main),
//           ),
//           disabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//             borderSide: const BorderSide(color: AppColors.transparent),
//           ),
//         ),
//       ),
//     );
//   }
// }