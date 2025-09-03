abstract class PurchaseEvents {}

class LoadPurchaseEvent extends PurchaseEvents {
  final String userId;
  LoadPurchaseEvent({required this.userId});
}
