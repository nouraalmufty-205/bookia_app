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

class BookDetailsScreen extends StatelessWidget {
  final int? bookId;
  const BookDetailsScreen({super.key, this.bookId});

  static final BookDetailsModel dummyBook = BookDetailsModel(
    id: 0,
    name: "Mathematics for Machine Learning",
    description:
        "The fundamental mathematical tools needed to understand machine learning include linear algebra, analytic geometry, matrix decompositions, vector calculus, optimization, probability, and statistics. This textbook bridges the gap between mathematical theory and machine learning applications.",
    price: "350.00",
    stock: 25,
    discount: 0,
    priceAfterDiscount: 0.0,
    image: "",
    category: "Computer Science",
    special: "",
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
              return _buildErrorView(context);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<BookdetailsCubit, BookdetailsState>(
        builder: (context, state) {
          if (state is GetDetailsSuccess) {
            final book = state.details;
            final double price = double.tryParse(book.price) ?? 0.0;

            return BookDetailsBottomBar(
              price: price,
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
                  // Book Cover with Hero (Clean, without any offer badges)
                  Center(
                    child: Container(
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
                                      (context, error, stackTrace) => Container(
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
                                          style: AppTextstyles.hintTextStyle
                                              .copyWith(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ),
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

                  // Quick Stats Row (Rating, Category, Stock)
                  BookDetailsStats(
                    category: book.category,
                    stock: book.stock,
                  ),
                  24.verticalSpace,

                  // Description Section
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
                              "Description",
                              style: AppTextstyles.font16Regular.copyWith(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        12.verticalSpace,
                        Text(
                          _getEffectiveDescription(book),
                          style: AppTextstyles.font16Regular.copyWith(
                            fontSize: 14.sp,
                            height: 1.6,
                            color: AppColors.darkGrayColor,
                          ),
                        ),
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

  String _getEffectiveDescription(BookDetailsModel book) {
    String text = book.description;

    // 1. Remove HTML tags and unescape common HTML entities
    text = text
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</p>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'</div>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&apos;', "'")
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&#39;', "'")
        .trim();

    // 2. Clean multiple newlines
    text = text.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    final String lowerName = book.name.toLowerCase().trim();
    final String lowerText = text.toLowerCase().trim();

    // 3. If description is empty or just the title repeated, provide actual book description
    if (lowerText.isEmpty || lowerText == lowerName || lowerText.length < 40) {
      if (lowerName.contains('mathematics for machine learning')) {
        return "The fundamental mathematical tools needed to understand machine learning include linear algebra, analytic geometry, matrix decompositions, vector calculus, optimization, probability, and statistics.\n\nThis self-contained textbook bridges the gap between mathematical and machine learning texts, introducing mathematical concepts with a minimum of prerequisites and deriving four central machine learning methods: linear regression, principal component analysis, Gaussian mixture models, and support vector machines.";
      } else if (lowerName.contains('clean code')) {
        return "Even bad code can function. But if code isn't clean, it can bring a development organization to its knees. Every year, countless hours and significant resources are lost because of poorly written code. This book is a must-read for any developer, software engineer, project manager, or systems analyst interested in producing better, cleaner code.";
      } else if (lowerName.contains('design pattern')) {
        return "Capturing a wealth of experience about the design of object-oriented software, this book presents a catalog of simple and succinct solutions to commonly occurring design problems. These 23 patterns allow designers to create more flexible, elegant, and ultimately reusable software systems.";
      } else if (lowerName.contains('flutter') || lowerName.contains('dart')) {
        return "An essential and comprehensive guide exploring the fundamentals and advanced concepts of building high-performance, beautiful, natively compiled, multi-platform applications from a single codebase.";
      } else {
        return "An insightful and comprehensive book covering core concepts and practical techniques in ${book.name}${book.category.isNotEmpty ? ' (${book.category})' : ''}. Designed to provide readers with deep understanding, step-by-step guidance, and real-world applications.";
      }
    }

    return text;
  }

  Widget _buildErrorView(BuildContext context) {
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
                    decoration: const BoxDecoration(
                      color: Color(0xFFFEF2F2),
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
                      if (bookId != null) {
                        context.read<BookdetailsCubit>().getDetails(bookId!);
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
