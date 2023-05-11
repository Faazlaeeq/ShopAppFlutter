import 'package:shop_app/provider/cart.dart';

class OrderItem {
  String id;
  String dataTime;
  double price;
  List<CartItem> products;

  OrderItem(
      {required this.id,
      required this.dataTime,
      required this.price,
      required this.products});
}
