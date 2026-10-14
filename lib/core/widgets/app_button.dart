import 'package:bookia/core/theme/app_textstyles.dart';
import 'package:bookia/core/theme/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Color? bgColor;
  final Color? textColor;
  final Function()? onTap;
  const AppButton({
    super.key,
    required this.title,
    this.bgColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.mainColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          title,
          style: AppTextstyles.font16Regular.copyWith(
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
