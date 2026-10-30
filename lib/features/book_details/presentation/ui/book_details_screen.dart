import 'package:bookia/core/theme/app_textstyles.dart';
import 'package:bookia/core/theme/appcolors.dart';
import 'package:bookia/features/book_details/data/models/book_details_model.dart';
import 'package:bookia/features/book_details/presentation/cubit/bookdetails_cubit.dart';
import 'package:bookia/features/book_details/presentation/ui/widgets/book_details_bottom_bar.dart';
import 'package:bookia/features/book_details/presentation/ui/widgets/book_details_header.dart';
import 'package:bookia/features/book_details/presentation/ui/widgets/book_details_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookDetailsScreen extends StatefulWidget {
  final int? bookId;
  const BookDetailsScreen({super.key, this.bookId});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  bool isDescriptionExpanded = false;

  final BookDetailsModel dummyBook = BookDetailsModel(
    id: 0,
    name: "A Song of Ice and Fire - Game of Thrones",
    description:
        "A captivating epic fantasy novel set in the fictional continents of Westeros and Essos, following the noble families vying for the Iron Throne amidst mythical threats and complex political intrigue.",
    price: "350.00",
    stock: 25,
    discount: 20,
    priceAfterDiscount: 280.00,
    image: "",
    category: "Fantasy & Adventure",
    special: "Special Edition",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: BlocBuilder<BookdetailsCubit, BookdetailsState>(
          builder: (context, state) {
            if (state is GetDetailsLoading) {
              return Skeletonizer(
                enabled: true,
                child: _buildDetailsContent(dummyBook, isSkeleton: true),
              );
            } else if (state is GetDetailsSuccess) {
              return _buildDetailsContent(state.details, isSkeleton: false);
            } else if (state is GetDetailsError) {
              return _buildErrorView();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<BookdetailsCubit, BookdetailsState>(
        builder: (context, state) {
          if (state is GetDetailsSuccess) {
            final book = state.details;
            final double original = double.tryParse(book.price) ?? 0.0;
            final double unitPrice =
                (book.discount > 0 && book.priceAfterDiscount > 0)
                    ? book.priceAfterDiscount
                    : original;

            return BookDetailsBottomBar(
              unitPrice: unitPrice,
              originalPrice: book.discount > 0 ? original : null,
              maxStock: book.stock,
              onAddToCart: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: const Color(0xFF22C55E),
                          size: 22.sp,
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: Text(
                            "Added \"${book.name}\" to cart!",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDetailsContent(BookDetailsModel book, {required bool isSkeleton}) {
    final bool hasDiscount = book.discount > 0;
    final bool isSpecial =
        book.special.isNotEmpty && book.special != "Not Special";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          12.verticalSpace,
          BookDetailsHeader(bookTitle: book.name),
          16.verticalSpace,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Book Cover with Hero and Badges
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.16),
                                blurRadius: 24,
                                offset: const Offset(0, 12),
                                spreadRadius: -4,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: isSkeleton
                                ? Container(
                                    width: 180.w,
                                    height: 255.h,
                                    color: Colors.white,
                                  )
                                : Hero(
                                    tag: 'book_cover_${book.id}',
                                    child: Image.network(
                                      book.image,
                                      width: 180.w,
                                      height: 255.h,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        width: 180.w,
                                        height: 255.h,
                                        color: AppColors.borderColor,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.broken_image_rounded,
                                              size: 40.sp,
                                              color: AppColors.grayColor,
                                            ),
                                            8.verticalSpace,
                                            Text(
                                              "Cover unavailable",
                                              style: AppTextstyles
                                                  .hintTextStyle
                                                  .copyWith(fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        // Discount Badge
                        if (hasDiscount)
                          Positioned(
                            top: 10.h,
                            right: 10.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 9.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEF4444),
                                borderRadius: BorderRadius.circular(20.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFEF4444)
                                        .withValues(alpha: 0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                "-${book.discount}%",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        // Special Badge
                        if (isSpecial)
                          Positioned(
                            top: 10.h,
                            left: 10.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.auto_awesome_rounded,
                                    color: Colors.white,
                                    size: 12.sp,
                                  ),
                                  4.horizontalSpace,
                                  Text(
                                    "Special",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.sp,
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
                  20.verticalSpace,

                  // Book Title
                  Text(
                    book.name,
                    textAlign: TextAlign.center,
                    style: AppTextstyles.font30Regular.copyWith(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      height: 1.25,
                    ),
                  ),
                  10.verticalSpace,

                  // Category Pill
                  if (book.category.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: AppColors.mainColor.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Text(
                        book.category,
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  20.verticalSpace,

                  // Quick Stats Row
                  BookDetailsStats(
                    category: book.category,
                    stock: book.stock,
                    discount: book.discount,
                  ),
                  24.verticalSpace,

                  // Overview / Description Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 4.w,
                              height: 18.h,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            8.horizontalSpace,
                            Text(
                              "Overview",
                              style: AppTextstyles.font16Regular.copyWith(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        12.verticalSpace,
                        Text(
                          book.description.isNotEmpty
                              ? book.description
                              : "No description provided for this book.",
                          maxLines: isDescriptionExpanded ? null : 4,
                          overflow: isDescriptionExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: AppTextstyles.font16Regular.copyWith(
                            fontSize: 14.sp,
                            height: 1.6,
                            color: AppColors.darkGrayColor,
                          ),
                        ),
                        if (book.description.length > 160) ...[
                          8.verticalSpace,
                          InkWell(
                            onTap: () {
                              setState(() {
                                isDescriptionExpanded = !isDescriptionExpanded;
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  isDescriptionExpanded
                                      ? "Read Less"
                                      : "Read More",
                                  style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                4.horizontalSpace,
                                Icon(
                                  isDescriptionExpanded
                                      ? Icons.keyboard_arrow_up_rounded
                                      : Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.mainColor,
                                  size: 18.sp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  24.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          12.verticalSpace,
          const BookDetailsHeader(bookTitle: "Book Details"),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.error_outline_rounded,
                      size: 48.sp,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                  16.verticalSpace,
                  Text(
                    "Oops! Something went wrong",
                    style: AppTextstyles.font16Regular.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    "We couldn't fetch the book details right now.",
                    textAlign: TextAlign.center,
                    style: AppTextstyles.hintTextStyle.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  24.verticalSpace,
                  InkWell(
                    borderRadius: BorderRadius.circular(10.r),
                    onTap: () {
                      if (widget.bookId != null) {
                        context
                            .read<BookdetailsCubit>()
                            .getDetails(widget.bookId!);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 28.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        "Try Again",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
