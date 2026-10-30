import 'package:bookia/core/theme/app_textstyles.dart';
import 'package:bookia/core/theme/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetailsBottomBar extends StatefulWidget {
  final double price;
  final int maxStock;
  final VoidCallback onAddToCart;

  const BookDetailsBottomBar({
    super.key,
    required this.price,
    required this.maxStock,
    required this.onAddToCart,
  });

  @override
  State<BookDetailsBottomBar> createState() => _BookDetailsBottomBarState();
}

class _BookDetailsBottomBarState extends State<BookDetailsBottomBar> {
  int quantity = 1;

  double get totalPrice => widget.price * quantity;

  @override
  Widget build(BuildContext context) {
    final effectiveMax = widget.maxStock > 0 ? widget.maxStock : 1;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Quantity Selector
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Row(
                    children: [
                      _QuantityButton(
                        icon: Icons.remove_rounded,
                        isEnabled: quantity > 1,
                        onTap: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Text(
                          "$quantity",
                          style: AppTextstyles.font16Regular.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _QuantityButton(
                        icon: Icons.add_rounded,
                        isEnabled: quantity < effectiveMax,
                        onTap: () {
                          if (quantity < effectiveMax) {
                            setState(() => quantity++);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                // Price Display (No offer / strikethrough)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Price",
                      style: AppTextstyles.hintTextStyle.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      "\$${totalPrice.toStringAsFixed(2)}",
                      style: AppTextstyles.font30Regular.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            14.verticalSpace,
            // Add to Cart Button
            InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: widget.maxStock > 0 ? widget.onAddToCart : null,
              child: Container(
                height: 52.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.maxStock > 0
                      ? AppColors.mainColor
                      : AppColors.grayColor,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: widget.maxStock > 0
                      ? [
                          BoxShadow(
                            color: AppColors.mainColor.withValues(alpha: 0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    10.horizontalSpace,
                    Text(
                      widget.maxStock > 0 ? "Add to Cart" : "Out of Stock",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final bool isEnabled;
  final VoidCallback onTap;

  const _QuantityButton({
    required this.icon,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: isEnabled ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Icon(
            icon,
            size: 16.sp,
            color: isEnabled ? AppColors.darkColor : AppColors.grayColor,
          ),
        ),
      ),
    );
  }
}
