part of 'bookdetails_cubit.dart';

@immutable
sealed class BookdetailsState {}

final class BookdetailsInitial extends BookdetailsState {}

final class GetDetailsError extends BookdetailsState {}

final class GetDetailsLoading extends BookdetailsState {}

final class GetDetailsSuccess extends BookdetailsState {
  final BookDetailsModel details;
  GetDetailsSuccess(this.details);
}
