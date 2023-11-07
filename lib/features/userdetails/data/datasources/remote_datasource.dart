import 'package:foodie/core/service/http_service.dart';
import 'package:foodie/core/util/enum.dart';
import 'package:foodie/features/userdetails/data/models/fetchidmodel.dart';
import 'package:foodie/features/userdetails/data/repositories/detailsrepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/exceptions/app_exceptions.dart';

class UserdetaisImp implements UserdetailsDatasource {
  final HttpService httpService;

  UserdetaisImp(this.httpService);

  @override
  Future<int> getId() async {
    int id = 0;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    httpService.header = {'authorization': 'Bearer $token'};
    final response = await httpService.request(
        url: '/fetchid', methodrequest: RequestMethod.get);
    if (response.statusCode == 200) {
      id = response.data['msg']['ID'];
    } else {
      CustomException('Something went wrong');
    }
    return id;
  }

  @override
  Future<String?> getaddress() {
    // TODO: implement getaddress
    throw UnimplementedError();
  }

  @override
  Future<List<Prev>> getregisteredId() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("tokenregistered");
    List<Prev> data = [];
    httpService.header = {'authorization': 'Bearer $token'};
    final response = await httpService.request(
      url: '/fetchidresgitered2',
      methodrequest: RequestMethod.get,
    );

    if (response.data['success'] == 'true') {
      final decodedresponse = FetchIdregisteredModel.fromJson(response.data);
      data = decodedresponse.data.prev;
      prefs.setString('email', decodedresponse.data.prev[0].email ?? '');
    } else {
      CustomException('Something went wrong');
    }
    return data;
  }

  @override
  Future<void> sendtoken(token) {
    // TODO: implement sendtoken
    throw UnimplementedError();
  }
}
