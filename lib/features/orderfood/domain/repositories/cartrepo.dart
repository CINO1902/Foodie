import 'dart:developer';

import 'package:foodie/features/orderfood/data/models/SendCoupon.dart';
import 'package:foodie/features/orderfood/data/models/SendLocation.dart';
import 'package:foodie/features/orderfood/data/repositories/cart_repo.dart';
import 'package:foodie/features/orders/data/models/fetchcartmodel.dart';

abstract class CartRepo {
  Future<List<Map<String, dynamic>>> getCart(FetchcartModel fetchmodel);
  Future<List<Map<String, dynamic>>> sendlocation(Sendlocation location);
  Future<List<Map<String, dynamic>>> verifycoupon(Sendcoupon code);
  Future<List<Map<String, dynamic>>> removecart(id);
  Future<List<Map<String, dynamic>>> removecartspecial(id);
}

class CartRepoImpl implements CartRepo {
  final CartDatasource cartDatasource;

  CartRepoImpl(this.cartDatasource);

  @override
  Future<List<Map<String, dynamic>>> getCart(FetchcartModel fetchmodel) async {
    List<Map<String, dynamic>> returnvalue = [];
    try {
      returnvalue = await cartDatasource.getCart(fetchmodel);
    } catch (e) {
      log(e.toString());
    }
    return returnvalue;
  }

  @override
  Future<List<Map<String, dynamic>>> sendlocation(Sendlocation location) async {
    List<Map<String, dynamic>> returnvalue = [];
    try {
      returnvalue = await cartDatasource.sendlocation(location);
    } catch (e) {
      log(e.toString());
    }
    return returnvalue;
  }

  @override
  Future<List<Map<String, dynamic>>> verifycoupon(Sendcoupon code) async {
    List<Map<String, dynamic>> returnvalue = [];
    try {
      returnvalue = await cartDatasource.verifycoupon(code);
    } catch (e) {
      log(e.toString());
    }
    return returnvalue;
  }

  @override
  Future<List<Map<String, dynamic>>> removecart(id) async {
    List<Map<String, dynamic>> returnvalue = [];
    try {
      returnvalue = await cartDatasource.removecart(id);
    } catch (e) {
      log(e.toString());
    }
    return returnvalue;
  }

  @override
  Future<List<Map<String, dynamic>>> removecartspecial(id) async {
    List<Map<String, dynamic>> returnvalue = [];
    try {
      returnvalue = await cartDatasource.removecartspecial(id);
    } catch (e) {
      log(e.toString());
    }
    return returnvalue;
  }
}
