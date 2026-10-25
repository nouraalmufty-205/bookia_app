import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/ui/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is GetBestSellerLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is GetBestSellerSuccess) {
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
                    ),
                  );
                } else {
                  return Text("Error");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
