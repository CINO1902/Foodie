import 'package:foodie/core/service/http_service.dart';
import 'package:foodie/core/util/enum.dart';
import 'package:foodie/features/changeaddress/data/models/changeAddress.dart';
import 'package:foodie/features/changeaddress/data/repositories/changeaddress_repo.dart';

class ChangeAddressimp implements ChangeAddressDataSource {
  final HttpService httpService;

  ChangeAddressimp(this.httpService);

  @override
  Future<List> changeAddress(ChangeAddress change) async {
    List returnresponse = [];

    final response = await httpService.request(
        url: '/updateaddress',
        methodrequest: RequestMethod.post,
        data: changeAddressToJson(change));
    if (response.data['status'] == 'Success') {
      returnresponse.add(false);
      returnresponse.add(response.data['msg']);
    } else {
      returnresponse.add(true);
      returnresponse.add(response.data['msg']);
    }
    return returnresponse;
  }
}
