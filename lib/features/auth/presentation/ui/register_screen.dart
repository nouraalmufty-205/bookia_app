import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/theme/app_textstyles.dart';
import 'package:bookia/core/theme/appcolors.dart';
import 'package:bookia/core/widgets/back_arrow.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/features/auth/presentation/ui/widgets/register_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackArrow(),
              28.verticalSpace,
              Text(
                "Hello! Register to get\nstarted",
                style: AppTextstyles.font30Regular,
              ),
              32.verticalSpace,
              RegisterForm(),
              184.verticalSpace,

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    "Already have an account?",
                    style: AppTextstyles.font16Regular.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  4.horizontalSpace,
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.LoginScreen);
                    },
                    child: Text(
                      "Login Now",
                      style: TextStyle(color: AppColors.mainColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
