import 'package:foodie/core/service/http_service.dart';
import 'package:foodie/core/util/enum.dart';
import 'package:foodie/features/notification/data/repositories/notification_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationDatasourceImpl implements NotificationDatasource {
  final HttpService httpService;

  NotificationDatasourceImpl(this.httpService);
  @override
  Future<List<Map<String, dynamic>>> notification(page) async {
    List<Map<String, dynamic>> returnresponse = [];

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String email = prefs.getString('email') ?? '';
    httpService.header = {'authorization': 'Bearer $token'};
    final response = await httpService.request(
        url: '/callnotification?page=$page&limit=10',
        methodrequest: RequestMethod.post,
        data: {"email": email});

    returnresponse.add(response.data);

    return returnresponse;
  }
}
