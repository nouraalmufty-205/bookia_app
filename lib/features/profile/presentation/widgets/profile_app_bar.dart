import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/theme/app_textstyles.dart';
import 'package:bookia/core/utils/app_constants.dart';
import 'package:bookia/core/widgets/app_button.dart';
import 'package:bookia/services/local/local_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            "Profile",
            style: AppTextstyles.font30Regular.copyWith(fontSize: 24),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Do You Want to logout?"),
                    content: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              title: "Confirm",
                              bgColor: Colors.transparent,
                              textColor: Colors.black,
                              onTap: () async {
                                await LocalHelper.prfes?.remove(
                                  AppConstants.UserToken,
                                );
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.LoginScreen,
                                  (e) => false,
                                );
                              },
                            ),
                          ),
                          7.horizontalSpace,
                          Expanded(
                            child: AppButton(
                              title: "Cancel",
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
    );
  }
}
