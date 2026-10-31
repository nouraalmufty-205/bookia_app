import 'package:bookia/core/theme/app_textstyles.dart';
import 'package:bookia/core/theme/appcolors.dart';
import 'package:bookia/features/cart/data/model/cart_model.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book cover
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              item.itemProductImage ?? '',
              width: 80.w,
              height: 100.h,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 80.w,
                height: 100.h,
                color: AppColors.borderColor,
                child: const Icon(Icons.book, color: AppColors.grayColor),
              ),
            ),
          ),
          12.horizontalSpace,
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.itemProductName ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextstyles.font16Regular.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
                6.verticalSpace,
                // Price row
                Row(
                  children: [
                    if (item.itemProductDiscount != null &&
                        item.itemProductDiscount! > 0) ...[
                      Text(
                        '\$${item.itemProductPrice ?? ''}',
                        style: AppTextstyles.font16Regular.copyWith(
                          fontSize: 13.sp,
                          color: AppColors.grayColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      6.horizontalSpace,
                    ],
                    Text(
                      '\$${item.itemProductPriceAfterDiscount?.toStringAsFixed(2) ?? item.itemProductPrice ?? ''}',
                      style: AppTextstyles.font16Regular.copyWith(
                        fontSize: 15.sp,
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (item.itemProductDiscount != null &&
                        item.itemProductDiscount! > 0) ...[
                      6.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          '-${item.itemProductDiscount}%',
                          style: AppTextstyles.font16Regular.copyWith(
                            fontSize: 11.sp,
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                10.verticalSpace,
                // Quantity controls + delete
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Quantity stepper
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          _QuantityButton(
                            icon: Icons.remove,
                            onTap: item.itemQuantity > 1
                                ? () {
                                    context.read<CartCubit>().updateCartItemQuantity(
                                          cartItemId: item.itemId ?? 0,
                                          quantity: item.itemQuantity - 1,
                                        );
                                  }
                                : null,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              '${item.itemQuantity}',
                              style: AppTextstyles.font16Regular.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          _QuantityButton(
                            icon: Icons.add,
                            onTap: (item.itemProductStock == null ||
                                    item.itemQuantity <
                                        item.itemProductStock!)
                                ? () {
                                    context.read<CartCubit>().updateCartItemQuantity(
                                          cartItemId: item.itemId ?? 0,
                                          quantity: item.itemQuantity + 1,
                                        );
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ),
                    // Delete button
                    IconButton(
                      onPressed: () {
                        context.read<CartCubit>().removeFromCart(
                              cartItemId: item.itemId ?? 0,
                            );
                      },
                      icon: const Icon(Icons.delete_outline_rounded),
                      color: Colors.redAccent,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _QuantityButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.r),
      child: Padding(
        padding: EdgeInsets.all(6.r),
        child: Icon(
          icon,
          size: 18,
          color: onTap == null ? AppColors.grayColor : AppColors.darkColor,
        ),
      ),
    );
  }
}

