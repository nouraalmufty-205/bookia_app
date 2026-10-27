import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/features/home/data/models/book_model.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  static getBestSeller() async {
    try {
      final response = await DioFactory.dio?.get("products-bestseller");
      if (response?.statusCode == 200) {
        BooksModel books = BooksModel.fromJson(response?.data);
        return books;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
