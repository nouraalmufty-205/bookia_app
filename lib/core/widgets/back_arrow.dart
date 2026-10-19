import 'package:bookia/core/theme/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41.h,
      width: 41.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),

      child: Center(
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 19,
            color: AppColors.darkColor,
          ),
        ),
      ),
    );
  }
}
