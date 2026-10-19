part of 'auth_cubit_cubit.dart';

@immutable
sealed class AuthCubitState {}

final class AuthCubitInitial extends AuthCubitState {}

final class LoginLoadingStatus extends AuthCubitState {}

final class LoginSuccessState extends AuthCubitState {}

final class LoginErrorState extends AuthCubitState {}

final class RegisterLoadingStatus extends AuthCubitState {}

final class RegisterSuccessStatus extends AuthCubitState {}

final class RegisterErrorStatus extends AuthCubitState {}
