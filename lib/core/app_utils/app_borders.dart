import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBorders {
  static final circular8 = BorderRadius.circular(4.r);
  static final circular10 = BorderRadius.circular(10.r);
  static final circular17 = BorderRadius.circular(17.r);
  static final circular35 = BorderRadius.circular(35.r);
  static final circularTrBlBr35 = BorderRadius.only(
    topRight: Radius.circular(35.r),
    bottomLeft: Radius.circular(35.r),
    bottomRight: Radius.circular(35.r),
  );
  static final circularTrBlBr10 = BorderRadius.only(
    topRight: Radius.circular(10.r),
    bottomLeft: Radius.circular(10.r),
    bottomRight: Radius.circular(10.r),
  );
  static final circularBlTr10 = BorderRadius.only(
    bottomLeft: Radius.circular(10.r),
    topRight: Radius.circular(10.r),
  );
  static final circularBr10 = BorderRadius.only(
    bottomRight: Radius.circular(10.r),
  );
}
