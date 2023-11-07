import 'package:foodie/core/service/http_service.dart';
import 'package:foodie/core/util/enum.dart';
import 'package:foodie/features/orders/data/models/fetchcartmodel.dart';
import 'package:foodie/features/orders/data/repositories/orderRepo.dart';

class orderdatasourceImpl implements OrderDatasource {
  final HttpService httpService;

  orderdatasourceImpl(this.httpService);
  @override
  Future<List<Map<String, dynamic>>> getOrder(
      page, FetchcartModel fetchmodel) async {
    List<Map<String, dynamic>> returnresponse = [];
    final response = await httpService.request(
        url: '/getCart?page=$page&limit=10',
        methodrequest: RequestMethod.post,
        data: fetchcartModelToJson(fetchmodel));
    returnresponse.add(response.data);
    return returnresponse;
  }
}
