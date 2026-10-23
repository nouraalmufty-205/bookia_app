import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/theme/app_textstyles.dart';
import 'package:bookia/core/theme/appcolors.dart';
import 'package:bookia/core/utils/app_validator.dart';
import 'package:bookia/core/widgets/app_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  var formState = GlobalKey<FormState>();
  var usernamecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  void dispose() {
    usernamecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is RegisterLoadingStatus) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              content: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
              ),
            ),
          );
        } else if (state is RegisterSuccessStatus) {
          Navigator.pushReplacementNamed(context, AppRoutes.HomeScreen);
        } else if (state is RegisterErrorStatus) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(content: Text("Registration failed ")),
          );
        }
      },
      child: Form(
        key: formState,
        child: Column(
          children: [
            CustomTextField(
              hintText: "Username",
              controller: usernamecontroller,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return "Username is required";
                }
              },
            ),
            11.verticalSpace,
            CustomTextField(
              hintText: "Email",
              controller: emailcontroller,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Enter Your Email";
                }
                if (!AppValidator.isValidEmail(v ?? "")) {
                  return "Email invalid";
                }
              },
            ),
            12.verticalSpace,
            CustomTextField(
              hintText: "Password",
              controller: passwordcontroller,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Enter Your Password";
                }
                if (v.length < 6) {
                  return "password must be 6 characterss";
                }
              },
            ),
            13.verticalSpace,
            CustomTextField(
              hintText: "Confirm Password",
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Enter to confirm Password";
                }
                if (v != passwordcontroller.text) {
                  return "Passwords doesn't match";
                }
              },
            ),
            30.verticalSpace,
            AppButton(
              title: "Register",
              onTap: () {
                if (formState.currentState?.validate() ?? false) {
                  context.read<AuthCubit>().register(
                    email: emailcontroller.text,
                    password: passwordcontroller.text,
                    username: usernamecontroller.text,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
