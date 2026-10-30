import 'package:bookia/core/networking/api_endpoints.dart';
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

  static Future<List<Products>?> Search(String text) async {
    try {
      final response = await DioFactory.dio?.get(
        ApiEndpoints.search,
        queryParameters: {"name": text},
      );
      if (response?.statusCode == 200) {
        BooksModel books = BooksModel.fromJson(response?.data);
        return books.data?.products;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
