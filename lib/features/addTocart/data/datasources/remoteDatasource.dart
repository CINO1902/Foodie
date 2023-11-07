import 'package:foodie/core/service/http_service.dart';
import 'package:foodie/core/util/enum.dart';
import 'package:foodie/features/addTocart/data/models/cartmodel.dart';
import 'package:foodie/features/addTocart/data/repositories/DatasourceRepo.dart';

class SendCartDatasourceImpl implements SendCartDataSource {
  final HttpService httpService;

  SendCartDatasourceImpl(this.httpService);

  @override
  Future<List> sendcartresponse(CartModel cartModel) async {
    List<List> returnresponse = [];
    List result = [];
    List errorlist = [];
    bool error = false;

    final response = await httpService.request(
        url: '/addTocart',
        methodrequest: RequestMethod.post,
        data: cartModelToJson(cartModel));

    if (response.data['status'] == 'success') {
      result.clear();
      errorlist.clear();
      returnresponse.clear();

      result.add(response.data['msg']);

      returnresponse.add(result);

      error = false;
      errorlist.add(error);
      returnresponse.add(errorlist);
    } else {
      result.clear();
      errorlist.clear();
      returnresponse.clear();
      result.add(response.data['msg']);
      error = true;
      returnresponse.add(result);
      errorlist.add(error);
      returnresponse.add(errorlist);
    }

    return returnresponse;
  }
}
