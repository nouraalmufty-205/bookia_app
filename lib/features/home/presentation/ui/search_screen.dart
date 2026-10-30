import 'package:bookia/core/widgets/back_arrow.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/features/home/data/models/book_model.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/ui/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
              11.verticalSpace,
              BackArrow(),
              24.verticalSpace,
              CustomTextField(
                hintText: "Search",
                autofocus: true,
                onChanged: (v) {
                  context.read<HomeCubit>().getSearch(v ?? "");
                },
              ),
              20.verticalSpace,
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Expanded(
                      child: Skeletonizer(
                        enabled: true,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 14.h,
                                crossAxisSpacing: 18.w,
                                childAspectRatio: .52,
                              ),
                          itemBuilder: (context, index) => BookItem(
                            product: Products(
                              name: "name",
                              price: "223",
                              image:
                                  "https://upload.wikimedia.org/wikipedia/commons/9/9e/Network_card.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=original",
                            ),
                          ),
                          itemCount: 8,
                        ),
                      ),
                    );
                  } else if (state is SearchSuccess) {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 14.h,
                          crossAxisSpacing: 18.w,
                          childAspectRatio: .52,
                        ),
                        itemBuilder: (context, index) =>
                            BookItem(product: state.products?[index]),
                        itemCount: state.products?.length,
                      ),
                    );
                  } else {
                    return Center(child: Text("Data is Empty"));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
