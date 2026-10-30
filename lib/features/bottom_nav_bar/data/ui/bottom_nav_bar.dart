import 'package:bookia/core/theme/appcolors.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/ui/home_screen.dart';
import 'package:bookia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    BlocProvider(
      create: (context) => HomeCubit()..GetBestSellerBooks(),
      child: HomeScreen(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[0],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        backgroundColor: AppColors.primary,
        selectedItemColor: AppColors.mainColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.home,
              colorFilter: ColorFilter.mode(
                currentIndex == 0 ? AppColors.mainColor : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.bookmark,
              colorFilter: ColorFilter.mode(
                currentIndex == 1 ? AppColors.mainColor : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.cart,
              colorFilter: ColorFilter.mode(
                currentIndex == 2 ? AppColors.mainColor : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.profile,
              colorFilter: ColorFilter.mode(
                currentIndex == 3 ? AppColors.mainColor : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
