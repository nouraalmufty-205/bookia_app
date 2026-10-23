import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/utils/app_validator.dart';
import 'package:bookia/core/widgets/app_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var formState = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is LoginLoadingStatus) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              content: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
              ),
            ),
          );
        } else if (state is LoginSuccessState) {
          Navigator.pushReplacementNamed(context, AppRoutes.HomeScreen);
        } else if (state is LoginErrorState) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(content: Text("Error ")),
          );
        }
      },
      child: Form(
        key: formState,
        child: Column(
          children: [
            CustomTextField(
              controller: emailcontroller,
              hintText: "Enter your email",
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Enter Your Email";
                }
                if (!AppValidator.isValidEmail(v ?? "")) {
                  return "Email invalid";
                }
              },
            ),
            16.verticalSpace,
            CustomTextField(
              controller: passwordcontroller,
              hintText: "Enter your password",
              isPassword: true,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Enter Your Password";
                }
                if (v.length < 6) {
                  return "password must be 6 characterss";
                }
              },
            ),
            30.verticalSpace,
            AppButton(
              title: "Login",
              onTap: () {
                if (formState.currentState?.validate() ?? false) {
                  context.read<AuthCubit>().login(
                    email: emailcontroller.text,
                    password: passwordcontroller.text,
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
