import 'package:bookia/core/theme/app_textstyles.dart';
import 'package:bookia/core/theme/appcolors.dart';
import 'package:bookia/core/widgets/back_arrow.dart';
import 'package:bookia/features/book_details/presentation/cubit/bookdetails_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              11.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackArrow(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border_rounded),
                  ),
                ],
              ),
              20.verticalSpace,
              Expanded(
                child: BlocBuilder<BookdetailsCubit, BookdetailsState>(
                  builder: (context, state) {
                    if (state is GetDetailsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetDetailsSuccess) {
                      final book = state.details;
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (book.image.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.network(
                                  book.image,
                                  height: 250.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    height: 250.h,
                                    width: 180.w,
                                    color: AppColors.borderColor,
                                    child: const Icon(Icons.broken_image),
                                  ),
                                ),
                              ),
                            16.verticalSpace,
                            Text(
                              book.name,
                              textAlign: TextAlign.center,
                              style: AppTextstyles.font30Regular.copyWith(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            8.verticalSpace,
                            if (book.category.isNotEmpty)
                              Text(
                                book.category,
                                style: AppTextstyles.hintTextStyle,
                              ),
                            8.verticalSpace,
                            Text(
                              "\$${book.price}",
                              style: AppTextstyles.font16Regular.copyWith(
                                fontSize: 18.sp,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            16.verticalSpace,
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                book.description,
                                style: AppTextstyles.font16Regular.copyWith(
                                  color: AppColors.darkGrayColor,
                                ),
                              ),
                            ),
                            24.verticalSpace,
                          ],
                        ),
                      );
                    } else if (state is GetDetailsError) {
                      return const Center(
                        child: Text("Failed to load book details"),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
