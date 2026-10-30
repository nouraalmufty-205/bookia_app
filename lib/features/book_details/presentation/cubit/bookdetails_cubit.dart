import 'package:bloc/bloc.dart';
import 'package:bookia/features/book_details/data/models/book_details_model.dart';
import 'package:bookia/features/book_details/data/repo/book_details_repo.dart';
import 'package:meta/meta.dart';

part 'bookdetails_state.dart';

class BookdetailsCubit extends Cubit<BookdetailsState> {
  BookdetailsCubit() : super(BookdetailsInitial());

  getDetails(int id) async {
    emit(GetDetailsLoading());
    final data = await BookDetailsRepo.getBookDetails(id);
    if (data != null) {
      emit(GetDetailsSuccess(data));
    } else {
      emit(GetDetailsError());
    }
  }
}
