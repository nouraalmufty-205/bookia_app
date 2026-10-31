part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

// Get Cart
final class GetCartLoading extends CartState {}

final class GetCartError extends CartState {}

final class GetCartSuccess extends CartState {
  final CartModel cart;
  GetCartSuccess(this.cart);
}

// Update Cart
final class UpdateCartLoading extends CartState {}

final class UpdateCartError extends CartState {}

// Remove From Cart
final class RemoveFromCartLoading extends CartState {}

final class RemoveFromCartSuccess extends CartState {}

final class RemoveFromCartError extends CartState {}

