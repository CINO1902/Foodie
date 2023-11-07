import '../models/fetchcartmodel.dart';

abstract class OrderDatasource {
  Future<List<Map<String, dynamic>>> getOrder(page, FetchcartModel fetchmodel);
}
