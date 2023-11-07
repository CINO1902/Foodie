import 'package:foodie/core/service/http_service.dart';
import 'package:foodie/core/util/enum.dart';
import 'package:foodie/features/collecttime%20/data/repositories/gettime_repo.dart';

class GetTimeDatasourceImpl implements GetTimeDatasource {
  final HttpService httpService;

  GetTimeDatasourceImpl(this.httpService);

  @override
  Future<DateTime> getTime() async {
    DateTime date = DateTime.now();

    final response = await httpService.request(
        url: '/gettime', methodrequest: RequestMethod.post);
    date = DateTime.parse(response.data["date"]).toLocal();
    return date;
  }
}
