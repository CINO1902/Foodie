import 'package:foodie/features/addTocart/data/models/cartmodel.dart';

abstract class SendCartDataSource {
    Future<List> sendcartresponse(CartModel cartModel);
}