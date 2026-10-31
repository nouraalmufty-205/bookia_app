import 'package:bookia/core/theme/app_textstyles.dart';
import 'package:bookia/core/theme/appcolors.dart';
import 'package:bookia/core/widgets/app_button.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is RemoveFromCartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to remove item. Please try again.'),
              backgroundColor: Colors.redAccent,
            ),
          );
        } else if (state is UpdateCartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to update quantity. Please try again.'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // App bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Text(
                'My Cart',
                textAlign: TextAlign.center,
                style: AppTextstyles.font30Regular.copyWith(fontSize: 24.sp),
              ),
            ),
            // Content
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                buildWhen: (previous, current) =>
                    current is GetCartLoading ||
                    current is GetCartSuccess ||
                    current is GetCartError ||
                    current is RemoveFromCartLoading ||
                    current is UpdateCartLoading,
                builder: (context, state) {
                  if (state is GetCartLoading ||
                      state is RemoveFromCartLoading ||
                      state is UpdateCartLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    );
                  } else if (state is GetCartSuccess) {
                    final cart = state.cart;
                    final items = cart.cartItems ?? [];

                    if (items.isEmpty) {
                      return _EmptyCartWidget();
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            itemCount: items.length,
                            itemBuilder: (context, index) =>
                                CartItemWidget(item: items[index]),
                          ),
                        ),
                        // Order summary + checkout
                        Container(
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.r),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 12,
                                offset: const Offset(0, -4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total (${items.length} item${items.length > 1 ? 's' : ''})',
                                    style: AppTextstyles.font16Regular.copyWith(
                                      color: AppColors.grayColor,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    '\$${cart.total ?? '0.00'}',
                                    style: AppTextstyles.font16Regular.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.sp,
                                      color: AppColors.darkColor,
                                    ),
                                  ),
                                ],
                              ),
                              14.verticalSpace,
                              AppButton(
                                title: 'Proceed to Checkout',
                                onTap: () {
                                  // TODO: navigate to checkout
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (state is GetCartError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            size: 64,
                            color: AppColors.grayColor,
                          ),
                          16.verticalSpace,
                          Text(
                            'Something went wrong.\nPlease try again.',
                            textAlign: TextAlign.center,
                            style: AppTextstyles.font16Regular.copyWith(
                              color: AppColors.grayColor,
                            ),
                          ),
                          20.verticalSpace,
                          SizedBox(
                            width: 160.w,
                            child: AppButton(
                              title: 'Retry',
                              onTap: () =>
                                  context.read<CartCubit>().getCart(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 96,
            color: AppColors.borderColor,
          ),
          20.verticalSpace,
          Text(
            'Your cart is empty',
            style: AppTextstyles.font30Regular.copyWith(fontSize: 22.sp),
          ),
          10.verticalSpace,
          Text(
            'Add books to your cart\nto get started.',
            textAlign: TextAlign.center,
            style: AppTextstyles.font16Regular.copyWith(
              color: AppColors.grayColor,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
