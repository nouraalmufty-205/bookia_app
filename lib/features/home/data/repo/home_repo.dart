import 'package:bookia/features/home/data/models/book_model.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  static Dio dio = Dio();
  static getBestSeller() async {
    try {
      final response = await dio.get(
        "https://codingarabic.eraapro.com/api/products-bestseller",
      );
      if (response.statusCode == 200) {
        BooksModel books = BooksModel.fromJson(response.data);
        return books;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
