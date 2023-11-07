import 'package:foodie/core/exceptions/app_exceptions.dart';
import 'package:foodie/core/service/http_service.dart';
import 'package:foodie/core/util/enum.dart';
import 'package:foodie/features/auth/data/repositories/auth_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final HttpService httpService;

  AuthDatasourceImpl(this.httpService);
  @override
  Future<String> forgetPassword({required String email}) async {
    String result = '';
    final response = await httpService.request(
        url: '/forget-password',
        methodrequest: RequestMethod.post,
        data: {'email': email});
    if (response.statusCode == 200) {
      result = response.data['result'];
    } else {
      CustomException(response.data['error']);
    }
    return result;
  }

  @override
  Future<List> login({required String email, required String password}) async {
    List returnresult = [];

    final response = await httpService.request(
        url: '/login',
        methodrequest: RequestMethod.post,
        data: {"email": email, "password": password});

    if (response.data['success'] == 'true') {
      returnresult.add(response.data['token']);
      returnresult.add(response.data['msg']);
      returnresult.add(false);
      final pref = await SharedPreferences.getInstance();
      pref.setString('tokenregistered', response.data['token']);
    } else {
      returnresult.add(0);
      returnresult.add(response.data['msg']);
      returnresult.add(true);
    }
    print(returnresult);
    return returnresult;
  }

  @override
  Future<String> signup({required String email, required String password}) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
