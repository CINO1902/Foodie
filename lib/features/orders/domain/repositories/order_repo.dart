import 'dart:developer';

import 'package:foodie/features/orders/data/repositories/orderRepo.dart';

import '../../data/models/fetchcartmodel.dart';

abstract class OrderRepo {
  Future<List<Map<String, dynamic>>> getorder(page, FetchcartModel fetchmodel);
}

class OrderRepoImpl implements OrderRepo {
  final OrderDatasource orderDatasource;

  OrderRepoImpl(this.orderDatasource);

  @override
  Future<List<Map<String, dynamic>>> getorder(
      page, FetchcartModel fetchmodel) async {
    List<Map<String, dynamic>> returnvalue = [];
    try {
      returnvalue = await orderDatasource.getOrder(page, fetchmodel);
    } catch (e) {
      log(e.toString());
    }
    return returnvalue;
  }
}
