import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliverAppBarBackground extends StatelessWidget {
  const SliverAppBarBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          'assets/png/local/main.png',
          height: 300.h,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
