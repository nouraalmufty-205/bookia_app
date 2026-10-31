import 'package:bookia/core/networking/api_endpoints.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/features/cart/data/model/cart_model.dart';

class CartRepo {
  static Future<CartModel?> getCart() async {
    try {
      final response = await DioFactory.dio?.get(ApiEndpoints.cart);
      if (response?.statusCode == 200) {
        return CartResponseModel.fromJson(response?.data).data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> updateCart({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoints.updateCart,
        data: {'cart_item_id': cartItemId, 'quantity': quantity},
      );
      return response?.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> removeFromCart({required int cartItemId}) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoints.removeFromCart,
        data: {'cart_item_id': cartItemId},
      );
      return response?.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

