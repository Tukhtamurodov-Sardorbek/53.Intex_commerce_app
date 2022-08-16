import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intex_commerce/core/app_utils/app_spaces.dart';
import 'package:intex_commerce/core/app_utils/app_text_styles.dart';


class CheckIconsWidget extends StatelessWidget {
  final String aboutPoolsText;

  const CheckIconsWidget({
    Key? key,
    required this.aboutPoolsText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/png/icons/ic_check.png",
          height: 13.h,
          width: 13.w,
        ),
        AppSpaces.spaceHorizontal8,
        Text(
          aboutPoolsText,
          style: AppTextStyles.size13weight400Black,
        ),
      ],
    );
  }
}


