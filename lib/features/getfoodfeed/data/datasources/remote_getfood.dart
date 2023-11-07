import 'package:dio/dio.dart';
import 'package:foodie/core/service/http_service.dart';
import 'package:foodie/core/util/enum.dart';
import 'package:foodie/features/getfoodfeed/data/repositories/getfooddatasource.dart';

import '../models/getfoodmodel.dart';
import '../models/specialfood.dart';

class GetfoodDataSourceimp implements GetfoodDataSource {
  final HttpService httpService;

  GetfoodDataSourceimp(this.httpService);

  @override
  Future<List<List>> getDatasource() async {
    List<List> returnresponse = [];
    List<Item> result = [];
    List errorlist = [];
    bool error = false;
    print('getting food from datasource');
    Response response;
    try {
      response = await httpService.request(
          url: '/getItems', methodrequest: RequestMethod.get);
      if (response.statusCode == 200) {
        print('status code: ${response.statusCode}');
        final decodedresponse = GetItem.fromJson(response.data);
        result = decodedresponse.item;
        error = false;
        returnresponse.add(result);
        errorlist.add(error);
        returnresponse.add(errorlist);
      } else {
        print('status code: ${response.statusCode}');
        error = true;
        returnresponse.add(result);
        errorlist.add(error);
        returnresponse.add(errorlist);
      }
    } catch (e) {
      print('status code: ${e.toString()}');
    }

    return returnresponse;
  }

  @override
  Future<List<List>> getcustomfood() async {
    List<List> returnresponse = [];
    List<Msg> result = [];
    List errorlist = [];
    bool error = false;
    final response = await httpService.request(
        url: '/call_offer', methodrequest: RequestMethod.post);
    if (response.statusCode == 200) {
      final decodedresponse = Specialoffer.fromJson(response.data);
      result = decodedresponse.msg;
      error = false;
      returnresponse.add(result);
      errorlist.add(error);
      returnresponse.add(errorlist);
    } else {
      error = true;
      returnresponse.add(result);

      errorlist.add(error);
      returnresponse.add(errorlist);
    }
    return returnresponse;
  }
}
