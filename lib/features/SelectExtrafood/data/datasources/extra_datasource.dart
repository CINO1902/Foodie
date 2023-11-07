import 'package:foodie/core/service/http_service.dart';
import 'package:foodie/features/SelectExtrafood/data/repositories/extrafood_repo.dart';

import '../../../../core/util/enum.dart';
import '../models/ExtraModel.dart';
import '../models/fetchmodel.dart';

class ExtraDatasourceImp implements ExtrafoodDataSource {
  final HttpService httpService;

  ExtraDatasourceImp(this.httpService);

  @override
  Future<List<List>> getEstras(canceltoken, id) async {
    List<List> returnresponse = [];
    List<ItemExtra> result = [];
    List errorlist = [];
    bool error = false;
    ExtrasModelFetch fetch = ExtrasModelFetch(id: id);
    final response = await httpService.request(
        url: '/getItemsExtra2',
        methodrequest: RequestMethod.post,
        data: extrasModelFetchToJson(fetch),
        cancelToken: canceltoken);
    if (response.statusCode == 200) {
      result.clear();
      errorlist.clear();
      returnresponse.clear();
      final decodedresponse = ExtrasModel.fromJson(response.data);
      result = decodedresponse.itemExtra;
      error = false;
      returnresponse.add(result);
      errorlist.add(error);
      returnresponse.add(errorlist);
    } else {
      result.clear();
      errorlist.clear();
      returnresponse.clear();
      error = true;
      returnresponse.add(result);
      errorlist.add(error);
      returnresponse.add(errorlist);
    }
    return returnresponse;
  }
}
