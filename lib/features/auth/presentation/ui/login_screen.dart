import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/theme/app_textstyles.dart';
import 'package:bookia/core/theme/appcolors.dart';
import 'package:bookia/core/widgets/back_arrow.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit_cubit.dart';
import 'package:bookia/features/auth/presentation/ui/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackArrow(),
                29.verticalSpace,
                Text(
                  "Welcome back! Glad to see you, Again!",
                  style: AppTextstyles.font30Regular,
                ),
                32.verticalSpace,
                LoginForm(),
                285.verticalSpace,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      "Don't have an account?",
                      style: AppTextstyles.font16Regular.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    4.horizontalSpace,
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.RegisterScreen);
                      },
                      child: Text(
                        "Register Now",
                        style: TextStyle(color: AppColors.mainColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
