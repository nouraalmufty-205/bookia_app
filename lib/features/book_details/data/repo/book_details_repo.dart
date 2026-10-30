import 'package:bookia/core/networking/api_endpoints.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/features/book_details/data/models/book_details_model.dart';

class BookDetailsRepo {
  static Future<BookDetailsModel?> getBookDetails(int id) async {
    try {
      final response = await DioFactory.dio?.get(
        "${ApiEndpoints.bookdetails}$id",
      );
      if (response?.statusCode == 200 && response?.data != null) {
        final bookDetailsResponse = BookDetailsResponse.fromJson(
          response!.data,
        );
        return bookDetailsResponse.data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
