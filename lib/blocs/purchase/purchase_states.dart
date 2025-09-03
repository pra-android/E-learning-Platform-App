import '../../models/purchasemodel/purchase_model.dart';

abstract class PurchaseStates {}

class PurchaseLoading extends PurchaseStates {}

class PurchaseLoaded extends PurchaseStates {
  final List<Purchase> purchases;
  PurchaseLoaded(this.purchases);
}

class PurchaseError extends PurchaseStates {
  final String message;
  PurchaseError(this.message);
}
