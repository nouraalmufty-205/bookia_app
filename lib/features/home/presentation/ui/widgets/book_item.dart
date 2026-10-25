import 'package:bookia/core/theme/app_textstyles.dart';
import 'package:bookia/core/theme/appcolors.dart';
import 'package:bookia/features/home/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookItem extends StatelessWidget {
  final Products? product;
  const BookItem({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 163.w,
      height: 281.h,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              product?.image ?? "",
              width: 140.89.w,
              height: 175.37.h,
              fit: BoxFit.cover,
            ),
          ),
          10.verticalSpace,
          Text(
            product?.name ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextstyles.font16Regular.copyWith(fontSize: 18.sp),
          ),
          4.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Text(
                  product?.price ?? "",
                  style: AppTextstyles.font16Regular,
                ),
              ),
              30.horizontalSpace,
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.shopping_cart),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
