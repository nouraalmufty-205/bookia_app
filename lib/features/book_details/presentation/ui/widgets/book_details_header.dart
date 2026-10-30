import 'package:bookia/core/theme/appcolors.dart';
import 'package:bookia/core/widgets/back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetailsHeader extends StatefulWidget {
  final String bookTitle;
  const BookDetailsHeader({super.key, required this.bookTitle});

  @override
  State<BookDetailsHeader> createState() => _BookDetailsHeaderState();
}

class _BookDetailsHeaderState extends State<BookDetailsHeader> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BackArrow(),
        InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            setState(() {
              isBookmarked = !isBookmarked;
            });
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(
                      isBookmarked
                          ? Icons.bookmark_added_rounded
                          : Icons.bookmark_remove_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    10.horizontalSpace,
                    Text(
                      isBookmarked
                          ? "Added to your wishlist"
                          : "Removed from your wishlist",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
                backgroundColor: AppColors.darkColor,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            );
          },
          child: Container(
            height: 41.h,
            width: 41.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
              border: Border.all(color: AppColors.borderColor, width: 1),
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  isBookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  key: ValueKey<bool>(isBookmarked),
                  size: 22.sp,
                  color: isBookmarked
                      ? AppColors.mainColor
                      : AppColors.darkColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
