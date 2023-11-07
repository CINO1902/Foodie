import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/service/http_service.dart';
import '../../../../core/util/enum.dart';
import '../repositories/firstcheckrepo.dart';

class Firstcheckdatasoureimpl implements FirscheckDatasource {
  final HttpService httpService;

  Firstcheckdatasoureimpl(this.httpService);
  @override
  Future<List<dynamic>> createnonusertoken() async {
    String result = '';
    String msg = '';
    String token = '';
    List returnvalue = [];

    final response = await httpService.request(
      url: '/createunregistered',
      methodrequest: RequestMethod.post,
    );

    if (response.statusCode == 200) {
      result = response.data['status'];
      msg = response.data['msg'];
      token = response.data['token'];
      returnvalue.add(result);
      returnvalue.add(msg);
      returnvalue.add(token);
    } else {
      result = response.data['status'];
      msg = response.data['msg'];
      returnvalue.add(result);
      returnvalue.add(msg);
      CustomException(response.data['error']);
    }

    return returnvalue;
  }
}
