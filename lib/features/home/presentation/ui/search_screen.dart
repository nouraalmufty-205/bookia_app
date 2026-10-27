import 'package:bookia/core/widgets/back_arrow.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackArrow(),
              24.verticalSpace,
              CustomTextField(hintText: "Search", autofocus: true),
            ],
          ),
        ),
      ),
    );
  }
}
