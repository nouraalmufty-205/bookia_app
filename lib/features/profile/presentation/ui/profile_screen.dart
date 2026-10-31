import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ProfileAppBar(),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is GetProfileLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GetProfileSuccess) {
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: Image.network(
                        state.profiledata?.image ?? "",
                      ).image,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.profiledata?.name ?? ""),
                        Text(state.profiledata?.email ?? ""),
                      ],
                    ),
                  ],
                );
              } else {
                return Center(child: Text("ERROR"));
              }
            },
          ),
        ],
      ),
    );
  }
}
