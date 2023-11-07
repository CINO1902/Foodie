import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/ExtraModel.dart';
import '../../domain/repositories/Extrafood_Repo.dart';

class GetExtraprovider extends ChangeNotifier {
  final ExtrafoodRepository extrafoodRepository;

  GetExtraprovider(this.extrafoodRepository);
  bool loading = true;
  List soupadded = [];
  bool error = false;
  List foodquote = [];
  List<String> soupid = [];
  List result = [];
  List<ItemExtra> items = [];
  List<ItemExtra> souplist = [];
  CancelToken cancelToken = CancelToken();
  List<List<dynamic>> itemsquote = [];
  Future<void> getExtra(id) async {
    loading = true;
    cancelToken = CancelToken();
    result = await extrafoodRepository.getEstras(cancelToken, id);
    items = result[0];
    soupid.clear();
    error = result[1][0];



    items = items
        .where((element) =>
            element.availability == true || element.remaining == true)
        .toList();

        
    for (var i = 0; i < items.length; i++) {
      var productMap = [
        items[i].itemExtraId,
        int.parse(items[i].mincost),
        1,
        int.parse(items[i].mincost),
        false,
        items[i].item,
        items[i].maxspoon
      ];

      itemsquote.add(productMap);
    }
    souplist = items.where((element) => element.segment == 'soup').toList();
    for (var i = 0; i < souplist.length; i++) {
      soupid.add(souplist[i].itemExtraId);
    }
    loading = false;
    notifyListeners();
  }

  cancelresquest() {
    cancelToken.cancel();
  }
}
