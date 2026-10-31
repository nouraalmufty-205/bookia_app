import 'package:bloc/bloc.dart';
import 'package:bookia/features/cart/data/model/cart_model.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  CartModel? _cart;

  Future<void> getCart() async {
    emit(GetCartLoading());
    final response = await CartRepo.getCart();
    if (response != null) {
      _cart = response;
      emit(GetCartSuccess(response));
    } else {
      emit(GetCartError());
    }
  }

  Future<void> updateCartItemQuantity({
    required int cartItemId,
    required int quantity,
  }) async {
    // Optimistically update local state
    if (_cart?.cartItems != null) {
      final items = _cart!.cartItems!
          .map((item) {
            if (item.itemId == cartItemId) {
              item.itemQuantity = quantity;
            }
            return item;
          })
          .toList();
      emit(GetCartSuccess(_cart!));
    }

    emit(UpdateCartLoading());
    final success = await CartRepo.updateCart(
      cartItemId: cartItemId,
      quantity: quantity,
    );
    if (success) {
      await getCart();
    } else {
      emit(UpdateCartError());
      // Refresh cart to revert optimistic update
      await getCart();
    }
  }

  Future<void> removeFromCart({required int cartItemId}) async {
    emit(RemoveFromCartLoading());
    final success = await CartRepo.removeFromCart(cartItemId: cartItemId);
    if (success) {
      emit(RemoveFromCartSuccess());
      await getCart();
    } else {
      emit(RemoveFromCartError());
    }
  }
}

