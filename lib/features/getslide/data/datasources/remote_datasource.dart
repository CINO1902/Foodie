import 'package:foodie/core/service/http_service.dart';
import 'package:foodie/core/util/enum.dart';
import 'package:foodie/features/getslide/data/repositories/remote_repositories.dart';

class getslidedatasourceimpl implements SlideDataSource {
  final HttpService httpService;

  getslidedatasourceimpl(this.httpService);
  @override
  Future<List> getSlide() async {
    List<dynamic> result = [];
    List itemsslide = [];
    List linkios = [];
    List linkandroid = [];
    String sucess = '';
    final response = await httpService.request(
        url: '/getimageslider', methodrequest: RequestMethod.get);
    if (response.statusCode == 200) {
      // final decodedresponse = imagesliderFromJson(response.data);
      itemsslide = response.data["item"];
      linkandroid = response.data["linkandroid"];
      linkios = response.data["linkios"];
      sucess = response.data["success"];
      result.add(itemsslide);
      result.add(linkandroid);
      result.add(linkios);
      result.add(sucess);
    } else {
      itemsslide = response.data["item"];
      linkandroid = response.data["linkandroid"];
      linkios = response.data["linkios"];
      sucess = response.data["success"];
      result.add(itemsslide);
      result.add(linkandroid);
      result.add(linkios);
      result.add(sucess);
    }
    return result;
  }
}
