import 'package:bloc/bloc.dart';
import 'package:bookia/features/profile/data/model/profile_data_model.dart';
import 'package:bookia/features/profile/data/model/repo/profile_repo.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  GetProfileData() async {
    emit(GetProfileLoading());
    final response = await ProfileRepo.getProfileData();
    if (response is ProfileDataModel) {
      emit(GetProfileSuccess(response));
    } else {
      emit(GetProfileError());
    }
  }
}
