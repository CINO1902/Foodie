import 'package:foodie/core/service/http_service.dart';
import 'package:foodie/core/util/enum.dart';
import 'package:foodie/features/orderfood/data/repositories/cart_repo.dart';
import 'package:foodie/features/orders/data/models/fetchcartmodel.dart';

class CartDataSourceImpl implements CartDatasource {
  final HttpService httpService;

  CartDataSourceImpl(this.httpService);

  @override
  Future<List<Map<String, dynamic>>> getCart(FetchcartModel fetchmodel) async {
    List<Map<String, dynamic>> returnvalue = [];

    final response = await httpService.request(
        url: '/getCart?page=1&limit=12',
        methodrequest: RequestMethod.post,
        data: fetchcartModelToJson(fetchmodel));
    if (response.statusCode == 200) {}
    returnvalue.add(response.data);
    return returnvalue;
  }

  @override
  Future<List<Map<String, dynamic>>> sendlocation(location) {
    // TODO: implement sendlocation
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> verifycoupon(code) {
    // TODO: implement verifycoupon
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> removecart(id) async {
    List<Map<String, dynamic>> returnvalue = [];

    final response = await httpService.request(
        url: '/removefromcart',
        methodrequest: RequestMethod.post,
        data: {"packageid": id});
    if (response.statusCode == 200) {}
    returnvalue.add(response.data);
    return returnvalue;
      
  }

  @override
  Future<List<Map<String, dynamic>>> removecartspecial(id) async {
    List<Map<String, dynamic>> returnvalue = [];

    final response = await httpService.request(
        url: '/removespecialfromcart',
        methodrequest: RequestMethod.post,
        data: {"packageid": id});
    if (response.statusCode == 200) {}
    returnvalue.add(response.data);
    return returnvalue;
  }
}
