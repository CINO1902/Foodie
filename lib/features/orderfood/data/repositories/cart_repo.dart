import 'package:foodie/features/orders/data/models/fetchcartmodel.dart';

abstract class CartDatasource {
  Future<List<Map<String, dynamic>>> getCart(FetchcartModel fetchmodel);
  Future<List<Map<String, dynamic>>> sendlocation(location);
  Future<List<Map<String, dynamic>>> verifycoupon(code);
  Future<List<Map<String, dynamic>>> removecart(id);
  Future<List<Map<String, dynamic>>> removecartspecial(id);
}
