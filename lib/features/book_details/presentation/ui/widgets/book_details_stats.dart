import 'package:bookia/core/theme/app_textstyles.dart';
import 'package:bookia/core/theme/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetailsStats extends StatelessWidget {
  final String category;
  final int stock;
  final int discount;

  const BookDetailsStats({
    super.key,
    required this.category,
    required this.stock,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.star_rounded,
            iconColor: const Color(0xFFFFB800),
            iconBg: const Color(0xFFFFF8E7),
            title: "4.8",
            subtitle: "Rating",
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: _StatCard(
            icon: Icons.auto_stories_rounded,
            iconColor: AppColors.mainColor,
            iconBg: AppColors.mainColor.withValues(alpha: 0.1),
            title: category.isNotEmpty ? category : "General",
            subtitle: "Category",
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: _StatCard(
            icon: stock > 0
                ? Icons.inventory_2_rounded
                : Icons.inventory_rounded,
            iconColor: stock > 0
                ? const Color(0xFF22C55E)
                : const Color(0xFFEF4444),
            iconBg: stock > 0
                ? const Color(0xFFECFDF5)
                : const Color(0xFFFEF2F2),
            title: stock > 0 ? "$stock in stock" : "Out of stock",
            subtitle: "Status",
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(7.r),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 18.sp),
          ),
          8.verticalSpace,
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppTextstyles.font16Regular.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          2.verticalSpace,
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextstyles.hintTextStyle.copyWith(fontSize: 11.sp),
          ),
        ],
      ),
    );
  }
}
