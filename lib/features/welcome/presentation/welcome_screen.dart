import 'package:bookia/core/routes/app_router.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/theme/app_textstyles.dart';
import 'package:bookia/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset('assets/images/bg.png').image,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.language, size: 12),
                  onPressed: () {
                    if (context.locale.languageCode == 'en') {
                      context.setLocale(Locale('ar'));
                    } else {
                      context.setLocale(Locale('en'));
                    }
                  },
                ),
              ],
            ),

            135.verticalSpace,
            Image.asset('assets/images/logo 2.png'),
            28.verticalSpace,
            Text(
              "order_your_book_now".tr(),
              style: AppTextstyles.font30Regular.copyWith(fontSize: 20.sp),
            ),
            Spacer(),
            AppButton(
              title: "login".tr(),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.LoginScreen);
              },
            ),
            15.verticalSpace,
            AppButton(
              title: "register".tr(),
              bgColor: Colors.white,
              textColor: Colors.black,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.RegisterScreen);
              },
            ),
            94.verticalSpace,
          ],
        ),
      ),
    );
  }
}
