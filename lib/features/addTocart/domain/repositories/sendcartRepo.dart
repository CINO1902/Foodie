import 'dart:developer';

import 'package:foodie/features/addTocart/data/models/cartmodel.dart';
import 'package:foodie/features/addTocart/data/repositories/DatasourceRepo.dart';

abstract class SendCartRepository {
  Future<List> sendcartresponse(CartModel cartModel);
}

class SendcartImp implements SendCartRepository {
  final SendCartDataSource sendCartDataSource;

  SendcartImp(this.sendCartDataSource);

  @override
  Future<List> sendcartresponse(CartModel cartModel) async {
    List result = [];
    try {
      print(cartModel.amount);
      result = await sendCartDataSource.sendcartresponse(cartModel);
      print(result);
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
