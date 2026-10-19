import 'package:bloc/bloc.dart';
import 'package:bookia/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitInitial());
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingStatus());
    final response = await AuthRepo.login(email: email, password: password);
    if (response) {
      emit(LoginSuccessState());
    } else {
      emit(LoginErrorState());
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingStatus());
    final response = await AuthRepo.register(
      username: username,
      email: email,
      password: password,
    );
    if (response) {
      emit(RegisterSuccessStatus());
    } else {
      emit(RegisterErrorStatus());
    }
  }
}
